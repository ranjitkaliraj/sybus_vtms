package com.sybus.android.userapp.ui.fragments;


import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.DetailVehicleDto;
import com.sybus.android.userapp.presenter.TrackPresenter;
import com.sybus.android.userapp.presenterImpl.TrackPresenterImpl;
import com.sybus.android.userapp.ui.MainActivity;
import com.sybus.android.userapp.ui.components.AnimatedGifImageView;
import com.sybus.android.userapp.ui.pinned_map_view;
import com.sybus.android.userapp.util.NetworkConnection;
import com.sybus.android.userapp.view.TrackView;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link PinnedFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class PinnedFragment extends Fragment implements TrackView {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private TrackPresenter trackPresenter;

    public String TAG = this.getClass().getName();

    private TextView vehicleName;
    private TextView currentLocation;
    private TextView routeName;
    private TextView nextStop;
    private TextView userStop;
    private TextView eta;

    private Button viewMap;

    private FrameLayout pinUnavailable;
    private LinearLayout displayLayout;

    private ProgressDialog progressBar;

    private LinearLayout removeBookmark;

    private LinearLayout expiredLogoView;
    private LinearLayout errorStatusMessageView;
    private AnimatedGifImageView radarImageView;
    private TextView statusErrorMessage;


    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment PinnedFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static android.support.v4.app.Fragment newInstance(String param1, String param2) {
        PinnedFragment fragment = new PinnedFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    public PinnedFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        // return inflater.inflate(R.layout.fragment_pinned, container, false);
        View view = inflater.inflate(R.layout.fragment_pinned, container, false);

        radarImageView = (AnimatedGifImageView) view.findViewById(R.id.pin_activity_radar_animation);
        expiredLogoView = (LinearLayout) view.findViewById(R.id.pinned_activity_expired_logo);
        errorStatusMessageView = (LinearLayout) view.findViewById(R.id.pinned_activity_status_message_view);
        statusErrorMessage = (TextView) view.findViewById(R.id.pinned_activity_status_error_message);

        //displaying items
        //radarImageView.setAnimatedGif(R.raw.radar, AnimatedGifImageView.TYPE.FIT_CENTER);
        //radarImageView.setMinimumHeight(96);
        //radarImageView.setMaxWidth(96);
        expiredLogoView.setVisibility(View.GONE);
        errorStatusMessageView.setVisibility(View.INVISIBLE);

        trackPresenter = new TrackPresenterImpl(this);
        trackPresenter.setContext(getContext());

        Log.d(TAG, "Initializing layout");
        vehicleName = (TextView) view.findViewById(R.id.pinned_activity_vehicle_name);
        currentLocation = (TextView) view.findViewById(R.id.pinned_activity_current_road);
        routeName = (TextView) view.findViewById(R.id.pinned_activity_route_name);
        nextStop = (TextView) view.findViewById(R.id.pinned_activity_next_stop);
        userStop = (TextView) view.findViewById(R.id.pinned_activity_nearest_stop);
        eta = (TextView) view.findViewById(R.id.pinned_activity_ETA);

        displayLayout = (LinearLayout) view.findViewById(R.id.pin_main_layout);
        pinUnavailable = (FrameLayout) view.findViewById(R.id.pin_not_available);

        removeBookmark = (LinearLayout) view.findViewById(R.id.pinned_activity_pin_remove);
        removeBookmark.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                removeBookmark();
            }
        });

        viewMap = (Button) view.findViewById(R.id.pinned_activity_detail_map_view);

        viewMap.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "Starting to display map.");
                Intent intent = new Intent(getContext(), pinned_map_view.class);
                startActivity(intent);
            }
        });

        //Initially reseting the dashboard.
        //i.e. displaying not available message.
        resetDashboard();

        setVehicleInformation();

        return view;
    }

    //This function get the vehicle information and set to the page.
    public void setVehicleInformation(){
        //Now, checking if any vehicle is pinned or not if yes then displaying in dashboard.
        try {
            trackPresenter.getCachedVehicle();
            //autoUpdateETAView();
        } catch (NullPointerException e) {
            e.printStackTrace();
            resetDashboard();
        }
    }

    @Override
    public void setVehicleData(DetailVehicleDto vehicle) {
        if (vehicle != null) {
            Log.d(TAG, "Displaying details for :"+vehicle.getVehicle().getVehicleName());
            vehicleName.setText(vehicle.getVehicle().getVehicleName());
            currentLocation.setText(vehicle.getVehicle().getCurrentLocation());
            routeName.setText(vehicle.getVehicle().getRouteName());
            nextStop.setText(vehicle.getVehicle().getNextStop());
            userStop.setText(vehicle.getVehicle().getUserNearStop());
            eta.setText(vehicle.getVehicle().getETA());

            pinUnavailable.setVisibility(View.GONE);
            displayLayout.setVisibility(View.VISIBLE);

            if(vehicle.isVehicleExpired()){
                radarImageView.setVisibility(View.GONE);
                expiredLogoView.setVisibility(View.VISIBLE);
            }
            else{
                radarImageView.setVisibility(View.VISIBLE);
                expiredLogoView.setVisibility(View.GONE);
            }
            if(!(new NetworkConnection(getContext()).isNetworkConnected())){
                errorStatusMessageView.setVisibility(View.VISIBLE);
                statusErrorMessage.setText("Internet is not available.");
            }
            else{
                errorStatusMessageView.setVisibility(View.INVISIBLE);
            }
            MainActivity a = (MainActivity) getActivity();
            if(a.isVehicleSuspended() && (new NetworkConnection(getContext()).isNetworkConnected())){
                errorStatusMessageView.setVisibility(View.VISIBLE);
                statusErrorMessage.setText("Update Failed. Re-trying...");
            }
            else{
                errorStatusMessageView.setVisibility(View.INVISIBLE);
            }

            //Finally re-updating the vehicle information - recursive operation.
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    setVehicleInformation();
                }
            }, 20000);

        }
        else{
            Log.d(TAG, "Displaying not available.");
            resetDashboard();
        }
    }

    //This function remove bookmarked vehicle
    public void removeBookmark(){
        AlertDialog.Builder dialog = new AlertDialog.Builder(getContext());
        dialog.setTitle("REMOVE PIN");
        dialog.setMessage("You are about to stop tracking pinned vehicle. Are you sure want to remove?");
        dialog.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        dialog.setPositiveButton("REMOVE", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                final MainActivity a = (MainActivity) getActivity();
                a.stopVehicleDetailsAutoUpdate();

                showProgressBar("Removing...");
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        hideProgressBar();
                    }
                }, 1500);
            }
        });
        dialog.create();
        dialog.show();
    }

    //This funciton auto update ETA view.
    @Deprecated
    public void autoUpdateETAView(){
        eta.setText(trackPresenter.getCachedETA());
        //retrieving in every 20 seconds.
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                autoUpdateETAView();
            }
        }, 20000);
    }

    @Override
    public void resetDashboard() {
        Log.d(TAG, "Reseting dashboard");
        try {
            displayLayout.setVisibility(View.GONE);
            pinUnavailable.setVisibility(View.VISIBLE);
        }
        catch (Exception e){}
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

    @Override
    public void onResume() {
        super.onResume();
        //Toast.makeText(getContext(), "This is cool", Toast.LENGTH_LONG).show();
        //setVehicleInformation();
    }

    //THis method hides the progressbar
    @Override
    public void hideProgressBar() {
        Log.d(TAG, "Hiding the progress bar");
        progressBar.dismiss();
    }

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
}
