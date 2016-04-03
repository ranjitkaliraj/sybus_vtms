package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Handler;
import android.support.v4.view.ViewPager;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.model.User;
import com.sybus.android.userapp.presenter.AccountPresenter;
import com.sybus.android.userapp.presenter.BackgroundVehicleUpdatePresenter;
import com.sybus.android.userapp.presenter.LoginPresenter;
import com.sybus.android.userapp.presenterImpl.AccountPresenterImpl;
import com.sybus.android.userapp.presenterImpl.BackgroundVehicleUpdatePresenterImpl;
import com.sybus.android.userapp.presenterImpl.LoginPresenterImpl;
import com.sybus.android.userapp.ui.components.AlertManager;
import com.sybus.android.userapp.ui.fragments.NavigationPanelFragment;
import com.sybus.android.userapp.ui.adapters.TabsPagerAdapter;
import com.sybus.android.userapp.ui.components.SlidingTabLayout;
import com.sybus.android.userapp.util.EmailValidator;
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.util.UserDataCacheManager;
import com.sybus.android.userapp.util.SharePreferenceManager;
import com.sybus.android.userapp.util.VehicleDataCacheManager;
import com.sybus.android.userapp.view.AccountView;
import com.sybus.android.userapp.view.BackgroundUpdateView;
import com.sybus.android.userapp.view.LoginView;

import org.json.JSONException;


public class MainActivity extends AppCompatActivity implements LoginView, AccountView, BackgroundUpdateView {

    public String TAG = this.getClass().getName();

    //Navigation Panel Username and email display text field and redirect button.
    private TextView username;
    private TextView email;
    private LinearLayout view_profile_or_login;

    private NavigationPanelFragment navigationPanelFragment;
    //Login dialog box textfields, and text views.
    private EditText loginEmail;
    private EditText loginPassword;

    //Progressbar and status message display dialog box variables.
    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;
    private AlertDialog.Builder loginDialog;


    //Account create parameters
    private String accountCreate_fName = "";
    private String accountCreate_lName = "";
    private String accountCreate_password = "";
    private String accountCreate_email = "";
    private DialogInterface accountCreate_Dialog;

    private AlertDialog loginPanel;
    private AlertDialog accountCreatePanel;
    private AlertDialog accountActivationPanel;

    //Password reset form parameters
    private EditText resetPassword_email;
    private EditText resetPassword_resetCode;
    private EditText resetPassword_newPassword;

    private AlertDialog resetPasswordPanel;

    //internet connection
    private NetworkConnection connection;

    private ViewPager mPager;

    //this attribute holds whether vehicle is preiously pinned or not.
    //whenever main activity load. if vehicle is pinned it will start autoupdate information.
    private boolean vehiclePinnedStatus;
    private boolean vehicleUpdateSuspendStatus = false;

    private BackgroundVehicleUpdatePresenter backgroundUpdate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setDisplayShowHomeEnabled(true);

        //Setting up the navigation panel
        Log.d(TAG, "Initializing and adding the Navigation drawer.");
        navigationPanelFragment = (NavigationPanelFragment) getSupportFragmentManager().findFragmentById(R.id.fragment_navigation_drawer);
        navigationPanelFragment.setupAppDrawer(findViewById(R.id.fragment_navigation_drawer), (DrawerLayout) findViewById(R.id.drawer_layout), toolbar);
        navigationPanelFragment.setActivityInstance(this);

        Log.d(TAG, "apple   " + getApplicationContext().getAssets().toString());
        //Setting up the tab menu and creating the scrollable tab options menu
        Log.d(TAG, "Initializing ViewPager for adding tab menu in main screen.");
        mPager = (ViewPager) findViewById(R.id.pager);

        Log.d(TAG, "Getting tabs name from string.xml.");
        String[] tabs = getResources().getStringArray(R.array.tabs);  //getting the list of tabs names from string.xml
        mPager.setAdapter(new TabsPagerAdapter(getSupportFragmentManager(), tabs));//calling setAdapter method

