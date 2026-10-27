package io.flutter.plugins.flutter_native_badge_android.badge.impl

import android.content.Context
import android.net.Uri
import android.os.Bundle
import io.flutter.plugins.flutter_native_badge_android.badge.IBadge

/**
 * Sets the badge through the launcher badge provider that Huawei (EMUI) and
 * Honor (MagicOS) launchers expose to third-party apps.
 */
class HuaweiBadge private constructor(
    private val providerUri: String,
    private val launchers: List<String>
) : IBadge {

    companion object {
        val huawei = HuaweiBadge(
            "content://com.huawei.android.launcher.settings/badge/",
            listOf("com.huawei.android.launcher")
        )
        val honor = HuaweiBadge(
            "content://com.hihonor.android.launcher.settings/badge/",
            listOf("com.hihonor.android.launcher")
        )
    }

    override fun updateBadge(context: Context, count: Int) {
        val launchIntent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        val className = launchIntent?.component?.className
            ?: throw IllegalStateException("App has no launcher activity")

        val extras = Bundle().apply {
            putString("package", context.packageName)
            putString("class", className)
            putInt("badgenumber", count)
        }
        context.contentResolver.call(Uri.parse(providerUri), "change_badge", null, extras)
    }

    override fun getSupportLaunchers(): List<String> = launchers
}
