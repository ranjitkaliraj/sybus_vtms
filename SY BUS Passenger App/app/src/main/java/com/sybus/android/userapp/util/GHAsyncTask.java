package com.sybus.android.userapp.util;

/**
 * Created by Ranjit Kaliraj on 1/6/2016.
 */
import android.os.AsyncTask;

public abstract class GHAsyncTask<A, B, C> extends AsyncTask<A, B, C>
{
    private Throwable error;

    protected abstract C saveDoInBackground( A... params ) throws Exception;

    protected C doInBackground( A... params )
    {
        try
        {
            return saveDoInBackground(params);
        } catch (Throwable t)
        {
            error = t;
            return null;
        }
    }

    public boolean hasError()
    {
        return error != null;
    }

    public Throwable getError()
    {
        return error;
    }

    public String getErrorMessage()
    {
        if (hasError())
        {
            return error.getMessage()+", Stack: "+error.getStackTrace().toString();
            //return error.getStackTrace().toString();
        }
        return "No Error";
    }
}
