package com.sybus.android.userapp.presenterImpl;

import android.content.Context;
import android.os.Handler;

import com.sybus.android.userapp.model.Vehicle;
import com.sybus.android.userapp.modelImpl.VehicleImpl;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.presenter.TrackPresenter;
import com.sybus.android.userapp.presenterListener.TrackPresenterListener;
import com.sybus.android.userapp.view.DetailDisplayView;
import com.sybus.android.userapp.view.TrackView;

/**
 * Created by Ranjit Kaliraj on 1/6/2016.
 */
public class TrackPresenterImpl implements TrackPresenter, TrackPresenterListener {
    private DetailDisplayView detailView;
    private TrackView trackView;
    private Vehicle vehicle;

    private Context context;

    //for detail view activity
    public TrackPresenterImpl(DetailDisplayView view) {
        detailView = view;
        vehicle = new VehicleImpl();
    }

    //for pinned activity
    public TrackPresenterImpl(TrackView view) {
        trackView = view;
        vehicle = new VehicleImpl();
    }


    public void setContext(Context context) {
        this.context = context;
    }

    @Override
    public void removeBookmark() {
        trackView.showProgressBar("Removing...");
        vehicle.removeVehicleCache(this);
    }

    @Override
    public void getCachedVehicle() {
        vehicle.getVehicleCache(this);
    }

    @Override
    public Context getContext() {
        return context;
    }

    @Override
    public void onCacheRemoved() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                trackView.hideProgressBar();
                trackView.resetDashboard();
            }
        }, 1500);
    }

    @Override
    public void onCacheRetrieved(DetailVehicleDto vehicle) {
        trackView.setVehicleData(vehicle);
    }


    @Override
    public void cacheVehicleDetail(DetailVehicleDto vehicle) {
        detailView.showProgressBar("Pinning...");
        this.vehicle.cacheVehicle(vehicle, this);
    }

    @Override
    public String getCachedETA() {
        return vehicle.getCachedETA(this);
    }

    @Override
    public void onCacheSuccess() {
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                detailView.hideProgressBar();
                detailView.displayDashBoard();
            }
        }, 1500);
    }
}
