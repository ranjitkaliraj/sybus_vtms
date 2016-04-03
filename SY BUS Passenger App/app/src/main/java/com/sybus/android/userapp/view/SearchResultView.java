package com.sybus.android.userapp.view;

import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.SearchVehicleDto;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public interface SearchResultView {
    public void displayAlertMessage(String message);
    public void showProgressBar(String message);
    public void hideProgressBar();
    public void getVehicleDetail(Long sessionID, String userStop, String destStop, String destination);
    public void DisplayVehicleDetail(DetailVehicleDto vehicle);
    public void displayResult(ArrayList<SearchVehicleDto> data);  //display vehicle result on list
}
