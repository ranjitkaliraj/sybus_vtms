package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.ui.components.AlertManager;
import com.sybus.android.userapp.util.SettingManager;
import com.sybus.android.userapp.util.SharePreferenceManager;

public class SettingActivity extends AppCompatActivity {

    public String TAG = this.getClass().getName();

    private TextView rangeValue;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setting);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        rangeValue = (TextView) findViewById(R.id.search_range_value);
        rangeValue.setText(SettingManager.getRange(this)+" meters");

        Button rangeSet = (Button) findViewById(R.id.set_range_value_button);

        rangeSet.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                displaySetRangeForm();
            }
        });
    }

    public void displaySetRangeForm(){
        final AlertManager dialogClass = new AlertManager(this);
        AlertDialog.Builder urlAlert = dialogClass.displayUrlSaveAlert();
        final ProgressDialog animation = AlertManager.getProgressDialog(this, "Saving...");

        urlAlert.setPositiveButton("SAVE", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                Log.d(TAG, "Save button clicked.");
                final String range = dialogClass.urlText.getText().toString();

                SettingManager.storeRange(getApplicationContext(), range);
                //SharePreferenceManager.saveToPreference(getApplicationContext(), "URL", url, "WEB_SERVICE_API_URL");

                dialog.dismiss();
                animation.show();

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        animation.dismiss();
                        Log.d(TAG, "Displaying toast.");
                        //String value = SharePreferenceManager.readFromPreference(getApplicationContext(),"URL","http://localhost","WEB_SERVICE_API_URL");
                        Toast.makeText(getApplicationContext(), "Range successfully saved: " + SettingManager.getRange(getApplicationContext()), Toast.LENGTH_LONG).show();
                        //rangeValue.setText(SettingManager.getRange(getApplicationContext()));
                        rangeValue.setText(SettingManager.getRange(getApplicationContext())+" meters");
                    }
                }, 1000);
            }
        });
        urlAlert.show();
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


    @Override
    public void onBackPressed() {
        //super.onBackPressed();
        finish();
    }

}
