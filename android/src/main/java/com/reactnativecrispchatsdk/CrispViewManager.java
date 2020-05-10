package com.reactnativecrispchatsdk;

import android.view.View;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

public class CrispViewManager extends SimpleViewManager<View> {

  public static final String REACT_CLASS = "CrispView";

  @Override
  public String getName() { return REACT_CLASS; }

  @Override
  public CrispChatView createViewInstance(ThemedReactContext context) {
    return new CrispChatView(context);
  }
}
