package com.sybus.android.userapp.util;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.support.v4.util.LruCache;
import android.widget.ImageView;

/**
 * Created by Ranjit Kaliraj on 9/7/2015.
 * All the codes are copied from google android doc.
 */
public class ImageCache {
    private LruCache<String, Bitmap> mMemoryCache;
    public Resources res;

    public ImageCache(Resources res){
        this.setMemoryCacheSize();
        this.res = res;
    }

    //this method sets the memory cache size
    public void setMemoryCacheSize(){
        // Get max available VM memory, exceeding this amount will throw an
        // OutOfMemory exception. Stored in kilobytes as LruCache takes an
        // int in its constructor.
        final int maxMemory = (int) (Runtime.getRuntime().maxMemory() / 1024);

        // Use 1/8th of the available memory for this memory cache.
        final int cacheSize = maxMemory / 8;

        mMemoryCache = new LruCache<String, Bitmap>(cacheSize) {
            @Override
            protected int sizeOf(String key, Bitmap bitmap) {
                // The cache size will be measured in kilobytes rather than
                // number of items.
                return bitmap.getByteCount() / 1024;
            }
        };
    }


    public void addBitmapToMemoryCache(String key, Bitmap bitmap) {
        if (getBitmapFromMemCache(key) == null) {
            mMemoryCache.put(key, bitmap);
        }
    }

    public Bitmap getBitmapFromMemCache(String key) {
        return mMemoryCache.get(key);
    }


    public void loadBitmap(int resId, ImageView mImageView) {
        final String imageKey = String.valueOf(resId);
        final Bitmap bitmap = getBitmapFromMemCache(imageKey);
        if (bitmap != null) {
            mImageView.setImageBitmap(bitmap);
        } else {
            mImageView.setImageResource(resId);
            BitmapWorkerTask task = new BitmapWorkerTask(mImageView,this);
            task.execute(resId);
        }
    }

}
