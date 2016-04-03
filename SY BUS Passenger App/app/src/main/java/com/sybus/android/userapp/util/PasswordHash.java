package com.sybus.android.userapp.util;

import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by Ranjit Kaliraj on 2/28/2016.
 */
public class PasswordHash {

    public static String TAG = PasswordHash.class.getName();

    //This function hash the password.
    public static String hashUserPassword(String password) {
        Log.d(TAG, "Creating the password hash.");
        try {
            MessageDigest digest = MessageDigest.getInstance("MD5");
            digest.update(password.getBytes());
            byte hashedBytes[] = (new String(digest.digest(), "UTF-8")).getBytes();

            //Convert into hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< hashedBytes.length ;i++)
            {
                sb.append(Integer.toString((hashedBytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            Log.d(TAG, "Hashed password: "+ sb.toString());
            return sb.toString();
        }
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 Error.", e);
        }
        catch (UnsupportedEncodingException e) {
            throw new RuntimeException("Encoding Error.", e);
        }
    }

}
