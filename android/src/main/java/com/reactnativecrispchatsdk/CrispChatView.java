package com.reactnativecrispchatsdk;

import android.content.Context;
import android.widget.LinearLayout;

public class CrispChatView extends LinearLayout {

  public CrispChatView(Context context) {
    super(context);
    inflate(context, R.layout.crispwindow, this);
  }
}

