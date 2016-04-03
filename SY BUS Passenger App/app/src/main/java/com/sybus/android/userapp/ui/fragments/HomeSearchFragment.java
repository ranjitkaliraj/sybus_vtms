package com.sybus.android.userapp.ui.fragments;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.RelativeLayout;
import android.widget.SearchView;
import android.widget.Spinner;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.presenter.DestinationPresenter;
import com.sybus.android.userapp.presenter.SearchPresenter;
import com.sybus.android.userapp.presenterImpl.DestinationPresenterImpl;
import com.sybus.android.userapp.presenterImpl.SearchPresenterImpl;
import com.sybus.android.userapp.ui.SearchActivity;
import com.sybus.android.userapp.ui.adapters.SearchSuggestionAdapter;
import com.sybus.android.userapp.util.LocationManagerLocationProvider;
import com.sybus.android.userapp.util.NetworkConnection;

import java.util.ArrayList;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link PinnedFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class HomeSearchFragment extends Fragment implements com.sybus.android.userapp.view.SearchView {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private ImageView imageView = null;
    private Button searchButton = null;
    private SearchView searchView = null;
    //ImageView background = null;

    public String TAG = this.getClass().getName();

    private RelativeLayout route_search;
    private RelativeLayout stop_search;

    //presenters
    private DestinationPresenter destinationPresenter;
    private SearchPresenter searchPresnter;

    //searchAdapter
    private SearchSuggestionAdapter searchAdapter;

    private ProgressDialog progressBar;
    private ProgressBar searchViewIndicator;

    private String destination;     //holds the user input destination


    private int userLocationRetriveCount;

   // private GoogleApiLocationProvider googleApiLocationProvider;
    private LocationManagerLocationProvider locationManagerLocationProvider;
    //private GoogleApiLocationProvider googleApiLocationProvider;
    private Location location;

    private NetworkConnection internet;

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment HomeSearchFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static android.support.v4.app.Fragment newInstance(String param1, String param2) {
        HomeSearchFragment fragment = new HomeSearchFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    public HomeSearchFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }

        internet = new NetworkConnection(getContext());

        //Instantiating searchPresenter class.
        destinationPresenter = new DestinationPresenterImpl(this);
        searchPresnter = new SearchPresenterImpl(null, this);
        searchPresnter.setContext(getContext());
        destinationPresenter.setContext(getContext());
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        Log.d(TAG, "Creating Home search fragment.");
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_home, container, false);

        imageView = (ImageView) view.findViewById(R.id.home_page_imag);
        searchButton = (Button) view.findViewById(R.id.home_search_button);
        //background = (ImageView) view.findViewById(R.id.home_background);

        //Instantiating GPS location provider
        locationManagerLocationProvider = new LocationManagerLocationProvider(getContext());
        //googleApiLocationProvider = new GoogleApiLocationProvider(getActivity());

        searchViewIndicator = (ProgressBar) view.findViewById(R.id.search_view_loading_indicator);

        //instantiating search view searchAdapter.
        searchAdapter = new SearchSuggestionAdapter(getContext());

        //Instantiating search view.
        searchView = (SearchView) view.findViewById(R.id.searchView);
        searchView.setOnSuggestionListener(new SearchView.OnSuggestionListener() {
            @Override
            public boolean onSuggestionSelect(int position) {
                //Toast.makeText(getContext(), "Position: " + position, Toast.LENGTH_SHORT).show();
                searchView.clearFocus();
                return false;
            }

            @Override
            public boolean onSuggestionClick(int position) {
                //Toast.makeText(getContext(), "Clicked: " + position, Toast.LENGTH_SHORT).show();
                //String value = String.valueOf(searchView.getSuggestionsAdapter().getItem(position));
                Cursor cursor = searchView.getSuggestionsAdapter().getCursor();
                String value = cursor.getString(1);         //here 1 is the column no.

                Log.d(TAG, "Search view Entered text : " + value);
                searchView.setQuery(value, false);  //false so it will not submit
                return true;       //this must return true if we want to set the query
            }
        });

        //SettingActivity query text listener, when user type any text this event trigger
        //user to download suggestion and also submit the request to find vehicle
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                //search vehicle when user clicked keyboard search button instead of the display button.
                Log.d(TAG, "Submitting query from query text listener. Destination : " + searchView.getQuery().toString());
                //Log.d(TAG, "apple 0: "+searchView.getQuery().toString());
                validateDestination(searchView.getQuery().toString());
                return true;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                //sending request to download suggestion.
                Log.d(TAG, "Sending request to download suggestion data for new criteria: " + newText);
                requestSuggestion(newText);
                return true;
            }

        });

        //not focusing on search text view when page load.
        searchView.clearFocus();

        searchButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Toast.makeText(getContext(), "search button", Toast.LENGTH_LONG).show();
                if (searchView.getQuery().toString().equals("") || searchView.getQuery().toString().equals(null)) {
                    displayAlertMessage("Please, enter a destination name to find a Bus.");
                } else {
                    Log.d(TAG, "apple 1: " + searchView.getQuery().toString());
                    validateDestination(searchView.getQuery().toString());
                }
            }
        });

        //Instantiating option search
        route_search = (RelativeLayout) view.findViewById(R.id.search_option_route);
        stop_search = (RelativeLayout) view.findViewById(R.id.search_option_stop);

        route_search.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "VehicleImpl search option by RouteImpl search option clicked");
                requestRouteListForSearch();
            }
        });

        stop_search.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "VehicleImpl search option by Stop search option clicked");
                requestBusstopListForSearch();
            }
        });

        return view;
    }


    //This function get the suggestions
    public void requestSuggestion(String criteria){
        Log.d(TAG, "Getting Suggestion");
        if(criteria.length()>=2){
            destinationPresenter.searchSuggestion(criteria);
        }
    }


    @Override
    public void setSuggestionResult(ArrayList<String> data) {
        Log.d(TAG, "Initializing and Setting suggestion in the searchAdapter.");
        searchAdapter.setData(data);
        searchView.setSuggestionsAdapter(searchAdapter);
    }


    //This function starts the search activity.

    public void validateDestination(String destination){
        //hiding keyboard first.
        hideKeyboard();

            // Intent searchActivity = new Intent(getContext(), SearchActivity.class);
            //Bundle bundle = new Bundle();
            // searchActivity.putExtra("destination", destination);
            // startActivity(searchActivity);
            showProgressBar("Analysing your location...");
            //first checking if internet connection is available or not.
            Log.d(TAG, "Checking for network connection.");
            if (new NetworkConnection(getContext()).isNetworkConnected() == true) {
                Log.d(TAG, "Network connection available. Now, checking for GPS.");
                if (locationManagerLocationProvider.canGetLocation() == true) {
                    Log.d(TAG, "GPS is available. Now validating destination.");

                    this.destination = destination;
                    if (destination.equals("") || destination.equals(null)) {
                        hideProgressBar();
                        Toast.makeText(getContext(), "Please, enter a destination", Toast.LENGTH_LONG).show();
                    } else {
                        destinationPresenter.validate(destination);
                    }
                } else {
                    hideProgressBar();
                    Log.d(TAG, "GPS is not available. Now displaying GPS enable option.");
                    locationManagerLocationProvider.displayGpsSettingAlert();
                }
            } else {
                hideProgressBar();
                Toast.makeText(getContext(), "Not connected to Internet", Toast.LENGTH_LONG).show();
            }

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
                    Toast.makeText(getContext(), "Unable to identify user current location.", Toast.LENGTH_LONG).show();
                } else {

                    hideProgressBar();
                    Double longitude = location.getLongitude();
                    Double latitude = location.getLatitude();

                    Log.d(TAG, "Now, searching the vehicle. User location: lng: " + longitude + ", lat: " + latitude);
                    Intent searchActivity = new Intent(getContext(), SearchActivity.class);
                    Bundle bundle = new Bundle();
                    searchActivity.putExtra("destination", destination);
                    searchActivity.putExtra("longitude", longitude);
                    searchActivity.putExtra("latitude", latitude);
                    startActivity(searchActivity);
                }
            }
        }, 2000);
    }


    //This method first gets the list of available route list and display vehicle search dialog message.
    public void requestRouteListForSearch(){
        Log.d(TAG, "Requesting route list for vehicle search.");
        searchPresnter.getRouteNames();
    }
    //This method first gets the list of available busstop list and display vehicle search dialog message.
    public void requestBusstopListForSearch(){
        Log.d(TAG, "Requesting busstop list for vehicle search.");
    }

    @Override
    public void displayRouteSearchOption(ArrayList<String> routes) {
        Log.d(TAG, "Displaying busstop list for vehicle search.");
        displayOptionSearch(routes, "route");
    }

    @Override
    public void displayBusStopSearchOption(ArrayList<String> stops) {
        Log.d(TAG, "Displaying route list for vehicle search.");
        displayOptionSearch(stops, "stop");
    }


    //DIsplay the option search, Parameters : data - list value, type : type of the option (Nearest route or nearest bus stop)
    private void displayOptionSearch(ArrayList<String> data, final String type) {
        Log.d(TAG, "Displaying option search view and the type is " + type);
        AlertDialog.Builder dialogAlert = new AlertDialog.Builder(getContext());
        //getting the custom find layout for the login.
        if (type.equals("route")) {
            data.add(0, "--Select a Route--");
        } else {
            data.add(0, "--Select a Stop--");
        }

        View searchOption = View.inflate(getContext(), R.layout.option_search_dialog, null);
        final Spinner option_search = (Spinner) searchOption.findViewById(R.id.option_search_spinner);

        //SettingActivity data in drop down
        Log.d(TAG, "Setting the data in the option dropdown.");
        ArrayAdapter<String> adapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_spinner_item, data);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        option_search.setAdapter(adapter);

        dialogAlert.setView(searchOption);
        dialogAlert.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //will exit main activity
            }
        });
        dialogAlert.setPositiveButton("SEARCH", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Log.d(TAG, "Find button is clicked. Search option type is: " + type);
                if (type.equals("route")) {
                    //search vehicle for route
                    String routeName = option_search.getSelectedItem().toString();
                    //searchPresnter.findVehicleForRoute(routeName);
                    Log.d(TAG, "Now, searching the vehicle. User location for route : "+ routeName);
                    Intent searchActivity = new Intent(getContext(), SearchActivity.class);
                    searchActivity.putExtra("route", routeName);
                    startActivity(searchActivity);
                } else {
                    //search vehilcle for busstops.
                    String stopName = option_search.getSelectedItem().toString();
                    //searchPresnter.findVehicleForBusStop(stopName);
                    Log.d(TAG, "Now, searching the vehicle. User location near stop : "+ stopName);
                    Intent searchActivity = new Intent(getContext(), SearchActivity.class);
                    searchActivity.putExtra("stop", stopName);
                    startActivity(searchActivity);
                }
            }
        });
        dialogAlert.create();
        Log.d(TAG, "Now showing the search dialog");
        dialogAlert.show();
    }


    @Override
    public void displaySearchViewLoadingIndicator() {
        searchViewIndicator.setVisibility(View.VISIBLE);
    }

    @Override
    public void hideSearchViewLoadingIndicator() {
        searchViewIndicator.setVisibility(View.INVISIBLE);
    }

    /*
    //this function return route/busstop custom search option pop up box.
    private AlertDialog.Builder getOptionSearchDialog(ArrayList<String> data) {
        AlertDialog.Builder dialogAlert = new AlertDialog.Builder(getContext());
        //getting the custom find layout for the login.
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.option_search_dialog, null);

        Spinner dropdown = (Spinner) view.findViewById(R.id.vehiclelist);

        //SettingActivity vehicle data in drop down
        ArrayAdapter<String> searchAdapter = new ArrayAdapter<>(getContext(), android.R.layout.simple_spinner_item, data);
        searchAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        dropdown.setAdapter(searchAdapter);

        dialogAlert.setView(view);
        dialogAlert.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //will exit main activity
            }
        });
        return dialogAlert;
    }
    */
    @Override
    public void displayAlertMessage(String alertMessage) {
        Log.d(TAG, "Displaying alert message: " + alertMessage);
        //status message dialog box
        AlertDialog.Builder statusMessageDialog = new AlertDialog.Builder(getContext());
        statusMessageDialog.setMessage(alertMessage);
        statusMessageDialog.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        statusMessageDialog.show();
    }

    //This message shows progress bar
    @Override
    public void showProgressBar(String loadingMessage) {
        //Loading progressbar instantiation
        Log.d(TAG, "Displaying the progress bar.");
        progressBar = new ProgressDialog(getContext());
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

        progressBar.dismiss();
    }


    //This function gets the location of the user.
    @Deprecated
    public Location getUserLocation(){
        Log.d(TAG,"Getting user location");
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                location = locationManagerLocationProvider.getLocation();
                if (location == null) {
                    Log.d(TAG, "Location is null, retrieving again.");
                    getUserLocation();
                } else {

                }
            }
        }, 500);
        return location;
    }

    public void hideKeyboard() {
        InputMethodManager inputMethodManager = (InputMethodManager)  this.getActivity().getSystemService(Activity.INPUT_METHOD_SERVICE);
        inputMethodManager.hideSoftInputFromWindow(this.getActivity().getCurrentFocus().getWindowToken(), 0);
    }
}
