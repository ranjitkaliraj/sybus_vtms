package com.sybus.android.userapp.presenterImpl;

import android.content.Context;

import com.sybus.android.userapp.model.Busstop;
import com.sybus.android.userapp.model.Route;
import com.sybus.android.userapp.model.Vehicle;
import com.sybus.android.userapp.modelImpl.BusstopImpl;
import com.sybus.android.userapp.modelImpl.RouteImpl;
import com.sybus.android.userapp.modelImpl.VehicleImpl;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.SearchVehicleDto;
import com.sybus.android.userapp.presenter.SearchPresenter;
import com.sybus.android.userapp.presenterListener.SearchPresenterListener;
import com.sybus.android.userapp.view.SearchResultView;
import com.sybus.android.userapp.view.SearchView;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public class SearchPresenterImpl implements SearchPresenter, SearchPresenterListener{

    private SearchResultView searchResultView;
    private SearchView searchView;

    private Vehicle vehicle;
    private Route route;
    private Busstop stop;

    private Context context;

    //constructor for activity search.
    public SearchPresenterImpl(SearchResultView view1, SearchView view2){
        //there is error on search activity since that class implement both searchresult and searchview
        //so there is conflict on constructor, it cannot identify whether it is searchresult or serarch view so using this logic
        //so that same constructor can be used for both initialization.
        if(view2 == null){
            searchResultView = view1;
            vehicle = new VehicleImpl();
            //route = new RouteImpl();
            //stop = new BusstopImpl();
        }
        else{
            searchView = view2;
            vehicle = new VehicleImpl();
            route = new RouteImpl();
            stop = new BusstopImpl();
        }
    }

   /* //Constructor for home fragment: route and bus stop specific vehicle search.
    public SearchPresenterImpl(SearchView view){
    }*/

    @Override
    public void setContext(Context context) {
        this.context = context;
        vehicle = new VehicleImpl();
        route = new RouteImpl();
        stop = new BusstopImpl();
    }

    @Override
    public Context getContext(){
        return context;
    }

    @Override
    public void findVehicle(String destination, Double lng, Double lat, int range) {
        //calling
        vehicle.searchAvailableVehicles(destination, lng, lat, range, this);
    }

    @Override
    public void findVehicleForRoute(String route) {
        searchResultView.showProgressBar("Finding Vehicle...");
        vehicle.searchVehicleForRoute(route, this);
    }

    @Override
    public void findVehicleForBusStop(String stop) {
        searchResultView.showProgressBar("Finding Vehicle...");
        vehicle.searchVehicleForStop(stop, this);
    }

    @Override
    public void getVehicleDetailForDestination(long vehicleID, String userStop, String destStop, String destination) {
        searchResultView.showProgressBar("Getting details...");
        vehicle.getVehicleDetail(vehicleID, userStop, destStop, destination, this);
    }

    @Override
    public void getRouteNames() {
        searchView.showProgressBar("Getting Routes list...");
        route.getRouteList(this);
    }

    @Override
    public void getBusstopNames() {
        searchView.showProgressBar("Getting Stops list...");
        stop.getStopList(this);
    }

    @Override
    public void onRouteListFound(ArrayList<String> routes) {
        searchView.hideProgressBar();
        searchView.displayRouteSearchOption(routes);
    }

    @Override
    public void onRouteListNotFound() {
        searchView.hideProgressBar();
        searchView.displayAlertMessage("Unable to retrive Route list. Please, Try again after some time.");

    }

    @Override
    public void onBusStopListFound(ArrayList<String> stops) {
        searchView.hideProgressBar();
        searchView.displayBusStopSearchOption(stops);
    }

    @Override
    public void onBusStopListNotFound() {
        searchView.hideProgressBar();
        searchView.displayAlertMessage("Unable to retrive Stops list. Please, Try again after some time.");
    }

    @Override
    public void onSearchResultNotFound(String message) {
        searchResultView.displayAlertMessage(message);
        searchResultView.hideProgressBar();
    }

    @Override
    public void onSearchResultFound(ArrayList<SearchVehicleDto> data) {
        searchResultView.displayResult(data);
        searchResultView.hideProgressBar();
    }

    @Override
    public void onVehicleDetailNotFound() {
        searchResultView.displayAlertMessage("Cannot get the vehicle detail at the moment.");
    }

    @Override
    public void onVehicleDetailFound(DetailVehicleDto vehicle) {
        searchResultView.hideProgressBar();
        searchResultView.DisplayVehicleDetail(vehicle);
    }

    @Override
    public void onRouteSearchVehicleResultFound(ArrayList<SearchVehicleDto> dto) {
        searchResultView.hideProgressBar();
        searchResultView.displayResult(dto);
    }

    @Override
    public void onRouteSearchVehicleResultNotFound() {
        searchResultView.hideProgressBar();
        searchResultView.displayAlertMessage("Unable to find vehicles. Please, try again later.");
    }

    @Override
    public void onStopSearchVehicleResultFound(ArrayList<SearchVehicleDto> dto) {
        searchResultView.hideProgressBar();
        searchResultView.displayResult(dto);
    }

    @Override
    public void onStopSearchVehicleResultNotFound() {
        searchResultView.hideProgressBar();
        searchResultView.displayAlertMessage("Unable to find vehicles. Please, try again later.");
    }
}
