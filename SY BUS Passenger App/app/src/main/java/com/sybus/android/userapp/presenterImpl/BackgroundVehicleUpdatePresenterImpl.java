package com.sybus.android.userapp.presenterImpl;

import android.content.Context;

import com.sybus.android.userapp.model.Vehicle;
import com.sybus.android.userapp.modelImpl.VehicleImpl;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.presenter.BackgroundVehicleUpdatePresenter;
import com.sybus.android.userapp.presenterListener.BackgroundVehicleUpdatePresenterListener;
import com.sybus.android.userapp.util.VehicleDataCacheManager;
import com.sybus.android.userapp.view.BackgroundUpdateView;

/**
 * Created by Ranjit Kaliraj on 2/29/2016.
 */
public class BackgroundVehicleUpdatePresenterImpl implements BackgroundVehicleUpdatePresenter, BackgroundVehicleUpdatePresenterListener {
    private BackgroundUpdateView view;
    private Vehicle vehicle;
    private Context context;

    private int vehicleUpdateFailedCount;

    public BackgroundVehicleUpdatePresenterImpl(BackgroundUpdateView view){
        this.view = view;
        vehicle = new VehicleImpl();
    }


    @Override
    public void getVehicleUpdate() {
        long session_id = VehicleDataCacheManager.getVehicle(getContext()).getVehicle().getVehicleID();
        String userStop = VehicleDataCacheManager.getVehicle(getContext()).getVehicle().getUserNearStop();
        vehicle.getVehicleUpdate(session_id, userStop, this);
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
    public void onGetUpdateSuccess(DetailVehicleDto vehicle) {
        VehicleDataCacheManager.cacheVehicle(getContext(), vehicle);
        if(vehicle.isVehicleExpired()){
            view.suspendVehicleDetailsAutoUpdate();
        }
        else{
            view.startVehicleDetailsAutoUpdate();
        }
    }


    @Override
    public void onGetUpdateFailed() {
        vehicleUpdateFailedCount= vehicleUpdateFailedCount+1;
        //stop update after 1 mins.
        if(vehicleUpdateFailedCount>3){
            view.displayAlertMessage("Unable to get pinned vehicle location update.");
            view.suspendVehicleDetailsAutoUpdate();
        }
    }

    @Override
    @Deprecated
    public void onVehicleExpired() {

    }
}
