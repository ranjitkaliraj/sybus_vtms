package com.sybus.android.userapp.ui.adapters;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.view.ViewGroup;

import com.sybus.android.userapp.ui.fragments.HomeSearchFragment;
import com.sybus.android.userapp.ui.fragments.PaymentFragment;
import com.sybus.android.userapp.ui.fragments.PinnedFragment;
import com.sybus.android.userapp.ui.fragments.RouteFragment;

import java.util.ArrayList;

/**
 * Created by Ranjit Kaliraj on 8/31/2015.
 */
public class TabsPagerAdapter extends FragmentPagerAdapter{
    private String[] tabs; //{"Home","Status","myPay","Settings"};
    private static final int TAB_HOME = 0;
    private static final int TAB_PINNED = 1;
    private static final int TAB_ROUTE = 2;
    private static final int TAB_PAYMENT = 3;

    //private Fragment fragment;
    private Fragment homeFragment = HomeSearchFragment.newInstance("", "");;
    private Fragment pinnedFragment = PinnedFragment.newInstance("", "");
    private Fragment routeFragment = RouteFragment.newInstance("", "");
    private Fragment paymentFragment = PaymentFragment.newInstance("", "");

    public TabsPagerAdapter(FragmentManager fm, String[] tabs) {
        super(fm);
        this.tabs = tabs;
    }

    @Override
    public Fragment getItem(int position) {
        //TabsMenuFragment fragment = TabsMenuFragment.getInstance(position);
        Fragment fragment = null;
        switch (position){
            case TAB_HOME:
                //fragment = HomeSearchFragment.newInstance("", "");
                fragment = homeFragment;
                break;
            case TAB_PINNED:
                //fragment = PinnedFragment.newInstance("", "");
                fragment = pinnedFragment;
                break;
            case TAB_ROUTE:
                //fragment = RouteFragment.newInstance("", "");
                fragment = routeFragment;
                break;
            case TAB_PAYMENT:
                //fragment = PaymentFragment.newInstance("", "");
                fragment = paymentFragment;
                break;
        }
        return fragment;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return tabs[position];
    }

    @Override
    public int getCount() {
        return tabs.length;
    }

    public PinnedFragment getPinnedFragment(){
        return (PinnedFragment) pinnedFragment;
    }

    public RouteFragment getRouteFragment(){
        return (RouteFragment) routeFragment;
    }


    public PaymentFragment getPaymentFragment(){
        return (PaymentFragment) paymentFragment;
    }

}
