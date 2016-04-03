package com.sybus.android.userapp.model;

import com.sybus.android.userapp.presenterListener.DestinationPresenterListener;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface Destination {
    public void validateDestination(String criteria, DestinationPresenterListener listener);
    public void getDestinationSuggestion(String criteria, DestinationPresenterListener listener);
}
