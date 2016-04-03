package com.sybus.android.userapp.presenter;

import android.content.Context;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 2/28/2016.
 */
public interface RouteViewPresenter {
    public void getAvailableRouteList();
    public void getRouteCoordinates(String name);
    public void setContext(Context context);
}
