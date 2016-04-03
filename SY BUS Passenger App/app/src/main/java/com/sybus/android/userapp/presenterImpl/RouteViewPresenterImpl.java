package com.sybus.android.userapp.presenterImpl;

import android.content.Context;

import com.sybus.android.userapp.model.Route;
import com.sybus.android.userapp.modelImpl.RouteImpl;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.presenter.RouteViewPresenter;
import com.sybus.android.userapp.presenterListener.RouteViewPresenterListener;
import com.sybus.android.userapp.view.RouteView;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 2/28/2016.
 */
public class RouteViewPresenterImpl implements RouteViewPresenter, RouteViewPresenterListener{
    private Context context;
    private RouteView view;
    private Route route;

    public RouteViewPresenterImpl(RouteView view){
        this.view = view;
        route = new RouteImpl();
    }

    @Override
    public void setContext(Context context) {
        this.context = context;
    }

    @Override
    public Context getContext() {
        return context;
    }

    @Override
    public void onRouteCoordinatesFound(ArrayList<LngLat> data) {
        view.displayMap(data);
        view.hideProgressBar();
    }

    @Override
    public void onRouteCoordinatesNotFound() {
        view.hideProgressBar();
        view.displayAlertMessage("Unable to display route on map.");
    }

    @Override
    public void getAvailableRouteList() {
        view.showProgressBar("Loading...");
        route.getRouteList(this);
    }

    @Override
    public void getRouteCoordinates(String routeName) {
        view.showProgressBar("Loading...");
        route.getLatLng(routeName, this);
    }

    @Override
    public void onRouteListAvailable(ArrayList<String> routes) {
        view.displayRouteLists(routes);
        view.hideProgressBar();
    }

    @Override
    public void onRouteListNotAvailable() {
        view.hideProgressBar();
        view.displayNoRouteMessage();
    }
}
