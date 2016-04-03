package com.sybus.android.userapp.presenterImpl;

import android.content.Context;
import android.os.Handler;
import android.widget.Toast;

import com.sybus.android.userapp.model.User;
import com.sybus.android.userapp.modelImpl.UserImpl;
import com.sybus.android.userapp.presenter.AccountPresenter;
import com.sybus.android.userapp.presenterListener.AccountPresenterListener;
import com.sybus.android.userapp.util.UserDataCacheManager;
import com.sybus.android.userapp.view.AccountView;

import org.json.JSONException;

/**
 * Created by Ranjit Kaliraj on 2/26/2016.
 */
public class AccountPresenterImpl implements AccountPresenter, AccountPresenterListener{
    private AccountView view;
    private Context context;
    private User user;

    public AccountPresenterImpl(AccountView view){
        this.view = view;
        user = new UserImpl();
    }

    @Override
    public void createAccount(String fname, String lname, String email, String password) {
        view.showProgressBar("Creating account...");
        try {
            user.createAccount(fname, lname, email, password, this);
        } catch (JSONException e) {
            view.hideProgressBar();
            view.displayAlertMessage("Something went wrong.");
            e.printStackTrace();
        }
    }

    @Override
    public void logout() {
        view.showProgressBar("Logging out...");
        String[] data = UserDataCacheManager.getUserDataFromCache(getContext());
        user.logout(data[2], this);
    }

    @Override
    public void activate(String email, int code) {
        view.showProgressBar("Activating...");
        user.activateAccount(email, code, this);
    }

    @Override
    public void reSendCode(String email) {
        view.showProgressBar("Re-sending code...");
        user.reSendActivationCode(email, this);
    }

    @Override
    public void setContext(Context context) {
        this.context = context;
    }

    @Override
    public void sendResetCode(String email) {
        view.showProgressBar("Checking Email...");
        user.requestToResetCode(email, this);
    }

    @Override
    public void validateResetCode(int code) {
        view.showProgressBar("Validating...");
        user.validateResetCode(code, this);
    }

    @Override
    public void resetPassword(String password) throws JSONException {
        view.showProgressBar("Updating Password...");
        user.resetPassword(UserDataCacheManager.getUserEmailForResetPassword(getContext()), password, this);
    }

    @Override
    public Context getContext() {
        return context;
    }


    @Override
    public void onAccountCreateSuccess(String username, String password) {
        view.hideProgressBar();
        //storing email in background which will be get in background during validating activation code.
        UserDataCacheManager.storeUserEmailCache(getContext(), username);
        //also storing user login info for first login.
        UserDataCacheManager.storeUserLoginInfoForFirstLogin(getContext(), username, password);
        view.displayAccountActivationPage();
    }

    @Override
    public void onAccountCreateFailed(int reason) {
        view.hideProgressBar();
        if(reason==3){
            view.hideProgressBar();
            view.displayAlertMessage("Your email is already registered.");
        }
        else if(reason==2){
            view.hideProgressBar();
            view.displayAlertMessage("Cannot create Account at the moment. Please, try again later.");
        }
        else{
            view.hideProgressBar();
            view.displayAlertMessage("Something went wrong. Please, try again later.");
        }
    }

    @Override
    public void onLoginSuccess(String username, String email, String auth_key) {
        view.hideProgressBar();
        UserDataCacheManager.storeUserDataCache(getContext(), username, email, auth_key);
        UserDataCacheManager.emptyUserLoginInfoForFirstLogin(getContext());
        //view.displayAlertMessage("Your Account has been successfully created.");
        view.navigateToMainPage(true);
        Toast.makeText(getContext(), "Congratulation!!! Account is successfully created.", Toast.LENGTH_LONG).show();
        try{
            view.hideProgressBar();
        }catch(Exception e){}
    }

    @Override
    public void onLoginServerError() {
        view.hideProgressBar();
        view.navigateToMainPage(false);
        view.displayAlertMessage("Cannot login at the moment.");
    }

    @Override
    public void onLogoutSuccess() {
        UserDataCacheManager.emptyUserDataCache(getContext());
        view.hideProgressBar();
        view.reConstructNavigationPanel(false);
    }

    @Override
    public void onActivationSuccess() {
        view.hideProgressBar();
        view.hideAccountActivationPanel();
        view.showProgressBar("Logging in...");
        /*new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                view.showProgressBar("Congratulation!!! Account activation is successful.");
            }
        }, 2000);*/
        String[] data = UserDataCacheManager.getUserLoginInfoForFirstLogin(getContext());
        user.loginAfterAccountCreate(data[0], data[1], this);
    }

    @Override
    public void onActivationFailed(int reason) {
        view.hideProgressBar();
        if(reason == 0){
            view.displayAlertMessage("Invalid activation code. Please, check and try again.");
        }else{
            view.displayAlertMessage("Activation Failed. Something went wrong.");
        }
    }

    @Override
    public void onResetCodeReSendSuccess() {
        view.hideProgressBar();
        //String[] data = UserDataCacheManager.getUserLoginInfoForFirstLogin(getContext());
        //user.loginAfterAccountCreate(data[0], data[1], this);
        Toast.makeText(getContext(), "Activation code sent. Please check your email.", Toast.LENGTH_LONG).show();
    }

    @Override
    public void onResetCodeReSendFailed() {
        Toast.makeText(getContext(), "Unable to send activation code at the moment. Please, try again later.", Toast.LENGTH_LONG).show();
    }

    @Override
    public void onValidateEmailForResetPasswordSuccess(String email) {
        view.hideProgressBar();
        UserDataCacheManager.storeUserEmailForResetPassword(getContext(), email);
        view.showProgressBar("Sending Code...");
        user.reSendActivationCode(email, this);
    }

    @Override
    public void onValidateEmailForResetPasswordFailed(String message) {
        view.hideProgressBar();
        view.displayAlertMessage(message);
    }

    @Override
    public void onResetPasswordRequestSuccess() {
        view.hideProgressBar();
        view.displayResetPasswordStep2();
    }

    @Override
    public void onResetPasswordRequestFailed() {
        view.hideProgressBar();
        view.displayAlertMessage("Unable to reset your Password. Please, try again later.");
    }

    @Override
    public void onValidateResetCodeForResetPasswordSuccess() {
        view.hideProgressBar();
        view.displayResetPasswordStep3();
    }

    @Override
    public void onValidateResetCodeForResetPasswordFailed(String message) {
        view.hideProgressBar();
        view.displayAlertMessage(message);
    }

    @Override
    public void onResetPasswordSuccess(String email, String password) {
        view.hideProgressBar();
        view.hideResetPasswordPanel();
        view.showProgressBar("Logging in...");
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                view.showProgressBar("Password Reset successful. You will be automatically logged in.");
            }
        },2000);
        user.loginAfterAccountCreate(email, password, this);
    }

    @Override
    public void onResetPasswordFailed(String message) {
        view.hideProgressBar();
        view.displayAlertMessage(message);

    }
}
