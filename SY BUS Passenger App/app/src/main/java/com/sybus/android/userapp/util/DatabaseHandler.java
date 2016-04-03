package com.sybus.android.userapp.util;

import android.content.ContentValues;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.XmlResourceParser;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import com.sybus.android.userapp.R;

import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;

/**
 * Created by Ranjit Kaliraj on 12/27/2015.
 */
public class DatabaseHandler extends SQLiteOpenHelper {
    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "destinations.db";
    private static final String TABLE_NAME = "destinations";
    private static final String COLUMN_ID = "osm_id";
    private static final String COLUMN_NAME = "destination_name";

    private final String TAG = this.getClass().getName();

    private Context context;

    public DatabaseHandler(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, factory, version);
        this.context = context;
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE destinations ("
                + "osm_id INTEGER PRIMARY KEY,"
                + "destination_name TEXT"
                + ");");

        //Add default records to animals
        ContentValues values = new ContentValues();
        //Get xml resource file
        Resources res = context.getResources();

        //Open xml file
        XmlResourceParser xml = res.getXml(R.xml.destination);
        try {
            //Check for end of document
            int eventType = xml.getEventType();
            while (eventType != XmlPullParser.END_DOCUMENT) {
                //Search for record tags
                if ((eventType == XmlPullParser.START_TAG) && (xml.getName().equals("destination"))) {
                    //Record tag found, now get values and insert record
                    String name = xml.getAttributeValue(null, "name");
                    String osm_id = xml.getAttributeValue(null, "osm_id");
                    values.put(COLUMN_NAME, name);
                    values.put(COLUMN_ID, osm_id);
                    db.insert(TABLE_NAME, null, values);
                }
                eventType = xml.next();
            }
        }
        //Catch errors
        catch (XmlPullParserException e) {
            Log.e(TAG, e.getMessage(), e);
        } catch (IOException e) {
            Log.e(TAG, e.getMessage(), e);
        } finally {  //Close the xml file
            xml.close();
        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS "+TABLE_NAME);
        onCreate(db);
    }
}
