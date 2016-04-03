package com.sybus.android.userapp.ui;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.FrameLayout;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.presenter.RouteViewPresenter;
import com.sybus.android.userapp.presenterImpl.RouteViewPresenterImpl;
import com.sybus.android.userapp.ui.adapters.routeViewAdapter;
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.view.RouteView;

import java.util.ArrayList;

public class ViewRouteActivity extends AppCompatActivity implements routeViewAdapter.TouchListener, RouteView{

    public String TAG = this.getClass().getName();

    private RecyclerView recycleView;
    private routeViewAdapter adapter;

    private FrameLayout notAvailablePanel;

    private ProgressDialog progressBar;
    private AlertDialog.Builder statusMessageDialog;

    private RouteViewPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_route);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_view_route, menu);

        recycleView = (RecyclerView) findViewById(R.id.view_route_lists);
        notAvailablePanel = (FrameLayout) findViewById(R.id.view_route_lists_not_available);

        if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
            presenter = new RouteViewPresenterImpl(this);
            presenter.setContext(getApplicationContext());
            presenter.getAvailableRouteList();
        }
        else {
            displayAlertMessage("Please, Connect to the Internet.");
            displayNoRouteMessage();
        }
        //getting route list
       /* new Handler().post(new Runnable() {
            @Override
            public void run() {

                RouteImpl route = new RouteImpl();
                route.getRouteListForView(getActivity());
            }
        });
        */
        return true;
    }

    public ViewRouteActivity getActivity(){
        return this;
    }

    public void setRouteList(ArrayList<String> routes){
        Log.d(TAG, "Displaying route list."+routes.toString());
        adapter = new routeViewAdapter(this, routes);
        adapter.setTouchListener(this);
        recycleView.setAdapter(adapter);
        recycleView.setLayoutManager(new LinearLayoutManager(this));
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
    public void menuItemClicked(int position, String routeName) {
        if(new NetworkConnection(getApplicationContext()).isNetworkConnected()) {
            presenter.getRouteCoordinates(routeName);
        }
        else {
            displayAlertMessage("Please, Connect to the Internet.");
        }
    }

    @Override
    public void displayMap(ArrayList<LngLat> data){
        Intent i = new Intent(this, view_route_on_map.class);
        i.putExtra("data",data);
        startActivity(i);
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

    @Override
    public void displayRouteLists(ArrayList<String> list) {
        recycleView.setVisibility(View.VISIBLE);
        notAvailablePanel.setVisibility(View.GONE);

        setRouteList(list);
    }

    @Override
    public void displayNoRouteMessage() {
        recycleView.setVisibility(View.GONE);
        notAvailablePanel.setVisibility(View.VISIBLE);
    }
}
