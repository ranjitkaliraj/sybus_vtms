package com.sybus.android.userapp.view;

import com.sybus.android.userapp.ui.MainActivity;

/**
 * Created by Ranjit Kaliraj on 12/26/2015.
 */
public interface LoginView {
    public void displayInvalidLoginMessage(String message);
    public void showProgressBar(String message);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
    public void reConstructNavigationPanel(boolean status);
    public MainActivity getActivity();
    public void hideLoginView();
    public void displayAccountActivationPage();
}
