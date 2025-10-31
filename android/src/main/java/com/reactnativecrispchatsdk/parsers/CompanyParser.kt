package com.reactnativecrispchatsdk.parsers

import com.facebook.react.bridge.ReadableMap
import com.reactnativecrispchatsdk.getStringOrNull
import com.reactnativecrispchatsdk.getMapOrNull
import im.crisp.client.external.data.Company
import java.net.URL

/**
 * Parser for Company objects from JavaScript
 * Converts ReadableMap to Crisp SDK Company class
 *
 * TypeScript interface:
 * interface Company {
 *   name: string;
 *   url?: string;
 *   companyDescription?: string;
 *   employment?: Employment;
 *   geolocation?: Geolocation;
 * }
 */
object CompanyParser {
    fun fromReadableMap(map: ReadableMap): Company {
        val name = map.getString("name") ?: ""

        val url = map.getStringOrNull("url")?.takeIf { it.isNotEmpty() }?.let {
            try {
                URL(it)
            } catch (e: Exception) {
                null
            }
        }

        val companyDescription = map.getStringOrNull("companyDescription")

        val employment = map.getMapOrNull("employment")?.let {
            EmploymentParser.fromReadableMap(it)
        }

        val geolocation = map.getMapOrNull("geolocation")?.let {
            GeolocationParser.fromReadableMap(it)
        }

        return Company(name, url, companyDescription, employment, geolocation)
    }
}
