package com.sybus.android.userapp.view;

import com.sybus.android.userapp.pojo.LngLat;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 2/28/2016.
 */
public interface RouteView {
    public void displayRouteLists(ArrayList<String> list);
    public void displayMap(ArrayList<LngLat> data);
    public void displayNoRouteMessage();
    public void showProgressBar(String message);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
}
