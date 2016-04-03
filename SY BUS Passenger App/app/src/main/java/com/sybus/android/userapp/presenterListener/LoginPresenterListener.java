package com.sybus.android.userapp.presenterListener;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 12/26/2015.
 */
public interface LoginPresenterListener {

    public void onLoginSuccess(String name, String email, String auth_Key);
    public void onLoginServerError();
    public void onInvalidLogin();
    public Context getContext();

    public void onAccountIsActivated(String name, String email, String auth_key);
    public void onAccountIsNotActivated(int status);
}