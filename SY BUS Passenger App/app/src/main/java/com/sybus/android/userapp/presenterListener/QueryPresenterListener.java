package com.sybus.android.userapp.presenterListener;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public interface QueryPresenterListener {
    public void onQuerySubmitSuccess();
    public void onQuerySubmitError();
    public Context getContext();
}
