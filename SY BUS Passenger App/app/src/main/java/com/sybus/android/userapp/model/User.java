package com.sybus.android.userapp.model;

import com.sybus.android.userapp.presenterListener.AccountPresenterListener;
import com.sybus.android.userapp.presenterListener.LoginPresenterListener;
import com.sybus.android.userapp.presenterListener.QueryPresenterListener;

import org.json.JSONException;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface User {
    public void login(String username, String password, final LoginPresenterListener listener);
    public void logout(String auth_key, final AccountPresenterListener listener);
    public void loginAfterAccountCreate(String username, String password, final AccountPresenterListener listener);
    public void submitQuery(String subject, String email, String message, final QueryPresenterListener listener) throws JSONException;
    public void createAccount(String fName, String lName, String email, String password, final AccountPresenterListener listener) throws JSONException;
    public void activateAccount(String email, int code, final AccountPresenterListener listener);
    public void checkAccountActivation(final String name, final String email, final String auth_key, final LoginPresenterListener listener);
    public void reSendActivationCode(String email, final AccountPresenterListener listener);

    public void validateUserEmail(String email, final AccountPresenterListener listener);
    public void requestToResetCode(String email, final AccountPresenterListener listener);
    public void validateResetCode(int code, final AccountPresenterListener listener);
    public void resetPassword(String email, String password, final AccountPresenterListener listener) throws JSONException;
}
