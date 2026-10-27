package io.flutter.plugins.flutter_native_badge_android.badge

import android.content.Context

interface IBadge {
    fun updateBadge(context: Context, count: Int)
    fun getSupportLaunchers(): List<String>
}
