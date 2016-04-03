package com.sybus.android.userapp.ui.adapters;

import android.content.Context;
import android.database.AbstractCursor;
import android.database.Cursor;
import android.text.TextUtils;
import android.widget.SimpleCursorAdapter;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Locale;

/**
 * Created by Ranjit Kaliraj on 1/2/2016.
 */
public class SearchSuggestionAdapter extends SimpleCursorAdapter
{
    private static final String[] mFields  = { "_id", "result" };
    private static final String[] mVisible = { "result" };
    private static final int[]    mViewIds = { android.R.id.text1 };

    private ArrayList<String> suggestion;

    public SearchSuggestionAdapter(Context context)
    {
        super(context, android.R.layout.simple_list_item_1, null, mVisible, mViewIds, 0);
    }

    public void setData(ArrayList<String> data){
        this.suggestion = data;
    }

    @Override
    public Cursor runQueryOnBackgroundThread(CharSequence constraint)
    {
        return new SuggestionsCursor(constraint, suggestion);
    }

    private static class SuggestionsCursor extends AbstractCursor
    {
        private ArrayList<String> mResults;

        public SuggestionsCursor(CharSequence constraint, ArrayList<String> data)
        {
            mResults = data;
            /*final int count = 100;
            mResults = new ArrayList<String>(count);
            for(int i = 0; i < count; i++){
                mResults.add("Result " + (i + 1));
            }
            if(!TextUtils.isEmpty(constraint)){
                String constraintString = constraint.toString().toLowerCase(Locale.ROOT);
                Iterator<String> iter = mResults.iterator();
                while(iter.hasNext()){
                    if(!iter.next().toLowerCase(Locale.ROOT).startsWith(constraintString))
                    {
                        iter.remove();
                    }
                }
            }*/
        }

        @Override
        public int getCount()
        {
            return mResults.size();
        }

        @Override
        public String[] getColumnNames()
        {
            return mFields;
        }

        @Override
        public long getLong(int column)
        {
            if(column == 0){
                return getPosition();
            }else{
                return 0;
            }
        }

        @Override
        public float getFloat(int column) {
            return 0;
        }

        @Override
        public double getDouble(int column) {
            return 0;
        }

        @Override
        public String getString(int column)
        {
            if(column == 1){
                return mResults.get(getPosition());
            }
            else{
                return null;
            }
        }

        @Override
        public short getShort(int column) {
            return 0;
        }

        @Override
        public int getInt(int column) {
            return 0;
        }


        @Override
        public boolean isNull(int column)
        {
            return false;
        }
    }
}