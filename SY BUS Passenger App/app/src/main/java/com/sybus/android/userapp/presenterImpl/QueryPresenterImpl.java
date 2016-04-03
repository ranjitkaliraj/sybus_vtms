package com.sybus.android.userapp.presenterImpl;

import android.content.Context;

import com.sybus.android.userapp.model.User;
import com.sybus.android.userapp.modelImpl.UserImpl;
import com.sybus.android.userapp.presenter.QueryPresenter;
import com.sybus.android.userapp.presenterListener.QueryPresenterListener;
import com.sybus.android.userapp.view.QueryView;

import org.json.JSONException;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public class QueryPresenterImpl implements QueryPresenter, QueryPresenterListener{
    private QueryView view;
    private Context context;

    private User user;

    public QueryPresenterImpl(QueryView view){
        this.view = view;
        user = new UserImpl();
    }


    @Override
    public void submitQuery(String subject, String email, String message) {
        view.showProgressBar("Submitting...");
        try {
            user.submitQuery(subject, email, message, this);
        } catch (JSONException e) {
            e.printStackTrace();
            view.hideProgressBar();
            view.displayAlertMessage("Error while submitting query.");
        }
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
    public void onQuerySubmitSuccess() {
        view.hideProgressBar();
        view.displayAlertMessage("Your feedback/Query has been successfully submitted.");
    }

    @Override
    public void onQuerySubmitError() {
        view.hideProgressBar();
        view.displayAlertMessage("Feedback/Query submission failed. Please, try again later.");
    }
}
