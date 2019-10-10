package com.axonactive.demomvvm;

import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;

import com.axonactive.demomvvm.utils.Constants;

public class MainApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();

        createDummyUserData();
    }

    private void createDummyUserData() {
        SharedPreferences pref = getApplicationContext().getSharedPreferences(Constants.PREFS_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(Constants.PREF_USER_NAME, "aaa@aaa.com");
        editor.putString(Constants.PREF_PASSWORD, "111111");
        editor.apply();
    }
}
