package com.sybus.android.userapp.util;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.res.AssetManager;
import android.os.AsyncTask;
import android.os.Environment;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/1/2016.
 */
public class MapFilesManager {
    private Context context;
    private File edges;
    private File geometry;
    private File kathmandu_nepal;
    private File location_index;
    private File names;
    private File nodes;
    private File nodes_ch_fastest_car;
    private File properties;
    private File shortcuts_fastest_car;

    private File mapFileDirectory;


    public MapFilesManager(Context context) {
        this.context = context;
        edges = new File("/edges");
        geometry = new File("/geometry");
        kathmandu_nepal = new File("/kathmandu_nepal.map");
        location_index = new File("/location_index");
        names = new File("/names");
        nodes = new File("/nodes");
        nodes_ch_fastest_car = new File("/nodes_ch_fastest_car");
        properties = new File("/properties");
        shortcuts_fastest_car = new File("/shortcuts_fastest_car");

        mapFileDirectory = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/sybus_data/map");
    }

    //here no exception is handled for checking existence of file, so map file must present in the directory.
    public void copyMapFiles() {
        ArrayList<String> files = new ArrayList<String>();
        files.add("edges");
        files.add("geometry");
        files.add("kathmandu_nepal.map");
        files.add("location_index");
        files.add("names");
        files.add("nodes");
        files.add("nodes_ch_fastest_car");
        files.add("properties");
        files.add("shortcuts_fastest_car");

        new myAsyncTask().execute(files);
    }


    // AsyncTass for the Progress Dialog and to do Background Process
    private class myAsyncTask extends AsyncTask<ArrayList<String>, Void, Void> {
        ArrayList<String> files;
        ProgressDialog dialog;

        @Override
        protected void onPreExecute() {
            dialog = ProgressDialog.show(context, "MAP FILES", "Initializing...");
        }

        @Override
        protected Void doInBackground(ArrayList<String>... params) {
            files = params[0];
            for (int i = 0; i < files.size(); i++) {
                copyFileFromAssetsToSDCard(files.get(i));
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            dialog.dismiss();
        }
    }


    // Function to copy file from Assets to the SDCard
    public void copyFileFromAssetsToSDCard(String fileFromAssets) {
        AssetManager assetManager = context.getAssets();
        InputStream fis;
        try {
            fis = assetManager.open("map_data/" + fileFromAssets);
            FileOutputStream fos;

            //checking if directory is present or not
            if (!mapFileDirectory.exists()) {
                mapFileDirectory.mkdirs();
            }

            //checking file is already present or not.
            if (new File(mapFileDirectory.getAbsolutePath() + "/" + fileFromAssets).exists()) {
                Log.d("MapDataManager", "Map file already exist");
            } else {
                //output stream/folder to paste file
                Log.d("MapDataManager", "Copying map file: "+fileFromAssets);
                fos = new FileOutputStream(new File(mapFileDirectory, fileFromAssets));
                byte[] b = new byte[8];
                int i;
                while ((i = fis.read(b)) != -1) {
                    fos.write(b, 0, i);
                }
                fos.flush();
                fos.close();
                fis.close();
            }

        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }
}
