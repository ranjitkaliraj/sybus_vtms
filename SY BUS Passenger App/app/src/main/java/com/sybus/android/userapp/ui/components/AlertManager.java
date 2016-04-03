package com.sybus.android.userapp.ui.components;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;

import com.sybus.android.userapp.R;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 * Usage eg: First create the AlertDialog.Builder return method and call the buildDialog method by passing it on its parameter.
 */
public class AlertManager {
    private Context context;
    //variable used in login Dialog
    private AlertDialog.Builder dialogAlert;

    public ArrayList<String> vehicleList;
    public ArrayList<String> routeList;

    private Spinner vehicleDropdown;
    private Spinner routeDropdown;

    public EditText urlText;

    public AlertManager(Context context, ArrayList<String> vehicles, ArrayList<String> routes) {
        this.context = context;
        vehicleList = vehicles;
        routeList = routes;
    }

    //constructor for find URL alert
    public AlertManager(Context context){
        this.context = context;
    }

    //This function create a popup find schedule layout dialog. note that we must add the actionlistener
    // in this button from this instance returned. the negative button need to be implemented here.
    public AlertDialog.Builder displayScheduleFindAlertDialog() {
        dialogAlert = new AlertDialog.Builder(context);
        //getting the custom find layout for the login.
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.find_schedule_dialog, null);

        //View view = View.inflate(context, R.layout.find_schedule_dialog, null);
        vehicleDropdown = (Spinner) view.findViewById(R.id.vehiclelist);
        routeDropdown = (Spinner) view.findViewById(R.id.routelist);

        //SettingActivity vehicle data in drop down
        ArrayAdapter<String> adapter1 = new ArrayAdapter<>(context, android.R.layout.simple_spinner_item, vehicleList);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        vehicleDropdown.setAdapter(adapter1);

        //SettingActivity route data in drop down.
        ArrayAdapter<String> adapter2 = new ArrayAdapter<>(context, android.R.layout.simple_spinner_item, routeList);
        adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        routeDropdown.setAdapter(adapter2);

        dialogAlert.setView(view);
        dialogAlert.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //will exit main activity
            }
        });
        return dialogAlert;
    }


    //This function creates the progress bar dialog in the screen
    //we must implement show() or dismiss method on the return instance of ProgressDialog.
    public static ProgressDialog getProgressDialog(Context context, String loadingMessage) {
        ProgressDialog pd = new ProgressDialog(context);
        pd.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        pd.setMessage(loadingMessage);
        pd.setIndeterminate(true);
        pd.setCanceledOnTouchOutside(false);
        return pd;
    }

    //This function create a popup login layout dialog
    //must implement the .start() and .dismiss() after instantiating this method.
    public static AlertDialog.Builder getAlertDialog(Context context, String alertMessage) {
        Dialog dialog = null;
        AlertDialog.Builder informationDialogAlert = new AlertDialog.Builder(context);

        //getting the custom login layout for the login.
        //final View view = View.inflate(context, R.layout.find_schedule_dialog, null);

        //final TextView text = (TextView) view.findViewById(R.id.alert_dialog_message);
        informationDialogAlert.setMessage(alertMessage);
        //informationDialogAlert.setView(view);
        informationDialogAlert.setNeutralButton("DISMISS", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //will exit main activity
            }
        });
        return informationDialogAlert;
    }


    //this function creates the dialog created dialog alert builder instance.
    public static Dialog buildDialog(AlertDialog.Builder dialogAlert ){
        Dialog dialog = null;
        dialog = dialogAlert.create();
        return dialog;
    }


    public Spinner getRouteDropdown() {
        return routeDropdown;
    }

    public void setRouteDropdown(Spinner routeDropdown) {
        this.routeDropdown = routeDropdown;
    }

    public Spinner getVehicleDropdown() {
        return vehicleDropdown;
    }

    public void setVehicleDropdown(Spinner vehicleDropdown) {
        this.vehicleDropdown = vehicleDropdown;
    }


    //This function create and display  URL save alert Box.
    public AlertDialog.Builder displayUrlSaveAlert() {
        dialogAlert = new AlertDialog.Builder(context);
        //getting the custom find layout for the login.
        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.save_url_dialog, null);

        urlText = (EditText) view.findViewById(R.id.url_text);

        dialogAlert.setView(view);
        dialogAlert.setNegativeButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        return dialogAlert;
    }


}
