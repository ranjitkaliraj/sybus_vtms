package com.sybus.android.userapp.modelImpl;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.sybus.android.userapp.model.User;
import com.sybus.android.userapp.presenterListener.AccountPresenterListener;
import com.sybus.android.userapp.presenterListener.LoginPresenterListener;
import com.sybus.android.userapp.presenterListener.QueryPresenterListener;
import com.sybus.android.userapp.ui.MainActivity;
import com.sybus.android.userapp.ui.create_account;
import com.sybus.android.userapp.ui.submit_query;
import com.sybus.android.userapp.util.BooleanRequest;
import com.sybus.android.userapp.util.PasswordHash;
import com.sybus.android.userapp.util.URLConfig;
import com.sybus.android.userapp.util.UserDataCacheManager;
import com.sybus.android.userapp.util.VolleySingleton;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Ranjit Kaliraj on 12/26/2015.
 */
public class UserImpl extends Service implements User{
    private final IBinder loginServiceBinder = new LoginServiceBinder();
    private LoginPresenterListener listener;

    private final String TAG = this.getClass().getName();

    public UserImpl() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        return loginServiceBinder;
    }

    //Android volly code here to authenticate user
    @Override
    public void login(final String username, final String password, final LoginPresenterListener listener) {

        String URL = new URLConfig(listener.getContext()).getInstance().USER_LOGIN;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            boolean status = response.getBoolean("status");
                            String username = response.getString("name");
                            String email = response.getString("email");
                            String auth_key = response.getString("auth_key");

                            //Calling presenter methods
                            if(status==true){
                                Log.d(TAG, "Authentication success, now caching the auth-key.");
                                //UserDataCacheManager.storeUserDataCache(getApplicationContext(), username, email, auth_key);
                                listener.onLoginSuccess(username, email, auth_key);
                            }else {
                                Log.d(TAG, "Authentication failed, invalid login credential.");
                                listener.onInvalidLogin();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onLoginServerError();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while authenticating user.: " + error.getMessage());
                listener.onLoginServerError();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", username);
                params.put("password", PasswordHash.hashUserPassword(password));
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    @Override
    public void checkAccountActivation(final String name, final String email, final String auth_key, final LoginPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().CHECK_ACCOUNT_ACTIVATION;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if (status == 1) {
                                Log.d(TAG, "Account is activated.");
                                listener.onAccountIsActivated(name, email, auth_key);
                            } else {
                                Log.d(TAG, "Account is not activated.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onAccountIsNotActivated(1);
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onAccountIsNotActivated(2);
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                listener.onAccountIsNotActivated(2);
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", email);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    @Override
    public void logout(final String auth_Key, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().USER_LOGOUT;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");

                            //Calling presenter methods
                            if(status == 1){
                                Log.d(TAG, "Logout success.");
                                //UserDataCacheManager.eUserDataCache(getApplicationContext());
                                listener.onLogoutSuccess();
                            }else {
                                Log.d(TAG, "Logout failed.");
                                listener.onLogoutSuccess();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while authenticating user.: " + error.getMessage());
                listener.onLogoutSuccess();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("auth-key", auth_Key);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    @Override
    public void loginAfterAccountCreate(final String username, final String password, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().USER_LOGIN;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            boolean status = response.getBoolean("status");
                            String username = response.getString("name");
                            String email = response.getString("email");
                            String auth_key = response.getString("auth_key");

                            //Calling presenter methods
                                Log.d(TAG, "Authentication success, now caching the auth-key.");
                                UserDataCacheManager.storeUserDataCache(listener.getContext(), username, email, auth_key);
                                listener.onLoginSuccess(username, email, auth_key);

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while authenticating user.: " + error.getMessage());
                listener.onLoginServerError();
            }
        }){
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", username);
                params.put("password", PasswordHash.hashUserPassword(password));
                return params;
            }
        };;
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }



    //Submitting query
    @Override
    public void submitQuery(String subject, String email, String message, final QueryPresenterListener listener) throws JSONException {
        String URL = new URLConfig(listener.getContext()).getInstance().SUBMIT_QUERY;
        JSONObject obj = new JSONObject();
        obj.put("email",email);
        obj.put("subject",subject);
        obj.put("message",message);

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (JSONObject) obj,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, "submission status : "+response);
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Query submit successful.");
                                listener.onQuerySubmitSuccess();
                            }
                            else {
                                Log.d(TAG, "Failed to submit query.");
                                //listener.onInvalidLogin();
                                listener.onQuerySubmitError();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while submitting query: " + error.getMessage());
                listener.onQuerySubmitError();
            }
        });

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(80000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    //Update account
    @Override
    public void createAccount(String fName, String lName, final String email, final String password, final AccountPresenterListener listener) throws JSONException {
        String URL = new URLConfig(listener.getContext()).getInstance().USER;
        JSONObject obj = new JSONObject();
        obj.put("f_name",fName);
        obj.put("l_name",lName);
        obj.put("email",email);
        obj.put("password",PasswordHash.hashUserPassword(password));

        Log.d(TAG, "Hashed password: "+ PasswordHash.hashUserPassword(password));

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (JSONObject) obj,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, "User account create status : "+response);
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "user account create successful.");
                                listener.onAccountCreateSuccess(email, password);
                            }
                            else if(status==3){
                                Log.d(TAG, "Failed to create account. duplicate email.");
                                //listener.onInvalidLogin();
                                listener.onAccountCreateFailed(3);
                            }
                            else {
                                Log.d(TAG, "Failed to create account.");
                                //listener.onInvalidLogin();
                                listener.onAccountCreateFailed(0);
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onAccountCreateFailed(0);
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while creating user account: " + error.getMessage());
                listener.onAccountCreateFailed(0);
            }
        });

        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(30000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void activateAccount(final String email, final int code, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().ACTIVATE_ACCOUNT;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Activation success.");
                                listener.onActivationSuccess();
                            }else {
                                Log.d(TAG, "Activation failed.");
                                listener.onActivationFailed(0);
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onActivationFailed(1);
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while activating account.: " + error.getMessage());
                //listener.onLoginServerError();
                listener.onActivationFailed(1);
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", email);
                params.put("code", code+"");
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void reSendActivationCode(final String email, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().RESEND_ACTIVATION_CODE;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Activation code successfully sent.");
                                listener.onResetCodeReSendSuccess();
                            }else if(status==0) {
                                Log.d(TAG, "Invalid email.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onResetCodeReSendFailed();
                            }
                            else {
                                Log.d(TAG, "Failed to send code.");
                                //listener.onInvalidLogin();
                                listener.onResetCodeReSendFailed();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onResetCodeReSendFailed();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                Log.d(TAG, "Error while re sending code.: " + error.getMessage());
                //listener.onLoginServerError();
                listener.onResetCodeReSendFailed();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", email);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void validateUserEmail(final String email, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().VALIDATE_EMAIL;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Email successfully validated.");
                                listener.onValidateEmailForResetPasswordSuccess(email);
                            }
                            else {
                                Log.d(TAG, "Invalid email.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onValidateEmailForResetPasswordFailed("The provided Email Address is not registered. Please, check and try again.");
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onValidateEmailForResetPasswordFailed("Something went wrong. Please, try again later");
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                listener.onValidateEmailForResetPasswordFailed("Something went wrong. Please, try again later");
                //listener.onLoginServerError();
                listener.onResetCodeReSendFailed();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", email);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void requestToResetCode(final String email, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().FORGET_PASSWORD;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Reset code code successfully sent.");
                                listener.onResetPasswordRequestSuccess();
                            }
                            else {
                                Log.d(TAG, "Failed to send reset code.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onResetPasswordRequestFailed();
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onResetPasswordRequestFailed();
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                listener.onResetPasswordRequestFailed();
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("email", email);
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    @Override
    public void validateResetCode(final int code, final AccountPresenterListener listener) {
        String URL = new URLConfig(listener.getContext()).getInstance().VALIDATE_RESET_CODE;
        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.POST,
                URL, (String) null,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Reset code is valid.");
                                listener.onValidateResetCodeForResetPasswordSuccess();
                            }
                            else {
                                Log.d(TAG, "Reset code is invalid.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onValidateResetCodeForResetPasswordFailed("Reset code is invalid.");
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onValidateResetCodeForResetPasswordFailed("Something went wrong. Please, try again later.");
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                listener.onValidateResetCodeForResetPasswordFailed("Something went wrong. Please, try again later.");
            }
        }) {
            @Override
            //SettingActivity headers
            public Map<String, String> getHeaders() throws AuthFailureError {
                HashMap params = new HashMap();
                params.put("code", code+"");
                return params;
            }
        };
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }


    @Override
    public void resetPassword(final String email, final String password, final AccountPresenterListener listener) throws JSONException {
        String URL = new URLConfig(listener.getContext()).getInstance().USER;

        JSONObject obj = new JSONObject();
        obj.put("email",email);
        obj.put("password",PasswordHash.hashUserPassword(password));

        RequestQueue queue = VolleySingleton.getInstance(listener.getContext()).
                getRequestQueue();
        JsonObjectRequest request = new JsonObjectRequest(Request.Method.PUT,
                URL, (JSONObject) obj,
                new Response.Listener<JSONObject>() {

                    @Override
                    public void onResponse(JSONObject response) {
                        Log.d(TAG, response.toString());
                        try {
                            int status = response.getInt("status");
                            //Calling presenter methods
                            if(status==1){
                                Log.d(TAG, "Password reset is successful.");
                                listener.onResetPasswordSuccess(email,password);
                            }
                            else {
                                Log.d(TAG, "Password reset failed.");
                                //this is rear case of error but included to avoid possible problem.
                                listener.onResetPasswordFailed("Password reset failed. Please, try again later.");
                            }
                        } catch (JSONException e) {
                            e.printStackTrace();
                            listener.onResetPasswordFailed("Something went wrong. Please, try again later.");
                        }
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                listener.onResetPasswordFailed("Something went wrong. Please, try again later.");
            }
        });
        //SettingActivity the timeout to listen to the server
        request.setRetryPolicy(new DefaultRetryPolicy(20000,
                DefaultRetryPolicy.DEFAULT_MAX_RETRIES,
                DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        queue.add(request);
    }

    //############################################################################
    //IBinder class
    public class LoginServiceBinder extends Binder {
        public UserImpl getService() {
            return UserImpl.this;
        }
    }
}
