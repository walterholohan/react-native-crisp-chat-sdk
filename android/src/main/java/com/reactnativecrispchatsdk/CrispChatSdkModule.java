package com.reactnativecrispchatsdk;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;


import im.crisp.sdk.Crisp;

public class CrispChatSdkModule extends ReactContextBaseJavaModule {

  private static ReactApplicationContext reactContext;

  public CrispChatSdkModule(ReactApplicationContext context) {
    super(context);
    reactContext = context;
  }

  @ReactMethod
  public void setEmail(String email) {
    Crisp.User.setEmail(email);
  }

  @Override
  public String getName() {
    return "CrispChatSdk";
  }
}
