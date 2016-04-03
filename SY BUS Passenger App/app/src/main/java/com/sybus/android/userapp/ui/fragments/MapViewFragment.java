package com.sybus.android.userapp.ui.fragments;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Path;
import android.os.AsyncTask;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;

import android.os.Environment;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.graphhopper.PathWrapper;
import com.sybus.android.userapp.pojo.LngLat;
import com.sybus.android.userapp.ui.MainActivity;
import com.sybus.android.userapp.util.GHAsyncTask;


import com.graphhopper.GHRequest;
import com.graphhopper.GHResponse;
import com.graphhopper.GraphHopper;
import com.graphhopper.routing.AlgorithmOptions;
import com.graphhopper.util.PointList;
import com.graphhopper.util.StopWatch;
import com.graphhopper.util.shapes.GHPoint;

import org.mapsforge.core.graphics.Bitmap;
import org.mapsforge.core.graphics.Paint;
import org.mapsforge.core.graphics.Style;
import org.mapsforge.core.model.LatLong;
import org.mapsforge.core.model.MapPosition;
import org.mapsforge.core.model.Point;
import org.mapsforge.map.android.graphics.AndroidGraphicFactory;
import org.mapsforge.map.android.util.AndroidUtil;
import org.mapsforge.map.android.view.MapView;
import org.mapsforge.map.datastore.MapDataStore;
import org.mapsforge.map.layer.Layers;
import org.mapsforge.map.layer.cache.TileCache;
import org.mapsforge.map.layer.overlay.Marker;
import org.mapsforge.map.layer.overlay.Polyline;
import org.mapsforge.map.layer.renderer.TileRendererLayer;
import org.mapsforge.map.reader.MapFile;
import org.mapsforge.map.rendertheme.InternalRenderTheme;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link MapViewFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link MapViewFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class MapViewFragment extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;


    public String TAG = this.getClass().getName();

    private MainActivity mainActivityInstance;

    private TileRendererLayer tileRendererLayer;
    private TileCache tileCache;
    private MapView mapView;
    private GraphHopper hopper;

    //graphhopper map initialization status
    private volatile boolean prepareInProgress = false;
    private volatile boolean shortestPathRunning = false;

    private File mapDirectory;
    private String MAP_FILE_NAME = "kathmandu_nepal.map";

    private double shortestDistanceLength;

    private OnFragmentInteractionListener mListener;

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment MapViewFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static MapViewFragment newInstance(String param1, String param2) {
        MapViewFragment fragment = new MapViewFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    public MapViewFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }

        //Instantiating Map
        Log.d(TAG, "Instantiating mapview.");
        AndroidGraphicFactory.createInstance(getActivity().getApplication());

        mapView = new MapView(getActivity().getApplicationContext());
        mapView.setClickable(true);
        mapView.setBuiltInZoomControls(true);

        tileCache = AndroidUtil.createTileCache(getActivity().getApplicationContext(), getClass().getSimpleName(), mapView.getModel().displayModel.getTileSize(),
                1f, mapView.getModel().frameBufferModel.getOverdrawFactor());

        //loading map file directory
        loadMapFileDirectory();

        //initializing prepare in progress to true first.
        prepareInProgress = true;
        loadMap(mapDirectory);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        //return inflater.inflate(R.layout.fragment_map_view, container, false);
        return mapView;
    }

    //This function loads map from the storage
    private void loadMapFileDirectory() {
        //Loading offline map data.
        if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
            Log.d(TAG, "Cannot read the storage at the moment. Please, try again later.");
            //displayAlertMessage("Cannot read media storage.");
            return;
        }
        try {
            mapDirectory = new File(Environment.getExternalStorageDirectory(), "/sybus_data/map");
        } catch (Exception e) {
            //displayAlertMessage("Cannot read the map data.");

        }
    }


    public void loadMap(File fileURL) {
        Log.d(TAG, "Loading map..." + fileURL);
        MapDataStore mapDataStore = new MapFile(new File(fileURL, MAP_FILE_NAME));
        //MapDataStore mapDataStore = null;

        mapView.getLayerManager().getLayers().clear();

        tileRendererLayer = new TileRendererLayer(tileCache, mapDataStore, mapView.getModel().mapViewPosition, false, true, AndroidGraphicFactory.INSTANCE) {
            @Override
            public boolean onLongPress(LatLong tapLatLong, Point layerXY, Point tapXY) {
                //return onMapTap(tapLatLong, layerXY, tapXY);
                return false;
            }
        };
        tileRendererLayer.setTextScale(1.5f);
        tileRendererLayer.setXmlRenderTheme(InternalRenderTheme.OSMARENDER);
        mapView.getModel().mapViewPosition.setMapPosition(new MapPosition(mapDataStore.boundingBox().getCenterPoint(), (byte) 15));
        mapView.getLayerManager().getLayers().add(tileRendererLayer);
        //setContentView(mapView);
        loadGraphStorage();
    }

    void loadGraphStorage() {
        new GHAsyncTask<Void, Void, Path>() {
            protected Path saveDoInBackground(Void... v) throws Exception {
                GraphHopper tmpHopp = new GraphHopper().forMobile();
                //tmpHopp.load(mapRootDirectory);
                Log.d(TAG, "Apple" + mapDirectory.getAbsolutePath().toString());
                tmpHopp.load(mapDirectory.getAbsolutePath());
                //Log.d(TAG, "found graph " + tmpHopp.getGraphHopperStorage().toString() + ", nodes:" + tmpHopp.getGraphHopperStorage().getNodes());
                hopper = tmpHopp;
                return null;
            }

            protected void onPostExecute(Path o) {
                if (hasError()) {
                    Log.d(TAG, "An error occured while displaying Map:" + mapDirectory.getAbsolutePath().toString());
                    Log.d(TAG, "An error happend while creating graph:"
                            + getErrorMessage());
                } else {
                    Log.d(TAG, "Map loaded successfully.");
                }

                finishPrepare();
            }
        }.execute();
    }

    private void finishPrepare() {
        prepareInProgress = false;
    }


    private Polyline createPolyline( PathWrapper response )
    {
        Paint paintStroke = AndroidGraphicFactory.INSTANCE.createPaint();
        paintStroke.setStyle(Style.STROKE);
        paintStroke.setColor(Color.argb(128, 0, 0xCC, 0x33));
        paintStroke.setDashPathEffect(new float[]
                {
                        25, 15
                });
        paintStroke.setStrokeWidth(14);

        Polyline line = new Polyline((org.mapsforge.core.graphics.Paint) paintStroke, AndroidGraphicFactory.INSTANCE);
        List<LatLong> geoPoints = line.getLatLongs();
        PointList tmp = response.getPoints();
        for (int i = 0; i < response.getPoints().getSize(); i++)
        {
            geoPoints.add(new LatLong(tmp.getLatitude(i), tmp.getLongitude(i)));
        }

        return line;
    }

    private Marker createMarker(LatLong p, int resource) {
        Drawable drawable = getResources().getDrawable(resource);
        Bitmap bitmap = AndroidGraphicFactory.convertToBitmap(drawable);
        return new Marker(p, bitmap, 0, -bitmap.getHeight() / 2);
    }


    //This function center position the map to given location
    public void setMapPosition(double lat, double lng, int zoom) {
        Layers layers = mapView.getLayerManager().getLayers();
        LatLong latlng = new LatLong(lat, lng);
        MapPosition m = new MapPosition(new LatLong(lat, lng, true), (byte) zoom);
        mapView.getModel().mapViewPosition.setMapPosition(m);
    }

    //This function Set marker in the mapview
    public Layers setMarkerOnMap(double lat, double lng, int icon) {
        Log.d(TAG, "SettingActivity marker on map.");
        Layers layers = mapView.getLayerManager().getLayers();
        LatLong latlng = new LatLong(lat, lng);
        Marker marker = createMarker(latlng, icon);
        if (marker != null) {
            layers.add(1,marker);
        }
        //returning layers so that this marker can also be removes.
        return layers;
    }

   /* //This function set line on the map.
    public void setLineOnMapOld(ArrayList<LngLat> way) {
        Layers layers = mapView.getLayerManager().getLayers();
        List points = new ArrayList<GHPoint>();
        for (LngLat lnglat : way) {
            GHPoint point = new GHPoint(lnglat.getLatitude(), lnglat.getLongitude());
            points.add((GHPoint) point);
        }
        GHRequest req = new GHRequest(points);
        GHResponse resp = hopper.route(req);
        Polyline line = createPolyline(resp);
        layers.add(line);
    }
    */

    public void setLineOnMap(ArrayList<LngLat> way){
        Layers layers = mapView.getLayerManager().getLayers();
        ArrayList<GHPoint> points = new ArrayList<>();
        for (LngLat lnglat : way) {
            GHPoint point = new GHPoint(lnglat.getLatitude(), lnglat.getLongitude());
            points.add(point);
        }

        Paint paintStroke = AndroidGraphicFactory.INSTANCE.createPaint();
        paintStroke.setStyle(Style.STROKE);
        paintStroke.setColor(Color.argb(128, 0, 0, 255));
        paintStroke.setDashPathEffect(new float[]
                {
                        25, 15
                });
        paintStroke.setStrokeWidth(14);

        Polyline line = new Polyline((org.mapsforge.core.graphics.Paint) paintStroke, AndroidGraphicFactory.INSTANCE);
        List<LatLong> geoPoints = line.getLatLongs();
        //PointList tmp = response.getPoints();
        for (int i = 0; i < points.size(); i++) {
            geoPoints.add(new LatLong(points.get(i).getLat(), points.get(i).getLon()));
        }
        layers.add(line);
    }

    //This function calculate the shortest path between two points and displays on map
    public void displayShortestDistance(final double fromLat, final double fromLon,
                         final double toLat, final double toLon) {
        Log.d(TAG, "calculating path ...");

        new AsyncTask<Void, Void, PathWrapper>() {
            float time;

            protected PathWrapper doInBackground(Void... v) {
                StopWatch sw = new StopWatch().start();
                GHRequest req = new GHRequest(fromLat, fromLon, toLat, toLon).
                        setAlgorithm(AlgorithmOptions.DIJKSTRA_BI);
                req.getHints().
                        put("instructions", "false");
                GHResponse resp = hopper.route(req);
                time = sw.stop().getSeconds();
                return resp.getBest();
            }

            protected void onPostExecute(PathWrapper resp) {
                if (!resp.hasErrors()) {
                    Log.d(TAG, "from:" + fromLat + "," + fromLon + " to:" + toLat + ","
                            + toLon + " found path with distance:" + resp.getDistance()
                            / 1000f + ", nodes:" + resp.getPoints().getSize() + ", time:"
                            + time + " " + resp.getDebugInfo());
                    Log.d(TAG, "the route is " + (int) (resp.getDistance() / 100) / 10f
                            + "km long, time:" + resp.getTime() / 60000f + "min, debug:" + time);

                    mapView.getLayerManager().getLayers().add(createPolyline(resp));

                    //distance and time calculation.
                    //SettingActivity distance
                    setShortestDistanceLength((resp.getDistance()));

                } else {
                    Log.d(TAG, "Error:" + resp.getErrors());
                }
                shortestPathRunning = false;
            }
        }.execute();
    }


    //checking if the map is ready or not.
    public boolean isMapReady() {
        // only return true if already loaded
        if (hopper != null)
            return true;

        if (prepareInProgress) {
            Log.d(TAG, "Preparation still in progress");
            return false;
        }
        Log.d(TAG, "Prepare finished but hopper not ready. This happens when there was an error while loading the files");
        return false;
    }


    private void setShortestDistanceLength(double distance){
        shortestDistanceLength = distance;
    }

    public double getShortestDistanceLength(){
        return shortestDistanceLength;
    }

    //This function destroys the mapview object.
    public void destroyMapObject(){
        if (hopper != null)
            hopper.close();

        hopper = null;
        System.gc();

        this.mapView.destroyAll();
    }

    //##############################################################################################


    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (OnFragmentInteractionListener) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        public void onFragmentInteraction(Uri uri);
    }
}
