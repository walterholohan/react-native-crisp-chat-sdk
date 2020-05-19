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
  public void setUserEmail(String email) {
    Crisp.User.setEmail(email);
  }

  @ReactMethod
  public void setUserNickname(String name) {
    Crisp.User.setNickname(name);
  }

  @ReactMethod
  public void setUserPhone(String phone) {
    Crisp.User.setPhone(phone);
  }

  @ReactMethod
  public void setUserAvatar(String url) {
    Crisp.User.setAvatar(url);
  }

  @ReactMethod
  public void setSessionSegment(String segment) {
    Crisp.Session.setSegments(segment);
  }

  @ReactMethod
  public void resetSession() {
    Crisp.Session.reset();
  }

  @Override
  public String getName() {
    return "CrispChatSdk";
  }
}
