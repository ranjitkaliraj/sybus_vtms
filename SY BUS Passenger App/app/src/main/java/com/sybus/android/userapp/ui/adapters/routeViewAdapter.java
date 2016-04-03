package com.sybus.android.userapp.ui.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sybus.android.userapp.R;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 1/19/2016.
 */
public class routeViewAdapter extends RecyclerView.Adapter<routeViewAdapter.MyViewHolder>  {
    public String TAG = this.getClass().getName();

    private LayoutInflater inflator;
    private Context context;
    private ArrayList<String> results;
    private TouchListener touchListener;

    public routeViewAdapter(Context context, ArrayList<String> results) {
        Log.d(TAG, "Initializing constructor of adapter.");
        //this.context = context;
        inflator = LayoutInflater.from(context);
        this.results = results;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = inflator.inflate(R.layout.view_route_list, viewGroup, false);
        Log.d(TAG, "Initializing view holder for list view of vehicle result..");
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(MyViewHolder myViewHolder, int i) {
        Log.d(TAG, "Setting data on Viewholder.");
        String name = results.get(i);
        Log.d(TAG, "View holder bind: "+i);
        myViewHolder.routeName.setText(name);
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

        TextView routeName;

        public MyViewHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(this);
            routeName = (TextView) itemView.findViewById(R.id.viewRoute_RouteName);
        }

        @Override
        public void onClick(View v) {
            Log.d(TAG, "Activating the onclick listener");
            if (touchListener!=null){
                //passing the current position of the touched item in the navigation
                //the title is passed in order identify between LoginView and create account option since
                //both have same id but different name and they must envoke different function.
                touchListener.menuItemClicked(getLayoutPosition(),results.get(getLayoutPosition()));

            }
        }
    }

    public interface TouchListener{
        public void menuItemClicked(int position, String routeName);
    }
}
