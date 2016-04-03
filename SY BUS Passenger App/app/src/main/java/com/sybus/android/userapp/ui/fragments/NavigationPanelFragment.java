package com.sybus.android.userapp.ui.fragments;


import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.app.Fragment;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;


import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.ui.AboutActivity;
import com.sybus.android.userapp.ui.MainActivity;
import com.sybus.android.userapp.ui.SettingActivity;
import com.sybus.android.userapp.ui.UserLocationActivity;
import com.sybus.android.userapp.ui.adapters.NavigationPanelAdapter;
import com.sybus.android.userapp.ui.submit_query;
import com.sybus.android.userapp.ui.ViewRouteActivity;
import com.sybus.android.userapp.ui.view_traffic;
import com.sybus.android.userapp.util.UserDataCacheManager;
import com.sybus.android.userapp.util.SharePreferenceManager;


/**
 * A simple {@link Fragment} subclass.
 */
public class NavigationPanelFragment extends android.support.v4.app.Fragment implements NavigationPanelAdapter.TouchListener {

    private final String TAG = this.getClass().getSimpleName();

    public static final String NAVIGATION_DRAWER_STATE_FILE = "drawer_state_pref";

    private ActionBarDrawerToggle mDrawerToggle;
    private DrawerLayout mDrawerLayout;
    private boolean mUserDrawerState;   //store if user is aware of drawer existence or not
    private boolean mSavedDrawerState;  //store if the drawer is opening for the first time or it is resuming from the rotation of screen
    private View containerView;

    private RecyclerView recycleView;
    private NavigationPanelAdapter adaptor;
    private MainActivity mainActivityInterface;

    private ImageView nav_background;

    private View view;

    //this variable will be used to store the parent context and used in this fragment
    //for for creating toast while user select menu items. Reason: in fragment toast can not be created without activity view.
    private Context context;

    public NavigationPanelFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //getting parent context since toast will be run on the parent activity.
        context = getActivity();

        //for tab pager from side panel button

        mUserDrawerState = Boolean.valueOf(SharePreferenceManager.readFromPreference(getActivity(), "USER_DRAWER_STATE", "false", NAVIGATION_DRAWER_STATE_FILE));
        //if the activity of this fragment is coming from rotation or not starting for the very first time
        if (savedInstanceState != null) {
            mSavedDrawerState = true;
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        view = inflater.inflate(R.layout.fragment_panel_navigation, container, false);

        //adding image on navigation panel
        nav_background = (ImageView) view.findViewById(R.id.nav_panel_image);
        //ImageCache imgCache = new ImageCache(getResources());
        //imgCache.loadBitmap(R.drawable.background_nav,nav_background);
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(view.getContext()).build();
        ImageLoader.getInstance().init(config);
        ImageLoader imageLoader = ImageLoader.getInstance(); // Get singleton instance
        imageLoader.displayImage("drawable://" + R.drawable.background_nav, nav_background);

        //getting resources : navigation list name and icons
        Log.d(TAG, "Inserting the drawables icons and Strings for navigation panel menu items.");

        setListMenuItems();

        return view;
    }

    public void setListMenuItems() {
        int[] icons = null;
        String[] titles = null;
        //checking if user data is cached on the shared preference. if yes user is logged in else not
        //this will used in order to change the logout or Account sign-up icons.
        if (UserDataCacheManager.getUserDataFromCache(getActivity())[0].equals("")) {
            icons = new int[]{
                    R.drawable.ic_home_black_18dp,
                    R.drawable.ic_directions_bus_black_18dp,
                    R.drawable.ic_directions_black_18dp,
                    R.drawable.ic_local_atm_black_18dp,
                    R.drawable.ic_pin_drop_black_18dp,
                    R.drawable.ic_navigation_black_18dp,
                    R.drawable.ic_traffic_black_18dp,
                    R.drawable.ic_help_black_18dp,
                    R.drawable.ic_info_black_18dp,
                    R.drawable.ic_settings_black_18dp,
                    R.drawable.ic_question_answer_black_18dp,
                    R.drawable.ic_person_add_black_18dp,
                    R.drawable.ic_announcement_black_18dp
            };

            titles = getResources().getStringArray(R.array.navPanelItemsTitlesNologin);
        } else {
            icons = new int[]{
                    R.drawable.ic_home_black_18dp,
                    R.drawable.ic_directions_bus_black_18dp,
                    R.drawable.ic_directions_black_18dp,
                    R.drawable.ic_local_atm_black_18dp,
                    R.drawable.ic_pin_drop_black_18dp,
                    R.drawable.ic_navigation_black_18dp,
                    R.drawable.ic_traffic_black_18dp,
                    R.drawable.ic_help_black_18dp,
                    R.drawable.ic_info_black_18dp,
                    R.drawable.ic_settings_black_18dp,
                    R.drawable.ic_question_answer_black_18dp,
                    R.drawable.ic_person_black_18dp
            };

            titles = getResources().getStringArray(R.array.navPanelItemsTitlesLoggedIn);
        }


        //Creating the list of items/menu options in the Drawer navigation
        recycleView = (RecyclerView) view.findViewById(R.id.drawerItems);
        adaptor = new NavigationPanelAdapter(getActivity(), icons, titles);
        adaptor.setTouchListener(this);
        recycleView.setAdapter(adaptor);
        recycleView.setLayoutManager(new LinearLayoutManager(getActivity()));
    }


