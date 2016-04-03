package com.sybus.android.userapp.ui.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.sybus.android.userapp.R;

/**
 * Created by Ranjit Kaliraj on 8/31/2015.
 */
public class NavigationPanelAdapter extends RecyclerView.Adapter<NavigationPanelAdapter.MyViewHolder> {
    public static String _id = "UI:NavigationPanelAdapter::";
    private LayoutInflater inflator;
    private Context context;
    private int[] icons;
    private String[] titles;
    private TouchListener touchListener;

    public NavigationPanelAdapter(Context context, int[] icons, String[] titles) {
        Log.d(_id, "Initializing constructor of adapter.");
        this.context = context;
        inflator = LayoutInflater.from(context);
        this.icons = icons;
        this.titles = titles;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup viewGroup, int i) {
        View view = inflator.inflate(R.layout.view_navigation_panel_item, viewGroup, false);
        Log.d(_id, "Initializing view holder.");
        MyViewHolder holder = new MyViewHolder(view);
        return holder;
    }

    @Override
    public void onBindViewHolder(MyViewHolder viewHolder, int i) {
        Log.d(_id, "Setting data on Viewholder.");
        viewHolder.title.setText(titles[i]);
        viewHolder.icon.setImageResource(icons[i]);

        //Adding the line divider on each section
        if(titles[i].equals("Remainder")){
            viewHolder.divider.setVisibility(View.VISIBLE);
        }
        else if(titles[i].equals("Help")){
            viewHolder.divider.setVisibility(View.VISIBLE);
        }
        else if(titles[i].equals("Logout") || titles[i].equals("Create an Account")){
            viewHolder.divider.setVisibility(View.VISIBLE);
        }
        else{
            viewHolder.divider.setVisibility(View.INVISIBLE);
        }
    }

    @Override
    public int getItemCount() {
        Log.d(_id, "Counting and returning the items.");
        int count1 = icons.length;
        int count2 = titles.length;
        if (count1 == count2){
            return count1;
        }
        else {
            Log.d(_id,"the icons and titles counts are different.");
            return 0;
        }
    }

    public void setTouchListener(TouchListener listener){
        touchListener = listener;
    }


    //this is a new class that will be passed in the extend parameter of RecyclerView.Adaptor
    class MyViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        TextView title;
        ImageView icon;
        View divider;

        public MyViewHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(this);
            title = (TextView) itemView.findViewById(R.id.listText);
            icon = (ImageView) itemView.findViewById(R.id.listIcon);
            divider = (View) itemView.findViewById(R.id.navigation_divider);
        }

        @Override
        public void onClick(View v) {
            Log.d(_id, "Activating the onclick listener");
            if (touchListener!=null){
                //passing the current position of the touched item in the navigation
                //the title is passed in order identify between LoginView and create account option since
                //both have same id but different name and they must envoke different function.
                touchListener.menuItemClicked(getLayoutPosition(),titles[getLayoutPosition()]);

            }
        }
    }

    public interface TouchListener{
        public void menuItemClicked(int position, String title);
    }
}


