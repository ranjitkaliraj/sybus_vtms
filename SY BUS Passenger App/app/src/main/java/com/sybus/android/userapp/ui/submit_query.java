package com.sybus.android.userapp.ui;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.modelImpl.UserImpl;
import com.sybus.android.userapp.presenter.QueryPresenter;
import com.sybus.android.userapp.presenterImpl.QueryPresenterImpl;
import com.sybus.android.userapp.util.EmailValidator;
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.view.QueryView;

import org.json.JSONException;

public class submit_query extends AppCompatActivity implements QueryView{

    public String TAG = this.getClass().getName();

    private EditText email;
    private EditText subject;
    private EditText message;
    private Button submit;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    private NetworkConnection internet;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_submit_query);


        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        internet = new NetworkConnection(this);

        email = (EditText) findViewById(R.id.query_email);
        subject = (EditText) findViewById(R.id.query_subject);
        message = (EditText) findViewById(R.id.query_message);
        submit = (Button) findViewById(R.id.query_submit);

        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //submitting query.
                //checking for empty field.
                if(!internet.isNetworkConnected()){
                    displayAlertMessage("Please, connect to the Internet.");
                }
                else if(subject.getText().toString().equals(null) || subject.getText().toString().equals("")){
                    displayAlertMessage("Subject field must be filled.");
                }
                else if(email.getText().toString().equals(null) || email.getText().toString().equals("")){
                    displayAlertMessage("Email must be provided.");
                }
                else if(message.getText().toString().equals(null) || message.getText().toString().equals("")){
                    displayAlertMessage("Please enter your message.");
                }
                else {
                    EmailValidator validator = new EmailValidator();
                    if (validator.validate(email.getText().toString()) == true) {
                        //submit query.
                        QueryPresenter presenter = new QueryPresenterImpl(getActivity());
                        presenter.setContext(getApplicationContext());
                        presenter.submitQuery(subject.getText().toString(), email.getText().toString(), message.getText().toString());
                    } else {
                        displayAlertMessage("Invalid Email address.");
                    }
                }
            }
        });

        hideKeyboard();
    }


    public submit_query getActivity(){
        return this;
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_submit_query, menu);
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

    //THis method hides the progressbar
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        //progressBar.hide();
        progressBar.dismiss();
    }



    public void hideKeyboard() {
        try {
            InputMethodManager inputMethodManager = (InputMethodManager) this.getSystemService(Activity.INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(this.getCurrentFocus().getWindowToken(), 0);
        }
        catch (Exception e){}
    }
}
