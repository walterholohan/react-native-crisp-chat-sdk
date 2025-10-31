package com.reactnativecrispchatsdk

import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.ReadableArray

fun ReadableMap.getStringOrNull(key: String): String? =
    if (hasKey(key) && !isNull(key)) getString(key) else null

fun ReadableMap.getMapOrNull(key: String): ReadableMap? =
    if (hasKey(key) && !isNull(key)) getMap(key) else null

fun ReadableMap.getArrayOrNull(key: String): ReadableArray? =
    if (hasKey(key) && !isNull(key)) getArray(key) else null

fun ReadableMap.getDoubleOrNull(key: String): Double? =
    if (hasKey(key) && !isNull(key)) getDouble(key) else null

fun ReadableMap.getIntOrNull(key: String): Int? =
    if (hasKey(key) && !isNull(key)) getInt(key) else null

fun ReadableMap.getBooleanOrNull(key: String): Boolean? =
    if (hasKey(key) && !isNull(key)) getBoolean(key) else null