        Log.d(TAG, "Initializing SlidingTabLayout.");
        SlidingTabLayout mTabs = (SlidingTabLayout) findViewById(R.id.tabBar);
        mTabs.setDistributeEvenly(true);
        mTabs.setCustomTabView(R.layout.view_custom_tab, R.id.tabTextView);
        mTabs.setSelectedIndicatorColors(getResources().getColor(R.color.accent));
        mTabs.setViewPager(mPager);
        //mPager.getAdapter()

        //Checking if main activity is triggered from vehicle detail activity in order to pin vehicle.
        //if so then navigating to the pin tab.

        try {
            if (VehicleDataCacheManager.getVehicle(this) != null || VehicleDataCacheManager.getVehicle(this).getVehicle().getVehicleName().equals("")) {
                Log.d(TAG, "Main activity trigerred from the ditail activity, so displaying the pinned dashboard.");
                mPager.setCurrentItem(1, true);  //1 is pinned tab.
            }
        } catch (Exception e) {
        }

        //Instantiating navigation panel user details info text fields
        username = (TextView) findViewById(R.id.nav_user_name);
        email = (TextView) findViewById(R.id.nav_user_email);
        view_profile_or_login = (LinearLayout) findViewById(R.id.nav_email_container);

        //getting the network status/
        Log.d(TAG, "Getting network connection status report.");
        connection = new NetworkConnection(this);

        if (connection.isNetworkConnected() == false) {
            Toast.makeText(this, "Not connected to Internet.", Toast.LENGTH_LONG).show();
        }

        //Checking if user is previously loggedin or not and reconstructing the navigation panel.
        //reading if the username value from the saved preference.
        Log.d(TAG, "Reading from shared preference to check if the user is previously logged in or not.");

        //ensuring all the details are stored/ so that null point error will not displyed.
        String cache_username = SharePreferenceManager.readFromPreference(getApplicationContext(), "username", "", UserDataCacheManager.userDataPref);
        String cache_email = SharePreferenceManager.readFromPreference(getApplicationContext(), "email", "", UserDataCacheManager.userDataPref);
        String cache_auth_key = SharePreferenceManager.readFromPreference(getApplicationContext(), "auth-key", "", UserDataCacheManager.userDataPref);

        Log.d(TAG, "auth key:" + cache_auth_key + ", Email: " + cache_email + ", Name:" + cache_username);

        Boolean status = false;
        if ((cache_username == null || cache_username.equals("")) && (cache_email == null || cache_email.equals("")) && (cache_auth_key == null || cache_auth_key.equals(""))) {
            Log.d(TAG, "User is previously logged in.");
            status = false;
        } else {
            status = true;
            Log.d(TAG, "User is previously not logged in");
        }
        //calling NavigationPanelManger to reconstruct the navigation panel.
        Log.d(TAG, "Reconstructing the navigation drawer according to if user is either logged in or not.");
        reConstructNavigationPanel(status);

        //copying map data to the media storage
        //MapFilesManager map = new MapFilesManager(this);
        //map.copyMapFiles();


        backgroundUpdate = new BackgroundVehicleUpdatePresenterImpl(getActivity());
        backgroundUpdate.setContext(getApplicationContext());

