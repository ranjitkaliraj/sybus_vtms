package com.sybus.android.userapp.presenter;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public interface QueryPresenter {
    public void submitQuery(String subject, String message, String email);
    public void setContext(Context context);
}
