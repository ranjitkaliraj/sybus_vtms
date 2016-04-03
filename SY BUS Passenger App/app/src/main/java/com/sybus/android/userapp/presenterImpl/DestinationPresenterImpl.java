package com.sybus.android.userapp.presenterImpl;

import android.content.Context;

import com.sybus.android.userapp.model.Destination;
import com.sybus.android.userapp.modelImpl.DestinationImpl;
import com.sybus.android.userapp.presenter.DestinationPresenter;
import com.sybus.android.userapp.presenterListener.DestinationPresenterListener;
import com.sybus.android.userapp.view.SearchView;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
public class DestinationPresenterImpl implements DestinationPresenter, DestinationPresenterListener {

    private SearchView searchView;
    private Destination destination;
    private Context context;

    //initializing constructor.
    public DestinationPresenterImpl(SearchView searchView){
        this.searchView = searchView;
        this.destination = new DestinationImpl();
    }

    @Override
    public void setContext(Context context) {
        this.context = context;
    }

    @Override
    public Context getContext(){
        return context;
    }

    @Override
    public void validate(String des) {
        destination.validateDestination(des, this);
    }

    @Override
    public void searchSuggestion(String suggestion) {
        searchView.displaySearchViewLoadingIndicator();
        destination.getDestinationSuggestion(suggestion, this);
    }

    @Override
    public void onValidationSuccess() {
        searchView.findVehicles();
    }

    @Override
    public void onValidationFailed() {
        searchView.displayAlertMessage("Cannot found the Destination. Please, check and try again.");
    }

    @Override
    public void returnSuggestionList(ArrayList<String> data) {
        searchView.hideSearchViewLoadingIndicator();
        searchView.setSuggestionResult(data);
    }

    @Override
    public void onSuggestionNotFound() {
        searchView.hideSearchViewLoadingIndicator();
    }

    @Override
    public void onErrorOccured() {
        searchView.hideSearchViewLoadingIndicator();
    }


}
