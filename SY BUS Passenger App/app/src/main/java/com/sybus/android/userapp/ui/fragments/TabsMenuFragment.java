package com.sybus.android.userapp.ui.fragments;


import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.sybus.android.userapp.R;

/**
 * A simple {@link Fragment} subclass.
 */
public class TabsMenuFragment extends android.support.v4.app.Fragment {

    private TextView textView;
    private int tabPosition;

    public static TabsMenuFragment getInstance(int position) {
        TabsMenuFragment fragment = new TabsMenuFragment();
        Bundle args = new Bundle();
        args.putInt("position", position);
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    //this method is called on everytime the tab is swiped.
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_tab_center_page, container, false);


        //Textview hold the view which is fragment_tab_center_page and which contain only textView tag so no need to findViewById.
        textView = (TextView) view;
        Bundle bundle = getArguments();
        if (bundle != null) {
            textView.setText("The page selected is " + bundle.getInt("position"));

        }
        return view;
    }
}
