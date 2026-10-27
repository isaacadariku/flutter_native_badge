package io.flutter.plugins.flutter_native_badge_android.badge

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.os.Build
import android.util.Log

/**
 * Shows the badge through a silent notification that carries the count.
 *
 * Most Android launchers (Samsung One UI, Pixel, Xiaomi, OPPO, vivo, ...) only
 * badge an app icon while the app has an active notification, so this is the
 * only way to badge the icon on those devices.
 */
internal object NotificationBadge {

    private const val TAG = "FlutterNativeBadge"
    private const val CHANNEL_ID = "flutter_native_badge"
    private const val NOTIFICATION_ID = 0x0BAD6E

    fun updateBadge(context: Context, count: Int) {
        // Launchers only badge from notifications since notification channels (API 26).
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return

        val notificationManager = context.getSystemService(NotificationManager::class.java)
        if (count == 0) {
            notificationManager.cancel(NOTIFICATION_ID)
            return
        }
        if (!notificationManager.areNotificationsEnabled()) {
            Log.w(TAG, "Notifications are disabled; call requestPermission() to show the badge")
            return
        }

        notificationManager.createNotificationChannel(
            NotificationChannel(CHANNEL_ID, "App icon badge", NotificationManager.IMPORTANCE_MIN).apply {
                setShowBadge(true)
                setSound(null, null)
                enableVibration(false)
            }
        )

        val appInfo = context.applicationInfo
        val notification = Notification.Builder(context, CHANNEL_ID)
            .setSmallIcon(appInfo.icon)
            .setContentTitle(context.packageManager.getApplicationLabel(appInfo))
            .setNumber(count)
            .setBadgeIconType(Notification.BADGE_ICON_SMALL)
            .setShowWhen(false)
            .setOnlyAlertOnce(true)
            .setAutoCancel(true)
            .setContentIntent(launchIntent(context))
            .build()
        notificationManager.notify(NOTIFICATION_ID, notification)
    }

    private fun launchIntent(context: Context): PendingIntent? {
        val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
            ?: return null
        return PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_IMMUTABLE)
    }
}
