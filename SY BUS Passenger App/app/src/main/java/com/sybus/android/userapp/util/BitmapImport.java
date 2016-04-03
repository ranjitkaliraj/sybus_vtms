package com.sybus.android.userapp.util;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;


/**
 * Created by Ranjit Kaliraj on 9/7/2015.
 */
public class BitmapImport {
    private Resources res;
    private int imgResId;
    private static int reqHeight;
    private static int reqWidth;

    public BitmapImport(Resources res, int imgResId) {
        this.res = res;
        this.imgResId = imgResId;
    }

    public BitmapImport(Resources res, int imgResId, int reqHeight, int reqWidth) {
        this.res = res;
        this.imgResId = imgResId;
        this.reqHeight = reqHeight;
        this.reqWidth = reqWidth;
    }

    //this method simply return the bitmap image after reading from the drawable resource.
    public Bitmap getDecodedBitMap() {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        Bitmap bitmap = BitmapFactory.decodeResource(res, imgResId, options);
        //int imageHeight = options.outHeight;
        //int imageWidth = options.outWidth;
        //String imageType = options.outMimeType;
        return bitmap;
    }

    //this method return a resize value of bitmap which will be used on  decodeResizedBitmap function
    public static int reSizedBitmap(BitmapFactory.Options options) {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {

            final int halfHeight = height / 2;
            final int halfWidth = width / 2;

            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) > reqHeight
                    && (halfWidth / inSampleSize) > reqWidth) {
                inSampleSize *= 2;
            }
        }

        return inSampleSize;
    }

    //this method decode and return a resized version of bitmap image.
    public Bitmap decodeResizedBitmap(Resources res, int resId, int reqWidth, int reqHeight) {

        // First decode with inJustDecodeBounds=true to check dimensions
        final BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(res, resId, options);

        // Calculate inSampleSize
        options.inSampleSize = reSizedBitmap(options);

        // Decode bitmap with inSampleSize set
        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeResource(res, resId, options);
    }

    /*
    usage in other class.
    mImageView.setImageBitmap(
    decodeSampledBitmapFromResource(getResources(), R.id.myimage, 100, 100));
     */
}