        //starting vehicle auto update if vehicle is pinned.
        vehiclePinnedStatus = VehicleDataCacheManager.isVehicleCached(getApplicationContext());
        if(vehiclePinnedStatus){
            Log.d(TAG, "Vehicle is previously cached now getting update.");
            startVehicleDetailsAutoUpdate();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the MainActivity/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            Log.d(TAG, "Add new URL selected.");
            final AlertManager dialogClass = new AlertManager(this);
            AlertDialog.Builder urlAlert = dialogClass.displayUrlSaveAlert();
            urlAlert.setTitle("SET API URL (DEVELOPER OPTION)");

            urlAlert.setPositiveButton("SAVE", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int which) {
                    Log.d(TAG, "Save button clicked.");
                    final String url = "http://"+dialogClass.urlText.getText().toString()+":9090/webservice/api";

                    SharePreferenceManager.saveToPreference(getApplicationContext(),"URL", url, "WEB_SERVICE_API_URL");

                    dialog.dismiss();
                    showProgressBar("Saving...");

                    new Handler().postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            hideProgressBar();
                            Log.d(TAG, "Displaying toast.");
                            String value = SharePreferenceManager.readFromPreference(getApplicationContext(),"URL","http://localhost","WEB_SERVICE_API_URL");
                            Toast.makeText(getApplicationContext(), "URL successfully saved: "+value,Toast.LENGTH_LONG).show();
                        }
                    }, 1000);
                }
            });
            urlAlert.show();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    //This function displays account create dialog box.
    public void displayAccountRegistrationView(){
        //Inflating and initializing login dialog box fragment.
        View view = View.inflate(this, R.layout.view_account_create, null);
        final EditText fName = (EditText) view.findViewById(R.id.view_create_account_fName);
        final EditText lName = (EditText) view.findViewById(R.id.view_create_account_lName);
        final EditText email = (EditText) view.findViewById(R.id.view_create_account_email);
        final EditText password1 = (EditText) view.findViewById(R.id.view_create_account_password1);
        final EditText password2 = (EditText) view.findViewById(R.id.view_create_account_password2);
        //Button submit = (Button) view.findViewById(R.id.view_create_account_submit);
        final TextView statusMessage = (TextView) view.findViewById(R.id.view_create_account_status_message);

        //creating alert dialog
        AlertDialog.Builder accountDialog = new AlertDialog.Builder(this);
        accountDialog.setView(view);
        accountDialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        accountDialog.setTitle("CREATE ACCOUNT");
        accountDialog.setPositiveButton("CREATE", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        //accountDialog.create();
        accountCreatePanel = accountDialog.create();

        //when this dialog is shown the following code is executed
        accountCreatePanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(final DialogInterface dialog) {
                //getting the instance of positive button in order to set click listener and avoid disappearing of dialog box when button is clicked.
                Button button = accountCreatePanel.getButton(DialogInterface.BUTTON_POSITIVE);
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        //used to dismiss dialog from outside of this function.
                        accountCreate_Dialog = dialog;
                        accountCreate_fName = fName.getText().toString();
                        accountCreate_lName = lName.getText().toString();
                        accountCreate_email = email.getText().toString();
                        accountCreate_password = password1.getText().toString();
                        String accountCreate_password2 = password2.getText().toString();

                        //Toast.makeText(getApplicationContext(), "apple", Toast.LENGTH_LONG).show();

                        if (accountCreate_fName.equals(null) || accountCreate_fName.equals("")) {
                            statusMessage.setText("First Name is empty.");
                        } else if (accountCreate_lName.equals(null) || accountCreate_lName.equals("")) {
                            statusMessage.setText("Last Name is empty.");
                        } else if (accountCreate_email.equals(null) || accountCreate_email.equals("")) {
                            statusMessage.setText("Email is empty.");
                        }  else if (! new EmailValidator().validate(accountCreate_email)) {
                            statusMessage.setText("Your email is invalid format.");
                        } else if (accountCreate_password.equals(null) || accountCreate_password.equals("")) {
                            statusMessage.setText("Password is empty.");
                        } else if (accountCreate_password2.equals(null) || accountCreate_password2.equals("")) {
                            statusMessage.setText("Password doesn't match.");
                        } else if (!accountCreate_password2.equals(accountCreate_password)) {
                            statusMessage.setText("Password doesn't matched.");
                            password2.findFocus();
                        } else {
                            //dialog.dismiss();
                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    //everything works fine now submitting data.
                                    //Toast.makeText(getApplicationContext(), "ball", Toast.LENGTH_LONG).show();

                                    if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                        showProgressBar("loading...");
                                        AccountPresenter presenter = new AccountPresenterImpl(getActivity());
                                        presenter.setContext(getApplicationContext());
                                        presenter.createAccount(accountCreate_fName.toLowerCase(), accountCreate_lName.toLowerCase(), accountCreate_email.toLowerCase(), accountCreate_password);
                                    }
                                    else {
                                        displayAlertMessage("Please, Connect to the Internet.");
                                    }
                                }
                            }, 10);
                        }
                    }
                });
            }
        });
        accountCreatePanel.show();
    }


    //This function displays login dialog box.
    private void displayLoginDialog() {
        //Inflating and initializing login dialog box fragment.
        View loginDialogView = View.inflate(this, R.layout.view_login_dialog, null);
        loginEmail = (EditText) loginDialogView.findViewById(R.id.login_username);
        loginPassword = (EditText) loginDialogView.findViewById(R.id.login_password);

        final TextView loginStatusMessage = (TextView) loginDialogView.findViewById(R.id.login_error_message);
        //initially SettingActivity status message invisible
        loginStatusMessage.setVisibility(View.VISIBLE);
        loginStatusMessage.setText("");

        loginEmail.setText(UserDataCacheManager.getUserEmailFromCache(getApplicationContext()));

        loginDialog = new AlertDialog.Builder(this);
        loginDialog.setView(loginDialogView);
        loginDialog.setTitle("ACCOUNT LOGIN");
        loginDialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        loginDialog.setPositiveButton("LOGIN", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        loginPanel = loginDialog.create();
        //when this dialog is shown the following code is executed
        loginPanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(DialogInterface dialog) {
                Button button = loginPanel.getButton(DialogInterface.BUTTON_POSITIVE);
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        Log.d(TAG, "Login button is clicked.");
                        loginStatusMessage.setText("");

                        //this need to be in new thread or may be in service.
                        Log.d(TAG, "Validating the input i.e. if user has left either field blank.");
                        if (isLoginInputEmpty(loginEmail.getText().toString(), loginPassword.getText().toString())) {
                            Log.d(TAG, "Input is not empty. now submitting the login credential.");

                            //Again checking if the username i.e. email is correct format.
                            EmailValidator validator = new EmailValidator();
                            boolean validationStatus = validator.validate(loginEmail.getText().toString());
                            if (validationStatus == true) {
                                if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                    loginStatusMessage.setText("");
                                    UserDataCacheManager.storeUserEmailCache(getApplicationContext(), loginEmail.getText().toString());
                                    LoginPresenter loginPresenter = new LoginPresenterImpl(getActivity());
                                    loginPresenter.setContext(getApplicationContext());
                                    loginPresenter.validateCredentials(loginEmail.getText().toString().toLowerCase(), loginPassword.getText().toString());
                                }
                                else {
                                    displayAlertMessage("Please, Connect to the Internet.");
                                }
                                //Reseting the form temp data.
                            } else {
                                String message = "Invalid email format.";
                                loginStatusMessage.setText(message);
                                /*new Handler().postDelayed(new Runnable() {
                                    @Override
                                    public void run() {
                                        //loginStatusMessage.setVisibility(View.VISIBLE);
                                        displayLoginDialog(message);
                                        //loginDialog.show();
                                    }
                                }, 10);*/
                            }
                        } else {
                            Log.d(TAG, "Input is empty.");
                            //SettingActivity error text
                            String message = "";
                            if (loginEmail.getText().toString().equals("") && loginPassword.getText().toString().equals("")) {
                                message = "Username & Password are empty.";
                            } else if (loginEmail.getText().toString().equals("")) {
                                message = "Please, enter Username.";
                            } else if (loginPassword.getText().toString().equals("")) {
                                message = "Please, enter Password.";
                            }
                            //this is an effect so that LoginView box with error message will appear after .1 second in the LoginView panel
                            //the loginDialog.show() has been included in the handler because otherwise it will not show up
                            //since the old screen is already on the screen the new screen will not display so new screen must
                            //appear after closing the old screen. any time delay will remove the old display and new display
                            //can be easily show() in the screen.
                            /*final String finalMessage = message;
                            new Handler().postDelayed(new Runnable() {
                                @Override
                                public void run() {
                                    //loginStatusMessage.setVisibility(View.VISIBLE);
                                    displayLoginDialog(finalMessage);
                                    //loginDialog.show();
                                }
                            }, 10);*/
                            loginStatusMessage.setText(message);
                        }
                    }
                });
            }
        });
        //loginDialog.create();
        //loginDialog.show();
        loginPanel.show();
    }

    //this function validates if the Login data are empty or not.
    private boolean isLoginInputEmpty(String username, String password) {
        Log.d(TAG, "Checking the username and password for empty input.");
        return !(username.equals("") || password.equals(""));
    }

    //Displays invalid password or username error if the authentication fails.
    @Override
    public void displayInvalidLoginMessage(String message) {
        //loginStatusMessage.setText("Invalid Username/Password.");
        //loginStatusMessage.setVisibility(View.VISIBLE);
        //displayLoginDialog();
        //loginDialog.show();
        displayAlertMessage(message);
    }


    //this function re-constructure the navigation panel profile information such as username and email and other components.
    @Override
    public void reConstructNavigationPanel(boolean status) {
        Log.d(TAG, "Reconstructing the navigation panel. If user is logged in: True else False. Value: " + status);
        //if user value is not stored in the prefrence i.e. user is not logged in.
        if (status == false) {
            Log.d(TAG, "User is not logged in.");
            Toast.makeText(this, "You are not logged in", Toast.LENGTH_LONG).show();
            username.setText("Welcome User");
            email.setText("sign-in");
            view_profile_or_login.setClickable(true);
            view_profile_or_login.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    //Toast.makeText(getApplicationContext(), "You select to sign-in", Toast.LENGTH_LONG).show();
                    if (connection.isNetworkConnected()==true) {
                        Log.d(TAG, "Internet connection is available.");
                        displayLoginDialog();
                        //loginDialog.show();
                    } else {
                        Log.d(TAG, "Please, Connect to the Internet.");
                        Toast.makeText(getApplicationContext(), "Not connected to Internet.", Toast.LENGTH_LONG).show();
                    }
                }
            });
        }
        //if user value is stored i.e. user is logged in previously then get the username and email and display in navigation bar.
        else {
            Toast.makeText(this, "You are logged in", Toast.LENGTH_LONG).show();
            Log.d(TAG, "User is logged in.");

            String[] data = UserDataCacheManager.getUserDataFromCache(this);
            //Log.d(TAG, data);
            //input.substring(0, 1).toUpperCase() + input.substring(1);
            username.setText(data[0].substring(0, 1).toUpperCase() + data[0].substring(1));
            email.setText(data[1].substring(0, 1).toUpperCase() + data[1].substring(1));

            view_profile_or_login.setClickable(true);
            view_profile_or_login.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    startActivity(new Intent(getApplicationContext(), ProfileActivity.class));
                    //no need to add data in bundle... can get data from shared preferences.
                }
            });
        }
        navigationPanelFragment.setListMenuItems();
    }

    @Override
    public MainActivity getActivity() {
        return this;
    }

    @Override
    public void hideLoginView() {
        //first hiding the account activation form
        loginPanel.dismiss();
    }


    @Override
    public void displayAlertMessage(String alertMessage) {
        //status message dialog box
        statusMessageDialog = new AlertDialog.Builder(this);
        statusMessageDialog.setMessage(alertMessage);
        statusMessageDialog.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        statusMessageDialog.show();
    }

    @Override
    public void navigateToMainPage(boolean status) {
        //first hiding the account activation form
        accountActivationPanel.dismiss();

        if(status==true) {
            reConstructNavigationPanel(true);
        }
        else{
            reConstructNavigationPanel(false);
        }
    }

    @Override
    public void displayAccountActivationPage() {
        //first hiding the account create form from the window.

        //try catch to avoid null point error if it is from login account activation redirection.
        try {
            accountCreatePanel.dismiss();
        }catch(NullPointerException e){}

        //everything works fine now submitting data.
        final AccountPresenter presenter = new AccountPresenterImpl(getActivity());
        presenter.setContext(getApplicationContext());

        //Inflating and initializing login dialog box fragment.
        View view = View.inflate(this, R.layout.view_account_activation, null);
        final EditText code = (EditText) view.findViewById(R.id.view_activate_account_code);
        Button reSendButton = (Button) view.findViewById(R.id.view_activate_account_resend);

        reSendButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                presenter.reSendCode(UserDataCacheManager.getUserEmailFromCache(getApplicationContext()));
            }
        });
        final AlertDialog.Builder activationDialog = new AlertDialog.Builder(this);
        activationDialog.setView(view);
        activationDialog.setTitle("ACTIVATE ACCOUNT");
        activationDialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });

        activationDialog.setPositiveButton("ACTIVATE", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {}
        });
        accountActivationPanel = activationDialog.create();
        accountActivationPanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(DialogInterface dialog) {
                Button button = accountActivationPanel.getButton(DialogInterface.BUTTON_POSITIVE);
                button.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        String activationCode = code.getText().toString();
                        if (activationCode.equals("") || activationCode.equals(null)) {
                            Toast.makeText(getApplicationContext(), "Activation code is empty", Toast.LENGTH_LONG).show();
                        } else {
                            int a_code = Integer.parseInt(activationCode);
                            presenter.activate(UserDataCacheManager.getUserEmailFromCache(getApplicationContext()), a_code);
                        }
                    }
                });
            }
        });
        accountActivationPanel.show();
    }


    //this function hides the resetPassword panel after password is reseted and user is being logged in in background.
    @Override
    public void hideAccountActivationPanel(){
        accountActivationPanel.dismiss();
    }

    //This message shows progress bar
    @Override
    public void showProgressBar(String loadingMessage) {
        //Loading progressbar instantiation
        progressBar = new ProgressDialog(this);
        progressBar.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressBar.setMessage(loadingMessage);
        progressBar.setIndeterminate(true);
        progressBar.setCanceledOnTouchOutside(false);
        progressBar.show();
    }

    //THis method hides the progressbar
    @Override
    public void hideProgressBar() {
        progressBar.dismiss();;
    }


    //This function change the tab from navigational panel fragment
    public void changeTabsByButton(int id){
        mPager.setCurrentItem(id);
        navigationPanelFragment.closeDrawer();
    }


    //This function logout the user
    public void logout(){
        AccountPresenter presenter = new AccountPresenterImpl(this);
        presenter.setContext(getApplicationContext());
        presenter.logout();
    }

    @Override
    protected void onResume() {
        super.onResume();
        navigationPanelFragment.openDrawer();
    }


    //Following is reset password section
    //##############################################################################################

    //This function displays reset password dialog form step 1
    @Override
    public void displayResetPasswordStep1(){
        //Inflating and initializing login dialog box fragment.
        View view = View.inflate(this, R.layout.view_reset_password, null);
        resetPassword_email = (EditText) view.findViewById(R.id.view_reset_password_email);

        //layout option.
        //initially displaying step 1 layout.
        LinearLayout step1 = (LinearLayout) view.findViewById(R.id.view_reset_password_step1);
        LinearLayout step2 = (LinearLayout) view.findViewById(R.id.view_reset_password_step2);
        LinearLayout step3 = (LinearLayout) view.findViewById(R.id.view_reset_password_step3);

        step1.setVisibility(View.VISIBLE);
        step2.setVisibility(View.GONE);
        step3.setVisibility(View.GONE);

        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setView(view);
        dialog.setTitle("RESET PASSWORD");
        dialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        dialog.setPositiveButton("NEXT", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        resetPasswordPanel = dialog.create();
        resetPasswordPanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(final DialogInterface dialog) {
                Button cancelButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_NEGATIVE);
                Button nextButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_POSITIVE);

                cancelButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        dialog.dismiss();
                       /* AlertDialog.Builder d = new AlertDialog.Builder(getApplicationContext());
                        d.setTitle("ALERT");
                        d.setMessage("Are you sure want cancel to reset your Password?");
                        d.setNegativeButton("YES", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();  //dismissing the alert dialog.
                                dialog.dismiss(); //now dismiss the reset password dialog.
                            }
                        });
                        d.setPositiveButton("NO", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();
                            }
                        });
                        d.create();
                        d.show();*/
                    }
                });

                nextButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        //first checking email format is correct or not.
                        boolean isEmailValid = new EmailValidator().validate(resetPassword_email.getText().toString());
                        if(isEmailValid){

                            if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                //proceed to check email in server
                                AccountPresenter presenter = new AccountPresenterImpl(getActivity());
                                presenter.setContext(getApplicationContext());
                                presenter.sendResetCode(resetPassword_email.getText().toString().toLowerCase());
                            }
                            else {
                                displayAlertMessage("Please, Connect to the Internet.");
                            }
                        }
                        else{
                            displayAlertMessage("Invalid email address. Please, check and try again.");
                        }
                    }
                });
            }
        });
        resetPasswordPanel.show();
    }
    //This function displays reset password dialog form step 2
    @Override
    public void displayResetPasswordStep2(){
        //Inflating and initializing login dialog box fragment.
        View view = View.inflate(this, R.layout.view_reset_password, null);
        resetPassword_resetCode = (EditText) view.findViewById(R.id.view_reset_password_code);

        //layout option.
        //initially displaying step 1 layout.
        LinearLayout step1 = (LinearLayout) view.findViewById(R.id.view_reset_password_step1);
        LinearLayout step2 = (LinearLayout) view.findViewById(R.id.view_reset_password_step2);
        LinearLayout step3 = (LinearLayout) view.findViewById(R.id.view_reset_password_step3);

        step1.setVisibility(View.GONE);
        step2.setVisibility(View.VISIBLE);
        step3.setVisibility(View.GONE);

        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setView(view);
        dialog.setTitle("RESET PASSWORD");
        dialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        dialog.setPositiveButton("NEXT", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        resetPasswordPanel = dialog.create();
        resetPasswordPanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(final DialogInterface dialog) {
                Button cancelButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_NEGATIVE);
                Button nextButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_POSITIVE);

                cancelButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        dialog.dismiss();
                       /* AlertDialog.Builder d = new AlertDialog.Builder(getApplicationContext());
                        d.setTitle("ALERT");
                        d.setMessage("Are you sure want cancel to reset your Password?");
                        d.setNegativeButton("YES", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();  //dismissing the alert dialog.
                                dialog.dismiss(); //now dismiss the reset password dialog.
                            }
                        });
                        d.setPositiveButton("NO", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();
                            }
                        });
                        d.create();
                        d.show();*/
                    }
                });

                nextButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        //first checking code is empty or not
                        if(resetPassword_resetCode.getText().toString().equals("") || resetPassword_resetCode.getText().toString().equals(null)){
                            displayAlertMessage("You didn't enter RESET CODE.");
                        }
                        else{
                            if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                //proceed to check email in server
                                AccountPresenter presenter = new AccountPresenterImpl(getActivity());
                                presenter.setContext(getApplicationContext());
                                presenter.validateResetCode(Integer.parseInt(resetPassword_resetCode.getText().toString()));
                            }
                            else {
                                displayAlertMessage("Please, Connect to the Internet.");
                            }
                        }
                    }
                });
            }
        });
        resetPasswordPanel.show();
    }
    //This function displays reset password dialog form step 3
    @Override
    public void displayResetPasswordStep3(){
        //Inflating and initializing login dialog box fragment.
        View view = View.inflate(this, R.layout.view_reset_password, null);
        resetPassword_newPassword = (EditText) view.findViewById(R.id.view_reset_password_new_password1);
        final EditText resetPassword_newPassword2 = (EditText) view.findViewById(R.id.view_reset_password_new_password2);

        //layout option.
        //initially displaying step 1 layout.
        LinearLayout step1 = (LinearLayout) view.findViewById(R.id.view_reset_password_step1);
        LinearLayout step2 = (LinearLayout) view.findViewById(R.id.view_reset_password_step2);
        LinearLayout step3 = (LinearLayout) view.findViewById(R.id.view_reset_password_step3);

        step1.setVisibility(View.GONE);
        step2.setVisibility(View.GONE);
        step3.setVisibility(View.VISIBLE);

        AlertDialog.Builder dialog = new AlertDialog.Builder(this);
        dialog.setView(view);
        dialog.setTitle("RESET PASSWORD");
        dialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        dialog.setPositiveButton("FINISH", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
            }
        });
        resetPasswordPanel = dialog.create();
        resetPasswordPanel.setOnShowListener(new DialogInterface.OnShowListener() {
            @Override
            public void onShow(final DialogInterface dialog) {
                Button cancelButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_NEGATIVE);
                Button nextButton = resetPasswordPanel.getButton(DialogInterface.BUTTON_POSITIVE);

                cancelButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        dialog.dismiss();
                        /*AlertDialog.Builder d = new AlertDialog.Builder(getApplicationContext());
                        d.setTitle("ALERT");
                        d.setMessage("Are you sure want cancel to reset your Password?");
                        d.setNegativeButton("YES", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();  //dismissing the alert dialog.
                                dialog.dismiss(); //now dismiss the reset password dialog.
                            }
                        });
                        d.setPositiveButton("NO", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog1, int which) {
                                dialog1.dismiss();
                            }
                        });
                        d.create();
                        d.show();*/
                    }
                });

                nextButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        //first checking if password field is empty or not
                        if(resetPassword_newPassword.getText().toString().equals("") || resetPassword_newPassword.getText().toString().equals(null)){
                            displayAlertMessage("Password is empty. Please, enter and try again.");
                        }
                        else if(resetPassword_newPassword.getText().toString().equals(resetPassword_newPassword2.getText().toString())){
                            displayAlertMessage("Password does not match. Please, check and try again.");
                        }
                        else{
                            if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
                                //proceed to check email in server
                                AccountPresenter presenter = new AccountPresenterImpl(getActivity());
                                presenter.setContext(getApplicationContext());
                                try {
                                    presenter.resetPassword(resetPassword_newPassword.getText().toString());
                                } catch (JSONException e) {
                                    e.printStackTrace();
                                    Toast.makeText(getApplicationContext(), "Something went wrong. Please, try again later.", Toast.LENGTH_LONG).show();
                                }
                            }
                            else {
                                displayAlertMessage("Please, Connect to the Internet.");
                            }
                        }
                    }
                });
            }
        });
        resetPasswordPanel.show();
    }

    //this function hides the resetPassword panel after password is reseted and user is being logged in in background.
    @Override
    public void hideResetPasswordPanel(){
        resetPasswordPanel.dismiss();
    }


    //This function starts auto updating pinned vehicle details.
    public void startVehicleDetailsAutoUpdate(){
        //update in every 20 seconds.
        Log.d(TAG, "Background update started from main activity.");
        if(vehicleUpdateSuspendStatus==false) {
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    backgroundUpdate.getVehicleUpdate();
                }
            }, 20000);
        }
        else{
            //do nothing. i guess.
            Toast.makeText(getApplicationContext(), "Vehicle Location update failed.", Toast.LENGTH_LONG).show();
        }
    }

    //This function stops auto updating pinned vehicle details.
    public void stopVehicleDetailsAutoUpdate(){
        vehiclePinnedStatus = false;
        vehicleUpdateSuspendStatus = false;
        VehicleDataCacheManager.clearVehicle(getApplicationContext());
        TabsPagerAdapter t = (TabsPagerAdapter)mPager.getAdapter();
        t.getPinnedFragment().resetDashboard();
        t.getRouteFragment().resetDashboard();
        t.getPaymentFragment().resetDashboard();
    }

    //This function stops auto updating pinned vehicle details.
    public void suspendVehicleDetailsAutoUpdate(){
        vehicleUpdateSuspendStatus = true;
    }

    public void resumeVehicleDetailAutoUpdate(){
        vehicleUpdateSuspendStatus = false;
        if(vehiclePinnedStatus==true) {
            startVehicleDetailsAutoUpdate();
        }
    }

    //used this function to display update failed message on pinned fragment.
    public boolean isVehicleSuspended(){
        return vehicleUpdateSuspendStatus;
    }
}
