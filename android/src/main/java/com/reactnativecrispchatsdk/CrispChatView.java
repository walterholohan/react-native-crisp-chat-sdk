package com.reactnativecrispchatsdk;

import android.content.Context;
import android.widget.LinearLayout;

import android.os.Bundle;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.reactnativecrispchatsdk.R;
import im.crisp.sdk.ui.CrispFragment;

public class CrispChatView extends LinearLayout {

  public CrispChatView(Context context) {
    super(context);
    inflate(context, R.layout.crispwindow, this);
    Fragment fragment = new CrispFragment();
    FragmentManager fm = getFragmentManager();
    FragmentTransaction ft = fm.beginTransaction();
    ft.replace(R.id.fl_crisp_container, fragment);
    ft.commit();
  }
}

