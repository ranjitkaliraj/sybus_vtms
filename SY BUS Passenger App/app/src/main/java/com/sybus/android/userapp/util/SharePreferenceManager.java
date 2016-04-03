package com.sybus.android.userapp.util;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 */
public class SharePreferenceManager {

    public static SharePreferenceManager getInstance(){
        SharePreferenceManager spm = new SharePreferenceManager();
        return spm;
    }

    //this method save to preference.
    //must pass applicationContext here
    public static void saveToPreference(Context context, String preference_Name, String preference_value,String PREF_FILE_NAME) {
        SharedPreferences sharedPreference = context.getSharedPreferences(PREF_FILE_NAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreference.edit();
        editor.putString(preference_Name, String.valueOf(preference_value));
        editor.apply();
    }

    //this method read the preference.
    public static String readFromPreference(Context context, String preference_Name, String defaultValue, String PREF_FILE_NAME) {
        SharedPreferences sharedPreference = context.getSharedPreferences(PREF_FILE_NAME, Context.MODE_PRIVATE);
        return sharedPreference.getString(preference_Name, defaultValue);
    }
}
