package com.sybus.android.userapp.presenterListener;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public interface AccountPresenterListener {
    public void onAccountCreateSuccess(String username, String password);
    public void onAccountCreateFailed(int reason);
    public void onLoginSuccess(String username, String email, String auth_key);
    public void onLoginServerError();
    public Context getContext();
    public void onLogoutSuccess();
    public void onActivationSuccess();
    public void onActivationFailed(int reason);
    public void onResetCodeReSendSuccess();
    public void onResetCodeReSendFailed();

    public void onValidateEmailForResetPasswordSuccess(String email);
    public void onValidateEmailForResetPasswordFailed(String message);
    public void onResetPasswordRequestSuccess();
    public void onResetPasswordRequestFailed();
    public void onValidateResetCodeForResetPasswordSuccess();
    public void onValidateResetCodeForResetPasswordFailed(String message);
    public void onResetPasswordSuccess(String email, String password);
    public void onResetPasswordFailed(String message);
}
