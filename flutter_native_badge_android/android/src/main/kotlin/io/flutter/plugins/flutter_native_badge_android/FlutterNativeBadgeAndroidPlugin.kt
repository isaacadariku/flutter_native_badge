package io.flutter.plugins.flutter_native_badge_android

import android.Manifest
import android.content.Context
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.flutter_native_badge_android.badge.BadgeManager

class FlutterNativeBadgeAndroidPlugin :
    FlutterPlugin,
    ActivityAware,
    PluginRegistry.RequestPermissionsResultListener,
    FlutterNativeBadgeApi {

    private lateinit var context: Context
    private var activityBinding: ActivityPluginBinding? = null
    private val pendingPermissionCallbacks = mutableListOf<(Result<Unit>) -> Unit>()

    companion object {
        private const val PREFS_NAME = "flutter_native_badge_prefs"
        private const val KEY_BADGE_COUNT = "badge_count"
        private const val PERMISSION_REQUEST_CODE = 0x0BAD6E

        /** Clamps a Dart `int` to a valid, non-negative badge count. */
        internal fun toBadgeCount(count: Long): Int =
            count.coerceIn(0L, Int.MAX_VALUE.toLong()).toInt()
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        FlutterNativeBadgeApi.setUp(binding.binaryMessenger, this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        FlutterNativeBadgeApi.setUp(binding.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activityBinding?.removeRequestPermissionsResultListener(this)
        activityBinding = null
        completePermissionRequests()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) =
        onAttachedToActivity(binding)

    override fun onDetachedFromActivityForConfigChanges() = onDetachedFromActivity()

    private val prefs: SharedPreferences
        get() = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    // Badges are shown through a notification on most launchers, which needs the
    // POST_NOTIFICATIONS runtime permission on Android 13+.
    override fun requestPermission(callback: (Result<Unit>) -> Unit) {
        val activity = activityBinding?.activity
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU ||
            activity == null ||
            context.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) ==
            PackageManager.PERMISSION_GRANTED
        ) {
            callback(Result.success(Unit))
            return
        }

        pendingPermissionCallbacks.add(callback)
        if (pendingPermissionCallbacks.size == 1) {
            activity.requestPermissions(
                arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                PERMISSION_REQUEST_CODE
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        if (requestCode != PERMISSION_REQUEST_CODE) return false
        completePermissionRequests()
        return true
    }

    // Like iOS, a denied permission is not an error: the badge just isn't shown.
    private fun completePermissionRequests() {
        val callbacks = pendingPermissionCallbacks.toList()
        pendingPermissionCallbacks.clear()
        callbacks.forEach { it(Result.success(Unit)) }
    }

    // Launchers can't be queried for the current badge, so return the last value set.
    override fun getBadgeCount(): Long {
        return prefs.getInt(KEY_BADGE_COUNT, 0).toLong()
    }

    override fun setBadgeCount(count: Long) {
        updateBadge(toBadgeCount(count))
    }

    override fun clearBadgeCount() {
        updateBadge(0)
    }

    // Android launchers can't show a dot without a count, so show a count of 1.
    override fun showRedDot() {
        updateBadge(1)
    }

    private fun updateBadge(count: Int) {
        prefs.edit().putInt(KEY_BADGE_COUNT, count).apply()
        BadgeManager.updateBadge(context, count)
    }
}
