package com.sybus.android.userapp.view;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public interface AccountView {
    public void showProgressBar(String message);
    public void hideProgressBar();
    public void displayAlertMessage(String message);
    public void navigateToMainPage(boolean status);
    public void displayAccountActivationPage();
    public void displayAccountRegistrationView();
    public void hideAccountActivationPanel();
    public void reConstructNavigationPanel(boolean option);
    public void displayResetPasswordStep1();
    public void displayResetPasswordStep2();
    public void displayResetPasswordStep3();
    public void hideResetPasswordPanel();

}
