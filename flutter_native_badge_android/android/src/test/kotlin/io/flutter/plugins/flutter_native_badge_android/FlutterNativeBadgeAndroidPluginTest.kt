package io.flutter.plugins.flutter_native_badge_android

import io.flutter.plugins.flutter_native_badge_android.badge.BadgeManager
import io.flutter.plugins.flutter_native_badge_android.badge.impl.HuaweiBadge
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull
import kotlin.test.assertSame

class FlutterNativeBadgeAndroidPluginTest {

    @Test
    fun toBadgeCount_keepsValidCounts() {
        assertEquals(0, FlutterNativeBadgeAndroidPlugin.toBadgeCount(0))
        assertEquals(42, FlutterNativeBadgeAndroidPlugin.toBadgeCount(42))
    }

    @Test
    fun toBadgeCount_clampsOutOfRangeCounts() {
        assertEquals(0, FlutterNativeBadgeAndroidPlugin.toBadgeCount(-5))
        assertEquals(Int.MAX_VALUE, FlutterNativeBadgeAndroidPlugin.toBadgeCount(Long.MAX_VALUE))
    }

    @Test
    fun badgeForLauncher_usesLauncherApiOnHuaweiAndHonor() {
        assertSame(HuaweiBadge.huawei, BadgeManager.badgeForLauncher("com.huawei.android.launcher"))
        assertSame(HuaweiBadge.honor, BadgeManager.badgeForLauncher("com.hihonor.android.launcher"))
    }

    @Test
    fun badgeForLauncher_returnsNullForNotificationBadgedLaunchers() {
        assertNull(BadgeManager.badgeForLauncher("com.sec.android.app.launcher"))
        assertNull(BadgeManager.badgeForLauncher("com.google.android.apps.nexuslauncher"))
        assertNull(BadgeManager.badgeForLauncher("com.miui.home"))
    }
}
