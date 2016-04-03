package com.sybus.android.userapp.ui;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.app.SearchManager;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.location.Location;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ProgressBar;
import android.widget.SearchView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.pojo.SearchVehicleDto;
import com.sybus.android.userapp.presenter.SearchPresenter;
import com.sybus.android.userapp.presenterImpl.SearchPresenterImpl;
import com.sybus.android.userapp.ui.adapters.SearchSuggestionAdapter;
import com.sybus.android.userapp.ui.adapters.VehicleSearchResultAdapter;
import com.sybus.android.userapp.util.LocationManagerLocationProvider;
import com.sybus.android.userapp.util.SettingManager;
import com.sybus.android.userapp.view.SearchResultView;

import java.util.ArrayList;

public class SearchActivity extends AppCompatActivity implements com.sybus.android.userapp.view.SearchView, SearchResultView, VehicleSearchResultAdapter.TouchListener {

    public String TAG = this.getClass().getName();

    private SearchView searchView;
    private ProgressDialog progressBar;

    private RecyclerView recycleView;
    private VehicleSearchResultAdapter adapter;

    private ArrayList<SearchVehicleDto> results;
    private String destination;     //stores the searched destination name
    private long userSelectedVehicle;

    private SearchPresenter searchResultPresenter;

    //Searchview variables
    private SearchSuggestionAdapter searchAdapter;
    private ProgressBar searchViewIndicator;
    private SearchPresenter searchPresenter;
    private int userLocationRetriveCount;
    private LocationManagerLocationProvider locationManagerLocationProvider;
    private Location location;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        //Creating a new toolbar from layout app_bar_view_view.xml
        Log.d(TAG, "Initializing and adding toolbar.");
        Toolbar toolbar = (Toolbar) findViewById(R.id.app_bar);
        setSupportActionBar(toolbar);

        //Displaying the Home button in the appbar
        Log.d(TAG, "Enabling setDisplayShowHomeEnable() to true.");
        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        //search result view.
        searchResultPresenter = new SearchPresenterImpl(this, null);
        searchResultPresenter.setContext(this);
        //search view.
        searchPresenter = new SearchPresenterImpl(null, this);
        searchPresenter.setContext(this);

