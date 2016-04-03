package com.sybus.android.driverapp.views;

import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ProgressBar;

//import com.google.gson.Gson;
//import com.ronzeyet.syapp.sybus.R;
//import com.ronzeyet.syapp.sybus.util.ImageCache;

import com.sybus.android.driverapp.R;

import static java.lang.Thread.sleep;

public class SplashActivity extends AppCompatActivity {

    private final String TAG = this.getClass().getName();

    private ProgressBar progressBar = null;
    private static int SPLASH_SCREEN_TIME = 4000;
    //private ImageCache img;

    private int cycles = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        Log.d(TAG, "Initializing and waiting for 4 seconds for splash screen.");
        //showing the splash screen for 4 seconds before application homescreen start
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                Log.d(TAG, "Starting the MainActivity Class.");
                Intent intent = new Intent(getApplicationContext(), MainActivity.class);

                //adding the image cache object on the bundle
                //intent.putExtra("imageCache", new Gson().toJson(img));
                startActivity(intent);
                SplashActivity.this.finish();
            }
        }, SPLASH_SCREEN_TIME);

        //Creating the progressbar
        Log.d(TAG, "Initializing and running the progress bar.");
        progressBar = (ProgressBar) findViewById(R.id.splash_progressBar);         //Loading progress bar
        progressBar.setMax(100);
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                //initially sleeping for 1 seconds (1 second is spend on opening the app so to avoid loading bar to start from middle 1 second added before starting progress bar.)
                try {sleep(1000);} catch (InterruptedException e) {e.printStackTrace();}
                while (cycles!=100){
                    try {
                        sleep(30);     //Static method import Thread.sleep()
                        cycles++;
                        progressBar.setProgress(cycles);
                    }
                    catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
        });
        thread.start();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_splash, menu);
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

        return super.onOptionsItemSelected(item);
    }
}
