package com.reactnativecrispchatsdk

import android.content.Intent
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.Promise
import com.facebook.react.module.annotations.ReactModule

import im.crisp.client.external.ChatActivity
import im.crisp.client.external.Crisp
import im.crisp.client.external.data.SessionEvent
import im.crisp.client.external.data.SessionEvent.Color

import im.crisp.client.external.data.Company
import im.crisp.client.external.data.Employment
import im.crisp.client.external.data.Geolocation
import java.net.URL

class CrispChatSdkModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

@ReactModule(name = CrispChatSdkModule.NAME)
class CrispChatSdkModule(reactContext: ReactApplicationContext) : NativeCrispModuleSpec(reactContext) {

    override fun getName() = NAME

    override fun configure(websiteId: String) {
        val context = reactApplicationContext
        Crisp.configure(context, websiteId)
    }

    override fun setTokenId(tokenId: String?){
        val context = reactApplicationContext
        Crisp.setTokenID(context, tokenId)
    }

    override fun setUserEmail(email: String, signature: String?) {
        Crisp.setUserEmail(email, signature)
    }

    override fun setUserNickname(name: String) {
        Crisp.setUserNickname(name)
    }

    override fun setUserPhone(phone: String){
        Crisp.setUserPhone(phone)
    }

    @ReactMethod
    fun setUserCompany(companyMap: ReadableMap) {
        val companyName = companyMap.getString("name")

        var companyUrl: URL? = null
        if (companyMap.hasKey("url") && !companyMap.isNull("url")) {
            val urlString = companyMap.getString("url")
            if (urlString != null && urlString.isNotEmpty()) {
                companyUrl = URL(urlString)
            }
        }

        val companyDescription = if (companyMap.hasKey("companyDescription")) {
            companyMap.getString("companyDescription")
        } else null

        var employment: Employment? = null
        if (companyMap.hasKey("employment") && !companyMap.isNull("employment")) {
            val employmentMap = companyMap.getMap("employment")
            val title = employmentMap?.getString("title")
            val role = employmentMap?.getString("role")
            employment = Employment(title, role)
        }

        var geolocation: Geolocation? = null
        if (companyMap.hasKey("geolocation") && !companyMap.isNull("geolocation")) {
            val geoMap = companyMap.getMap("geolocation")
            val city = geoMap?.getString("city")
            val country = geoMap?.getString("country")
            geolocation = Geolocation(city, country)
        }

        val company = Company(companyName, companyUrl, companyDescription, employment, geolocation)

        Crisp.setUserCompany(company)
    }

    override fun setUserAvatar(url: String){
        Crisp.setUserAvatar(url)
    }

    override fun setSessionSegment(segment: String){
        Crisp.setSessionSegment(segment)
    }

    override fun setSessionSegments(segments: ReadableArray, overwrite: Boolean){
        val segmentsList = mutableListOf<String>()
        for (i in 0 until segments.size()) {
            segmentsList.add(segments.getString(i) ?: "")
        }
        Crisp.setSessionSegments(segmentsList, overwrite)
    }

    override fun setSessionString(key: String, value: String){
        Crisp.setSessionString(key, value)
    }

    override fun setSessionBool(key: String, value: Boolean){
        Crisp.setSessionBool(key, value)
    }

    override fun setSessionInt(key: String, value: Double){
        Crisp.setSessionInt(key, value.toInt())
    }

    override fun getSessionIdentifier(promise: Promise) {
        val context = reactApplicationContext
        val identifier = Crisp.getSessionIdentifier(context)
        promise.resolve(identifier)
    }

    override fun pushSessionEvent(name: String, color: Double){
      var sessionEventColor: Color = Color.BLACK

      when(color.toInt()){
        0->sessionEventColor= Color.RED
        1->sessionEventColor= Color.ORANGE
        2->sessionEventColor= Color.YELLOW
        3->sessionEventColor= Color.GREEN
        4->sessionEventColor= Color.BLUE
        5->sessionEventColor= Color.PURPLE
        6->sessionEventColor= Color.PINK
        7->sessionEventColor= Color.BROWN
        8->sessionEventColor= Color.GREY
        9->sessionEventColor= Color.BLACK
      }

      Crisp.pushSessionEvent(SessionEvent(
        name,
        sessionEventColor
      ))
    }

    @ReactMethod
    fun pushSessionEvents(events: ReadableArray){
        val eventsList = mutableListOf<SessionEvent>()
        
        for (i in 0 until events.size()) {
            val event = events.getMap(i)
            val name = event?.getString("name") ?: ""
            val color = event?.getInt("color") ?: 9
            var sessionEventColor: Color = Color.BLACK
            when(color){
                0->sessionEventColor= Color.RED
                1->sessionEventColor= Color.ORANGE
                2->sessionEventColor= Color.YELLOW
                3->sessionEventColor= Color.GREEN
                4->sessionEventColor= Color.BLUE
                5->sessionEventColor= Color.PURPLE
                6->sessionEventColor= Color.PINK
                7->sessionEventColor= Color.BROWN
                8->sessionEventColor= Color.GREY
                9->sessionEventColor= Color.BLACK
            }
            eventsList.add(SessionEvent(name, sessionEventColor))
        }
        Crisp.pushSessionEvents(eventsList)
    }


    @ReactMethod
    fun resetSession() {
        val context = reactApplicationContext
        Crisp.resetChatSession(context)
    }

    override fun show() {
        val context = reactApplicationContext
        val crispIntent = Intent(context, ChatActivity::class.java)
        crispIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(crispIntent)
    }

    override fun searchHelpdesk() {
        val context = reactApplicationContext
        Crisp.searchHelpdesk(context)
    }

    override fun openHelpdeskArticle(id: String, locale: String, title: String?, category: String?) {
        val context = reactApplicationContext
        Crisp.openHelpdeskArticle(context, id, locale, title, category)
    }

    override fun runBotScenario(scenarioId: String) {
        Crisp.runBotScenario(scenarioId)
    }

    companion object {
        const val NAME = "NativeCrispModule"
    }
}
