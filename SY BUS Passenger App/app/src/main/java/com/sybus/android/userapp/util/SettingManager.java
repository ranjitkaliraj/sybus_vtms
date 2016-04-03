package com.sybus.android.userapp.util;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 1/5/2016.
 */
public class SettingManager {
    public static final String user_Setting = "USER_SETTING_FILE";

    //this function store the user data to the shared preference file
    public static void storeRange(Context context, String range){
        SharePreferenceManager.saveToPreference(context, "range", range, user_Setting);
    }

    //this function get the userData information in the form of array stored in shared perference
    public static int getRange(Context context){
        String range = SharePreferenceManager.readFromPreference(context, "range","2000",user_Setting);
        int r = Integer.parseInt(range);
        return r;
    }
}