        //displaying the loading animation untill the data is downloaded.
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                showProgressBar("Finding vehicles...");
            }
        }, 1);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_search, menu);

        //Initializing the toolbar search bar.
        Log.d(TAG, "Initializing the toolbar search bar");
        SearchManager searchManager = (SearchManager) getSystemService(Context.SEARCH_SERVICE);
        searchView = (SearchView) menu.findItem(R.id.vehicle_search).getActionView();
        searchView.setSearchableInfo(searchManager.getSearchableInfo(getComponentName()));
        searchView.setIconifiedByDefault(false);
        searchView.setSubmitButtonEnabled(true);
        searchView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //code to search vehicle.
            }
        });


        recycleView = (RecyclerView) findViewById(R.id.search_result_items);
       /* SearchVehicleDto dto = new SearchVehicleDto();
        dto.setCurrentLocation("");
        dto.setDestinationStop("");
        dto.setETA("");
        dto.setNextStop("");
        dto.setRouteName("");
        dto.setUserNearStop("");
        dto.setVehicleName("");
        ArrayList<SearchVehicleDto> a = new ArrayList<>();
        a.add(dto);
        //adding a to avoid adapter not attached error.
        adapter = new VehicleSearchResultAdapter(this, a);
        adapter.setTouchListener(this);
        recycleView.setAdapter(adapter);
        recycleView.setLayoutManager(new LinearLayoutManager(this));
*/

        //SettingActivity entered destination name from home search view
        Intent i = getIntent();
        String destName = i.getStringExtra("destination");
        String stopName = i.getStringExtra("route");
        String routeName = i.getStringExtra("stop");

        try {
            if (destName.equals(null)) {
                destName = "";
            }

        } catch (NullPointerException e) {
            destName = "";
            //displayAlertMessage("Cannot find vehicle. Please, try again.");
        }
        try {
            if (stopName.equals(null)) {
                stopName = "";
            }

        } catch (NullPointerException e) {
             stopName = "";
            //displayAlertMessage("Cannot find vehicle. Please, try again.");
        }
        try {
            if (routeName.equals(null)) {
                routeName = "";
            }

        } catch (NullPointerException e) {
            routeName = "";
            //displayAlertMessage("Cannot find vehicle. Please, try again.");
        }

        if (!destName.equals("")) {
            searchView.setQuery(i.getStringExtra("destination"), false);
            Log.d(TAG, "Getting vehicle for destinatoin.");
            //now getting vehicle data.
            findVehiclesForDestination(i.getStringExtra("destination"), i.getDoubleExtra("longitude", 0), i.getDoubleExtra("latitude", 0));

        } else if (!routeName.equals("")) {
            Log.d(TAG, "Getting vehicle for route.");
            findVehiclesForRoute(routeName);

        } else if (!stopName.equals("")) {
            Log.d(TAG, "Getting vehicle for stop.");
            findVehiclesForStop(stopName);
        }

        searchView.setQuery(i.getStringExtra("destination"), false);

        //now getting vehicle data.
        findVehiclesForDestination(i.getStringExtra("destination"), i.getDoubleExtra("longitude", 0), i.getDoubleExtra("latitude", 0));

        //Now, trigerring the search button of search view.
        //Log.d(TAG, "performing auto click");
        //searchView.performClick();

        hideKeyboard();

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
        if (id == R.id.home) {
            this.finish();
            return true;
            //this.dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_BACK));
            //super.onBackPressed();
        }

        return super.onOptionsItemSelected(item);
    }


    public void findVehiclesForDestination(String destination, Double lng, Double lat) {
        this.destination = destination;
        int range = SettingManager.getRange(this);
        Log.d(TAG, "finding vehicles");
        searchResultPresenter.findVehicle(destination, lng, lat, range);
    }


    //finding vehicle for given route.
    public void findVehiclesForRoute(String routeName) {
        searchResultPresenter.findVehicleForRoute(routeName);
    }


    //Finding vehicle for given // STOP
    public void findVehiclesForStop(String stopName) {
        searchResultPresenter.findVehicleForBusStop(stopName);
    }

    //displaying vehicle result.
    @Override
    public void displayResult(ArrayList<SearchVehicleDto> data) {
        //storing the result in the variable to use when displaying vehicle detail
        results = data;

        //Log.d(TAG, data.get(0).getVehicleName()+"");
        //Log.d(TAG, data.get(1).getVehicleName()+"");

        Log.d(TAG, data.size() + "");
        //recycleView = (RecyclerView) findViewById(R.id.search_result_items);
        adapter = new VehicleSearchResultAdapter(this, data);
        adapter.setTouchListener(this);
        recycleView.setAdapter(adapter);
        recycleView.setLayoutManager(new LinearLayoutManager(this));
    }


    @Override
    public void getVehicleDetail(Long sessionID, String userStop, String destStop, String destination) {
        searchResultPresenter.getVehicleDetailForDestination(sessionID, userStop, destStop, destination);
    }

    @Override
    public void DisplayVehicleDetail(DetailVehicleDto vehicle) {
        Log.d(TAG, "Now displaying vehicle detail.");
        //first adding the result.
        DetailVehicleDto newVehicle = new DetailVehicleDto();
        for (SearchVehicleDto dto : results) {
            //only getting detail of user selected vehicle
            Log.d(TAG, dto.getVehicleID()+"");

            if (dto.getVehicleID() == userSelectedVehicle) {
                //adding the result info in the downloaded DetailVehicleDto  -- it contain co-ordinates so need to add the list text details.
                newVehicle.setVehicle(dto);
                newVehicle.setWay(vehicle.getWay());
                newVehicle.setUserStopLocation(vehicle.getUserStopLocation());
                newVehicle.setVehicleLocation(vehicle.getVehicleLocation());
                newVehicle.setDestinationLocation(vehicle.getDestinationLocation());
                newVehicle.setDestStopLocation(vehicle.getDestStopLocation());

                Log.d(TAG, dto.getVehicleName());
                Log.d(TAG,"apple: "+vehicle.getVehicleLocation().getLongitude());

                Intent detailActivity = new Intent(this, DetailActivity.class);
                detailActivity.putExtra("vehicleDetail",newVehicle);
                startActivity(detailActivity);
            }
        }
    }


    //This message shows progress bar
    @Override
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

    //THis method hides the progressbar
    @Override
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        //progressBar.hide();
        progressBar.dismiss();
    }

    @Override
    public void displayAlertMessage(String alertMessage) {
        Log.d(TAG, "Displaying alert message: " + alertMessage);
        //status message dialog box
        AlertDialog.Builder statusMessageDialog = new AlertDialog.Builder(this);
        statusMessageDialog.setMessage(alertMessage);
        statusMessageDialog.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        statusMessageDialog.show();
    }


    //##############################################################################################
    //SearchView override methods.

    @Override
    public void displaySearchViewLoadingIndicator() {
        searchViewIndicator.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideSearchViewLoadingIndicator() {
        searchViewIndicator.setVisibility(View.INVISIBLE);
    }

    @Override
    public void setSuggestionResult(ArrayList<String> data) {
        Log.d(TAG, "Initializing and Setting suggestion in the adapter.");
        searchAdapter.setData(data);
        searchView.setSuggestionsAdapter(searchAdapter);
    }

    //Finding vehicles. This method gets the user location and destination and start search activity to find vehicle details.
    @Override
    public void findVehicles() {
        Log.d(TAG, "Finding the vehicle.");
        //showProgressBar("Finding vehicles...");
        //first getting user location.
        Log.d(TAG, "Getting user location");
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                location = locationManagerLocationProvider.getLocation();
                //location = googleApiLocationProvider.getLocation();
                //Log.d(TAG, location.getLatitude()+"");
                if (location == null && userLocationRetriveCount < 10) {        //trying for 10 times.
                    Log.d(TAG, "Location is null, retrieving again.");
                    userLocationRetriveCount = userLocationRetriveCount + 1;
                    findVehicles();
                } else if (userLocationRetriveCount == 10) {
                    showProgressBar("Finding vehicles...");
                    Toast.makeText(getApplicationContext(), "Unable to identify user current location.", Toast.LENGTH_LONG).show();
                } else {

                    hideProgressBar();
                    Double longitude = location.getLongitude();
                    Double latitude = location.getLatitude();

                    Log.d(TAG, "Now, searching the vehicle. User location: lng: " + longitude + ", lat: " + latitude);
                    Intent searchActivity = new Intent(getApplicationContext(), SearchActivity.class);
                    Bundle bundle = new Bundle();
                    searchActivity.putExtra("destination", destination);
                    searchActivity.putExtra("longitude", longitude);
                    searchActivity.putExtra("latitude", latitude);
                    startActivity(searchActivity);
                }
            }
        }, 2000);
    }

    @Override
    public void displayRouteSearchOption(ArrayList<String> routes) {

    }

    @Override
    public void displayBusStopSearchOption(ArrayList<String> stops) {

    }


    //Implemented method from adapter
    @Override
    public void menuItemClicked(int position, long vehicleID) {
        userSelectedVehicle = vehicleID;
        Log.d(TAG, "Getting detail for vehicle id:" + vehicleID);
        for (SearchVehicleDto dto : results) {
            if (dto.getVehicleID() == vehicleID) {
                String userStop = dto.getUserNearStop();
                String destStop = dto.getDestinationStop();
                this.getVehicleDetail(vehicleID, userStop, destStop, destination);
            }
        }
    }

    public void hideKeyboard() {
        try {
            InputMethodManager inputMethodManager = (InputMethodManager) this.getSystemService(Activity.INPUT_METHOD_SERVICE);
            inputMethodManager.hideSoftInputFromWindow(this.getCurrentFocus().getWindowToken(), 0);
        }
        catch (Exception e){}
    }
}
