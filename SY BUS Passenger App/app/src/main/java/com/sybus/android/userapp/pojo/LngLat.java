package com.sybus.android.userapp.pojo;

import java.io.Serializable;

/**
 * Created by Ranjit Kaliraj on 1/4/2016.
 */
@SuppressWarnings("serial")
public class LngLat implements Serializable{
    private Double longitude;
    private Double latitude;

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }
}
