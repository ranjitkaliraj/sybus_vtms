package com.sybus.android.userapp.presenter;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 12/26/2015.
 */
public interface LoginPresenter {
    public void validateCredentials(String username, String password);
    public void setContext(Context context);
}
