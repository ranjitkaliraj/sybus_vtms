package com.sybus.android.userapp.presenterImpl;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.widget.Toast;

import com.sybus.android.userapp.model.User;
import com.sybus.android.userapp.modelImpl.UserImpl;
import com.sybus.android.userapp.presenter.LoginPresenter;
import com.sybus.android.userapp.presenterListener.LoginPresenterListener;
import com.sybus.android.userapp.util.UserDataCacheManager;
import com.sybus.android.userapp.view.LoginView;

/**
 * Created by Ranjit Kaliraj on 12/26/2015.
 */
public class LoginPresenterImpl implements LoginPresenter, LoginPresenterListener {
    private LoginView loginView;
    private Context context;

    private User user;

    public LoginPresenterImpl(LoginView loginView){
        this.loginView = loginView;
        user = new UserImpl();
        //Instantiating binding service.
        /*loginView.getActivity()
                .bindService(new Intent(loginView.getActivity()
                        .getApplicationContext(), UserImpl.class), loginServiceConnection, Context.BIND_AUTO_CREATE);*/
    }

    //##############################################################################################
    //Binding to login service.
  /*  private ServiceConnection loginServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            UserImpl.LoginServiceBinder binder = (UserImpl.LoginServiceBinder) service;
            userImpl = binder.getService();

            //Providing this class instance to the login service class.
            userImpl.setServiceListener(LoginPresenterImpl.this);
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
        }
    };
*/

    //##############################################################################################

    @Override
    public void validateCredentials(String username, String password) {
        loginView.showProgressBar("Signing in...");
        //userImpl.login(username, password);
        user.login(username, password, this);
    }

    public void setContext(Context context) {
        this.context = context;
    }

    @Override
    public Context getContext(){
        return context;
    }

    @Override
    public void onAccountIsActivated(String name, String email, String auth_key) {
        UserDataCacheManager.storeUserDataCache(getContext(), name, email, auth_key);
        loginView.reConstructNavigationPanel(true);
        loginView.hideLoginView();
        loginView.hideProgressBar();
    }

    @Override
    public void onAccountIsNotActivated(int status) {
        loginView.hideLoginView();
        loginView.hideProgressBar();
        //loginView.displayAlertMessage("Your account is not activated. Please, verify it before continue.");
        Toast.makeText(getContext(), "Your account is not activated. Please, verify it before continue.", Toast.LENGTH_LONG).show();
        loginView.displayAccountActivationPage();
    }

    //##############################################################################################
    //Login Presenter Service/Model Listener implementations

    @Override
    public void onLoginSuccess(String name, String email, String auth_Key) {
        //loginView.reConstructNavigationPanel(true);
        user.checkAccountActivation(name, email, auth_Key, this);
    }

    @Override
    public void onLoginServerError() {
        loginView.hideProgressBar();
        loginView.displayAlertMessage("Something went wrong. Please, try again.");
    }

    @Override
    public void onInvalidLogin() {
        loginView.hideProgressBar();
        loginView.displayInvalidLoginMessage("Invalid Username/Password.");
    }
}
