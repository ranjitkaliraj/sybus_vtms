package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.presenter.AccountPresenter;
import com.sybus.android.userapp.presenterImpl.AccountPresenterImpl;
import com.sybus.android.userapp.util.EmailValidator;
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.view.AccountView;

public class create_account extends AppCompatActivity implements AccountView {

    public String TAG = this.getClass().getName();

    private EditText fName;
    private EditText lName;
    private EditText email;
    private EditText password1;
    private EditText password2;
    private Button submit;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    private NetworkConnection internet;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_account);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        internet = new NetworkConnection(this);

        fName = (EditText) findViewById(R.id.create_account_fName);
        lName = (EditText) findViewById(R.id.create_account_lName);
        email = (EditText) findViewById(R.id.create_account_email);
        password1 = (EditText) findViewById(R.id.create_account_password1);
        password2 = (EditText) findViewById(R.id.create_account_password2);

        submit = (Button) findViewById(R.id.create_account_submit);
        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(internet.isNetworkConnected()){
                    displayAlertMessage("Please, connect to the Internet.");
                }
                else if(fName.getText().toString().equals(null) || fName.getText().equals("")){
                    displayAlertMessage("Please, enter your first name.");
                }
                else if(lName.getText().toString().equals(null) || lName.getText().equals("")){
                    displayAlertMessage("Please, enter your last name.");
                }
                else if(email.getText().toString().equals(null) || email.getText().equals("")){
                    displayAlertMessage("Please, enter your email address.");
                }
                else if(password1.getText().toString().equals(null) || password1.getText().equals("")){
                    displayAlertMessage("Please, enter your password.");
                }
                else if(password2.getText().toString().equals(null) || password2.getText().equals("")){
                    displayAlertMessage("Please, re-enter your password.");
                }
                else if(!password2.getText().toString().equals(password1.getText().toString())){
                    displayAlertMessage("Password did not match. Please, re-enter again.");
                }
                else {
                    EmailValidator validator = new EmailValidator();
                    if (password1.getText().toString().equals(password2.getText().toString())) {
                        if (validator.validate(email.getText().toString()) == true) {
                            final AccountPresenter user = new AccountPresenterImpl(getActivity());
                            user.setContext(getApplicationContext());
                            Log.d(TAG, fName.getText().toString()+ lName.getText().toString()+ password1.getText().toString()+ email.getText().toString());
                            user.createAccount(fName.getText().toString(), lName.getText().toString(), password1.getText().toString(), email.getText().toString());

                        } else {
                            displayAlertMessage("Invalid Email address.");
                        }
                    } else {
                        displayAlertMessage("Password does not match.");
                    }
                }
            }
        });
    }


    public create_account getActivity(){
        return this;
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_create_account, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        if (id == R.id.home){
            this.dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
            super.onBackPressed();
            finish();
        }

        return super.onOptionsItemSelected(item);
    }




    //This message shows progress bar
    public void showProgressBar(String loadingMessage) {
        //Loading progressbar instantiation
        Log.d(TAG, "Displaying the progress bar.");
        progressBar = new ProgressDialog(this);
        progressBar.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progressBar.setMessage(loadingMessage);
        progressBar.setIndeterminate(true);
        progressBar.setCanceledOnTouchOutside(false);
        progressBar.show();
    }

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

    }

    public void navigateToMainPage() {
        Intent intent = new Intent(getApplicationContext(), MainActivity.class);
        //intent.putExtra("vehicleDetail",vehicle);
        startActivity(intent);
    }

    @Override
    public void displayAccountActivationPage() {

    }

    @Override
    public void displayAccountRegistrationView() {

    }

    @Override
    public void hideAccountActivationPanel() {

    }

    @Override
    public void reConstructNavigationPanel(boolean option) {

    }

    @Override
    public void displayResetPasswordStep1() {

    }

    @Override
    public void displayResetPasswordStep2() {

    }

    @Override
    public void displayResetPasswordStep3() {

    }

    @Override
    public void hideResetPasswordPanel() {

    }

    //THis method hides the progressbar
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        //progressBar.hide();
        progressBar.dismiss();
    }
}
