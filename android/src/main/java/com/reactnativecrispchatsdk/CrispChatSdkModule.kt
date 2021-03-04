package com.reactnativecrispchatsdk

import android.content.Intent
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import im.crisp.client.ChatActivity
import im.crisp.client.Crisp


class CrispChatSdkModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "CrispChatSdk"
    }

    @ReactMethod
    fun show() {
        val context = reactApplicationContext
        val crispIntent = Intent(context, ChatActivity::class.java)
        crispIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(crispIntent)
    }

    @ReactMethod
    fun setUserEmail(email: String) {
        Crisp.setUserEmail(email)
    }

    @ReactMethod
    fun setUserNickname(name: String) {
        Crisp.setUserNickname(name)
    }

    @ReactMethod
    fun resetSession() {
        val context = reactApplicationContext
        Crisp.resetChatSession(context)
    }
}