    //This function setup the app drawer in the main activity
    public void setupAppDrawer(View fragment, DrawerLayout drawer_layout, Toolbar toolbar) {

        mDrawerLayout = drawer_layout;
        containerView = fragment;
        mDrawerToggle = new ActionBarDrawerToggle(getActivity(), mDrawerLayout, toolbar, R.string.drawer_open, R.string.drawer_close) {
            @Override
            public void onDrawerOpened(View drawerView) {
                super.onDrawerOpened(drawerView);
                if (!mUserDrawerState) {
                    mUserDrawerState = true;
                    SharePreferenceManager.saveToPreference(getActivity(), "USER_DRAWER_STATE", mUserDrawerState + "", NAVIGATION_DRAWER_STATE_FILE);
                }
                getActivity().invalidateOptionsMenu();
            }

            @Override
            public void onDrawerClosed(View drawerView) {
                super.onDrawerClosed(drawerView);
                getActivity().invalidateOptionsMenu();
            }
        };

        //if both user is not aware of existence of drawer and there is no previous saved state then simply create the drawer.
        if (!mUserDrawerState && !mSavedDrawerState) {
            mDrawerLayout.openDrawer(containerView);
        }
        mDrawerLayout.setDrawerListener(mDrawerToggle);

        //Creating the hamburger icon in the appbar/actionbar/toolbar
        mDrawerLayout.post(new Runnable() {
            @Override
            public void run() {
                mDrawerToggle.syncState();
            }
        });
    }


    @Override
    public void menuItemClicked(int position, String title) {
        System.out.println("hello world. position:" + position + " and title: " + title);
        Log.d(TAG, "hello world... executing menuitem clicked function:    " + position + "title:" + title);
        //"Profile", "Search", "Routes", "Settings", "About"
        if (position == 0) {
            Log.d(TAG, "Home button is clicked");
            mainActivityInterface.changeTabsByButton(0);
        } else if (position == 1) {
            Log.d(TAG, "Pinn vehicle button is clicked");
            mainActivityInterface.changeTabsByButton(1);
        } else if (position == 2) {
            Log.d(TAG, "view walking route button clicked.");
            mainActivityInterface.changeTabsByButton(2);
        } else if (position == 3) {
            Log.d(TAG, "Payment page view button clicked.");
            mainActivityInterface.changeTabsByButton(3);
        } else if (position == 4) {
            Log.d(TAG, "user location display on map.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            Intent intent = new Intent(getContext(), UserLocationActivity.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 5) {
            Log.d(TAG, "view route clicked.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            Intent intent = new Intent(getContext(), ViewRouteActivity.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 6) {
            Log.d(TAG, "view traffic clicked.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            Intent intent = new Intent(getContext(), view_traffic.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 7) {
            Log.d(TAG, "Help button clicked.");
            //Toast.makeText(context, "No help available at the moment.", Toast.LENGTH_LONG).show();
            mainActivityInterface.displayAlertMessage("Please visit www.sybus.com for help and support.");
        } else if (position == 8) {
            Log.d(TAG, "About clicked.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            //mainActivityInterface.displayAlertMessage("SY Bus - Passenger app. Version 1.0.");
            Intent intent = new Intent(getContext(), AboutActivity.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 9) {
            Log.d(TAG, "Setting clicked.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            Intent intent = new Intent(getContext(), SettingActivity.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 10) {
            Log.d(TAG, "submit query clicked.");
            //Toast.makeText(context, "You have selected settings item", Toast.LENGTH_LONG).show();
            Intent intent = new Intent(getContext(), submit_query.class);
            //intent.putExtra("vehicleDetail",vehicle);
            startActivity(intent);
        } else if (position == 11 && title.equals("Logout")) {
            Log.d(TAG, "Logut button clicked.");

            /*final ProgressDialog progress = LoginDialogBox.getProgressDialog(getContext(), "Signing out...");
            progress.show();
            //Waiting for 4 seconds till loading animation appear
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    //logginout from the server
                    Authentication.getInstance().logout(getActivity());
                    //resetting the navigation panel to default with no user details shown.
                    mainActivityInterface.reConstructNavigationPanel(false);

                    //recreating the mainclass
                    getActivity().finish();
                    startActivity(new Intent(getActivity(), MainActivity.class));
                    progress.dismiss();
                    Toast.makeText(context, "You have selected Logout item", Toast.LENGTH_LONG).show();
                }
            }, 4000);*/
            mainActivityInterface.logout();
        } else if (position == 11 && !title.equals("Logout")) {
            //Toast.makeText(getActivity(),"You selected to create a new account",Toast.LENGTH_LONG).show();
            //Intent intent = new Intent(getContext(), create_account.class);
            //intent.putExtra("vehicleDetail",vehicle);
            //startActivity(intent);
            mainActivityInterface.displayAccountRegistrationView();
        } else if (position == 12) {
            Log.d(TAG, "reset password is clicked.");
            //displayAlertMessage("This service is currently un-available");
            mainActivityInterface.displayResetPasswordStep1();
        }
        //startActivity(new Intent(getActivity(), ProfileActivity.class));
    }

    public void displayAlertMessage(String alertMessage) {
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

    //close the drawer
    public void closeDrawer() {
        //mDrawerLayout.closeDrawers();
    }

    //open the drawer
    public void openDrawer() {
        //mDrawerLayout.openDrawer(containerView);
    }

    public void setActivityInstance(MainActivity activity) {
        mainActivityInterface = activity;
    }
}
