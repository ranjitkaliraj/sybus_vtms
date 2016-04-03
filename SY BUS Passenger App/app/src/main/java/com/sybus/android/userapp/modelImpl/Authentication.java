package com.sybus.android.userapp.modelImpl;

import android.content.Context;

import com.sybus.android.userapp.util.UserDataCacheManager;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 */
public class Authentication {
    private String username;
    private String password;
    private String[] userData;
    public Authentication(){
        username = "";
        password = "";
        userData = new String[]{"Ranjit Kaliraj", "12345", "ranjit.kaliraj@gmail.com"};
    }

    public static Authentication getInstance(){
        Authentication a = new Authentication();
        return a;
    }

    public boolean authenticateUser(Context context, String username, String password){
        this.username = username;
        this.password = password;
        if (username.equals(userData[0]) && password.equals(userData[1])){
            //LoginView successful
            UserDataCacheManager.storeUserDataCache(context, username, password, userData[2]);
            return true;
        }
        else{
            return false;
        }
    }

    public String[] getUserData(){
        String[] data = new String[] {"Ranjit, Kaliraj", "ranjit.kaliraj@gmail.com"};
        return data;
    }

    public void logout(Context context){
        UserDataCacheManager.storeUserDataCache(context, "", "", "");
    }
}
