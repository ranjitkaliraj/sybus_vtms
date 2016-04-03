package com.sybus.android.userapp.view;

import android.support.v4.app.FragmentActivity;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/3/2016.
 */
public interface SearchView {
    public void showProgressBar(String message);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
    public void displaySearchViewLoadingIndicator();
    public void hideSearchViewLoadingIndicator();
    public void setSuggestionResult(ArrayList<String> data);

    public void findVehicles();

    public void displayRouteSearchOption(ArrayList<String> routes);
    public void displayBusStopSearchOption(ArrayList<String> stops);
}
