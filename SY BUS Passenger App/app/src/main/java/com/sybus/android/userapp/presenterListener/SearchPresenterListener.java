package com.sybus.android.userapp.presenterListener;

import android.content.Context;

import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.SearchVehicleDto;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/3/2016.
 */
public interface SearchPresenterListener {
    public void onRouteListFound(ArrayList<String> routes);
    public void onRouteListNotFound();
    public void onBusStopListFound(ArrayList<String> stops);
    public void onBusStopListNotFound();
    public void onSearchResultNotFound(String statusMessage);
    public void onSearchResultFound(ArrayList<SearchVehicleDto> data);

    public void onVehicleDetailNotFound();
    public void onVehicleDetailFound(DetailVehicleDto vehicle);

    public void onRouteSearchVehicleResultFound(ArrayList<SearchVehicleDto> dto);
    public void onRouteSearchVehicleResultNotFound();
    public void onStopSearchVehicleResultFound(ArrayList<SearchVehicleDto> dto);
    public void onStopSearchVehicleResultNotFound();

    public Context getContext();
}
