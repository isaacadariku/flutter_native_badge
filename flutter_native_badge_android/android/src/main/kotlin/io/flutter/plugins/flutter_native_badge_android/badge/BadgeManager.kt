package io.flutter.plugins.flutter_native_badge_android.badge

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.util.Log
import io.flutter.plugins.flutter_native_badge_android.badge.impl.HuaweiBadge

/**
 * Updates the app icon badge.
 *
 * Android has no public API for setting an app icon badge count. Launchers
 * that expose their own badge API (Huawei, Honor) are updated directly. On all
 * other launchers the badge comes from [NotificationBadge].
 */
object BadgeManager {

    private const val TAG = "FlutterNativeBadge"

    private val launcherBadges: List<IBadge> = listOf(
        HuaweiBadge.huawei,
        HuaweiBadge.honor
    )

    @Volatile
    private var resolved = false
    private var launcherBadge: IBadge? = null

    /** Returns the launcher badge API that supports [launcherPackage], if any. */
    fun badgeForLauncher(launcherPackage: String): IBadge? =
        launcherBadges.firstOrNull { launcherPackage in it.getSupportLaunchers() }

    fun updateBadge(context: Context, count: Int) {
        val launcherBadge = resolveLauncherBadge(context)
        if (launcherBadge != null) {
            try {
                launcherBadge.updateBadge(context, count)
                return
            } catch (e: Exception) {
                Log.w(TAG, "Launcher badge API failed, falling back to a notification", e)
            }
        }
        NotificationBadge.updateBadge(context, count)
    }

    private fun resolveLauncherBadge(context: Context): IBadge? {
        if (!resolved) {
            synchronized(this) {
                if (!resolved) {
                    launcherBadge = findLauncherBadge(context)
                    resolved = true
                }
            }
        }
        return launcherBadge
    }

    private fun findLauncherBadge(context: Context): IBadge? {
        val launcherPackage = defaultLauncherPackage(context) ?: return null
        val badge = badgeForLauncher(launcherPackage)
        if (badge != null) {
            Log.d(TAG, "Using the launcher badge API of $launcherPackage")
        }
        return badge
    }

    private fun defaultLauncherPackage(context: Context): String? {
        val intent = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME)
        return context.packageManager
            .resolveActivity(intent, PackageManager.MATCH_DEFAULT_ONLY)
            ?.activityInfo?.packageName
    }
}
