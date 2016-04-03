package com.sybus.android.userapp.presenter;

import android.content.Context;

import org.json.JSONException;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public interface AccountPresenter {
    public void createAccount(String fname, String lname, String email, String password);
    public void logout();
    public void activate(String email, int code);
    public void reSendCode(String email);
    public void setContext(Context context);
    public void sendResetCode(String email);
    public void validateResetCode(int code);
    public void resetPassword(String password) throws JSONException;
}
