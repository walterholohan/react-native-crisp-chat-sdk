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

import com.reactnativecrispchatsdk.parsers.CompanyParser

@ReactModule(name = NativeCrispModule.NAME)
class NativeCrispModule(reactContext: ReactApplicationContext) : NativeCrispModuleSpec(reactContext) {

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

    override fun setUserCompany(companyMap: ReadableMap) {
        val company = CompanyParser.fromReadableMap(companyMap)
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

    override fun pushSessionEvents(events: ReadableArray){
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


    override fun resetSession() {
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
