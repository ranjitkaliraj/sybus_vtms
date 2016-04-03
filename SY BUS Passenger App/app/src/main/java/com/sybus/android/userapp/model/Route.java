package com.sybus.android.userapp.model;

import com.sybus.android.userapp.presenterListener.RouteViewPresenterListener;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface Route {
    public void getRouteList(RouteViewPresenterListener listener);
    public void getLatLng(String routeName, RouteViewPresenterListener listener);
    public void getRouteList(SearchPresenterListener listener);
}
