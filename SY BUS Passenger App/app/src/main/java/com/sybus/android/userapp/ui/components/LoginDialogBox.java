package com.sybus.android.userapp.ui.components;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.sybus.android.userapp.R;

/**
 * Created by Ranjit Kaliraj on 9/2/2015.
 * Usage eg: First create the AlertDialog.Builder return method and call the buildDialog method by passing it on its parameter.
 */
public class LoginDialogBox {
    private Context context;
    //variable used in LoginView Dialog
    private AlertDialog.Builder loginDialogAlert = null;
    private Dialog loginDialog = null;

    public EditText username;
    public EditText password;
    public TextView statusMessge;

    public LoginDialogBox(Context context) {
        this.context = context;
        username = null;
        password = null;
        statusMessge = null;
    }

    //This function create a popup LoginView layout dialog. note that we must add the actionlistener
    // in this button from this instance returned. the negative button need to be implemented here.
    public AlertDialog.Builder getLoginDialog() {
        //this is the dialog LoginView part
        loginDialogAlert = new AlertDialog.Builder(context);
        //getting the custom LoginView layout for the LoginView.
        View view = View.inflate(context, R.layout.view_login_dialog, null);
        username = (EditText) view.findViewById(R.id.login_username);
        password = (EditText) view.findViewById(R.id.login_password);
        statusMessge = (TextView) view.findViewById(R.id.login_error_message);

        loginDialogAlert.setView(view);
        loginDialogAlert.setPositiveButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //will exit main activity
            }
        });
        return loginDialogAlert;
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

    //This function create a popup LoginView layout dialog
    //must implement the .start() and .dismiss() after instantiating this method.
    public static AlertDialog.Builder getAlertDialog(Context context, String alertMessage) {
        Dialog dialog = null;
        AlertDialog.Builder informationDialogAlert = new AlertDialog.Builder(context);

        //getting the custom LoginView layout for the LoginView.
        final View view = View.inflate(context, R.layout.view_alert_dialog, null);

        //final TextView text = (TextView) view.findViewById(R.id.alert_dialog_message);
        informationDialogAlert.setMessage(alertMessage);
        informationDialogAlert.setView(view);
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
}
