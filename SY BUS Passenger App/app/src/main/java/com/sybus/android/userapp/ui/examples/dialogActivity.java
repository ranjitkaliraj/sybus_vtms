package com.sybus.android.userapp.ui.examples;

import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

//dialog box
import android.app.Dialog;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.ui.MapActivity;
import com.sybus.android.userapp.ui.components.LoginDialogBox;

public class dialogActivity extends AppCompatActivity {
    private AlertDialog.Builder loginDialogAlert = null; // Exit App dialog box
    private Dialog loginDialog = null;
    private Button button;

    private ProgressBar bar1;
    private ProgressBar bar2;
    private Button button2;
    private int i = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dialog);

        bar1 = (ProgressBar) findViewById(R.id.progressBar);
        bar2 = (ProgressBar) findViewById(R.id.progressBar2);
        button2 = (Button) findViewById(R.id.button2);

        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
               startActivity(new Intent(getApplicationContext(), MapActivity.class));
            }
        });

        //this is the dialog LoginView part
        loginDialogAlert = new AlertDialog.Builder(this);
        //getting the custom LoginView layout for the LoginView.
        View view = View.inflate(this,R.layout.view_login_dialog,null);
        loginDialogAlert.setView(view);
        loginDialogAlert.setPositiveButton("CANCEL", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                //finish();       //TO be or not to be that s
            }
        });
        loginDialogAlert.setNegativeButton("LOGIN", new DialogInterface.OnClickListener() {
            public void onClick(final DialogInterface dialog, int which) {
                Toast.makeText(getApplicationContext(), "clicked sign in...", Toast.LENGTH_LONG).show();
                //dialog.dismiss();
                final ProgressDialog p = LoginDialogBox.getProgressDialog(dialogActivity.this, "Loading... signing in...");
                p.show();
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        p.dismiss();
                        loginDialog.show();
                    }
                }, 5000);


                /*
                ProgressDialog pd = new ProgressDialog(dialogActivity.this);
                pd.setProgressStyle(ProgressDialog.STYLE_SPINNER);
                pd.setMessage("loading..");
                pd.setIndeterminate(true);
                pd.setCanceledOnTouchOutside(false);
                pd.show();*/

                //finish();       //will exit main activity
            }
        });
        loginDialog = loginDialogAlert.create();

        button  = (Button) findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginDialog.show();
            }
        });


    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_dialog, menu);
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
