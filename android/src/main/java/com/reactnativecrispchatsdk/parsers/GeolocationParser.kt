package com.reactnativecrispchatsdk.parsers

import com.facebook.react.bridge.ReadableMap
import com.reactnativecrispchatsdk.getStringOrNull
import im.crisp.client.external.data.Geolocation

/**
 * Parser for Geolocation objects from JavaScript
 * Converts ReadableMap to Crisp SDK Geolocation class
 *
 * TypeScript interface:
 * interface Geolocation {
 *   country?: string;
 *   city?: string;
 * }
 */
object GeolocationParser {
    fun fromReadableMap(map: ReadableMap): Geolocation {
        val country = map.getStringOrNull("country")
        val city = map.getStringOrNull("city")
        return Geolocation(country, city)
    }
}
