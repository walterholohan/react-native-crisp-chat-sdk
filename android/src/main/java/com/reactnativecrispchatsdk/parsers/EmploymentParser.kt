package com.reactnativecrispchatsdk.parsers

import com.facebook.react.bridge.ReadableMap
import com.reactnativecrispchatsdk.getStringOrNull
import im.crisp.client.external.data.Employment

/**
 * Parser for Employment objects from JavaScript
 * Converts ReadableMap to Crisp SDK Employment class
 *
 * TypeScript interface:
 * interface Employment {
 *   title?: string;
 *   role?: string;
 * }
 */
object EmploymentParser {
    fun fromReadableMap(map: ReadableMap): Employment {
        val title = map.getStringOrNull("title")
        val role = map.getStringOrNull("role")
        return Employment(title, role)
    }
}
