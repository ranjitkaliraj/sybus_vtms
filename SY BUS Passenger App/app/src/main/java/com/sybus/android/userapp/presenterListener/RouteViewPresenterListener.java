package com.sybus.android.userapp.presenterListener;

import android.content.Context;

import com.sybus.android.userapp.pojo.LngLat;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 2/28/2016.
 */
public interface RouteViewPresenterListener {
    public void onRouteListAvailable(ArrayList<String> routes);
    public void onRouteListNotAvailable();
    public Context getContext();
    public void onRouteCoordinatesFound(ArrayList<LngLat> data);
    public void onRouteCoordinatesNotFound();
}
