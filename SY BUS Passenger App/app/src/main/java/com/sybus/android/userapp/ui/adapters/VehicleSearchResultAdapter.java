package com.sybus.android.userapp.ui.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sybus.android.userapp.R;
import com.sybus.android.userapp.pojo.SearchVehicleDto;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/5/2016.
 */
public class VehicleSearchResultAdapter  extends RecyclerView.Adapter<VehicleSearchResultAdapter.MyViewHolder> {
    public String TAG = this.getClass().getName();

    private LayoutInflater inflator;
    private Context context;
    private ArrayList<SearchVehicleDto> results;
    private TouchListener touchListener;

    public VehicleSearchResultAdapter(Context context, ArrayList<SearchVehicleDto> results) {
        Log.d(TAG, "Initializing constructor of adapter.");
        //this.context = context;
        inflator = LayoutInflater.from(context);
        this.results = results;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = inflator.inflate(R.layout.view_vehicle_search_result, viewGroup, false);
        Log.d(TAG, "Initializing view holder for list view of vehicle result..");
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(MyViewHolder viewHolder, int i) {
        Log.d(TAG, "Setting data on Viewholder.");
        SearchVehicleDto dto = results.get(i);
        Log.d(TAG, "View holder bind: "+i);
        viewHolder.vehicleName.setText(dto.getVehicleName());
        viewHolder.currentLocation.setText(dto.getCurrentLocation());
        viewHolder.routeName.setText(dto.getRouteName());
        viewHolder.nextStop.setText(dto.getNextStop());
        viewHolder.userStop.setText(dto.getUserNearStop());
        viewHolder.eta.setText(dto.getETA());
    }

    @Override
    public int getItemCount() {
        Log.d(TAG, "Counting and returning the items.");
        int count = results.size();
        return count;
    }

    public void setTouchListener(TouchListener listener){
        touchListener = listener;
    }


    //this is a new class that will be passed in the extend parameter of RecyclerView.Adaptor
    class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        TextView vehicleName;
        TextView currentLocation;
        TextView routeName;
        TextView nextStop;
        TextView userStop;
        TextView eta;

        public MyViewHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(this);
            vehicleName = (TextView) itemView.findViewById(R.id.vehicle_name);
            currentLocation = (TextView) itemView.findViewById(R.id.current_road);
            routeName = (TextView) itemView.findViewById(R.id.route_name);
            nextStop = (TextView) itemView.findViewById(R.id.next_stop);
            userStop = (TextView) itemView.findViewById(R.id.user_near_stop);
            eta = (TextView) itemView.findViewById(R.id.ETA);
        }

        @Override
        public void onClick(View v) {
            Log.d(TAG, "Activating the onclick listener");
            if (touchListener!=null){
                //passing the current position of the touched item in the navigation
                //the title is passed in order identify between LoginView and create account option since
                //both have same id but different name and they must envoke different function.
                touchListener.menuItemClicked(getLayoutPosition(),results.get(getLayoutPosition()).getVehicleID());

            }
        }
    }

    public interface TouchListener{
        public void menuItemClicked(int position, long vehicleID);
    }
}

