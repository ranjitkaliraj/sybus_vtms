package com.sybus.android.userapp.presenter;

import android.content.Context;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface DestinationPresenter {
    public void setContext(Context context);
    public void validate(String destination);
    public void searchSuggestion(String suggestion);
}
