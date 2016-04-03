package com.sybus.android.userapp.presenterListener;

import android.content.Context;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface DestinationPresenterListener {
    public void onValidationSuccess();
    public void onValidationFailed();
    public void returnSuggestionList(ArrayList<String> data);
    public void onSuggestionNotFound();
    public void onErrorOccured();
    public Context getContext();
}
