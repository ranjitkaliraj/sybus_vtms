package com.sybus.android.userapp.ui;

import com.sybus.android.userapp.R;

import org.mapsforge.core.model.LatLong;
import org.mapsforge.core.model.MapPosition;
import org.mapsforge.map.android.graphics.AndroidGraphicFactory;
import org.mapsforge.map.android.util.AndroidUtil;
import org.mapsforge.map.android.util.MapViewerTemplate;
import org.mapsforge.map.layer.renderer.TileRendererLayer;
import org.mapsforge.map.rendertheme.InternalRenderTheme;
import org.mapsforge.map.rendertheme.XmlRenderTheme;

/**
 * The simplest form of creating a map viewer based on the MapViewerTemplate.
 * It also demonstrates the use simplified cleanup operation at activity exit.
 */
public class MapActivity extends MapViewerTemplate {

    /**
     * This MapViewer uses the deprecated built-in osmarender theme.
     * @return the render theme to use
     */
    @Override
    protected XmlRenderTheme getRenderTheme() {
        return InternalRenderTheme.OSMARENDER;
    }


    /**
     * This MapViewer uses the standard xml layout in the Samples app.
     * @return
     */
    @Override
    protected int getLayoutId() {
        AndroidGraphicFactory.createInstance(this.getApplication()); //Use this to avoid mapview inflation error
        return R.layout.activity_map;
    }

    /**
     * The id of the mapview inside the layout.
     * @return the id of the MapView inside the layout.
     */
    @Override
    protected int getMapViewId() {
        return R.id.mapView;
    }

    /**
     * The name of the map file.
     * @return map file name
     */
    @Override
    protected String getMapFileName() {
        return "kathmandu.map";
    }


    /**
     * Creates a simple tile renderer layer with the AndroidUtil helper.
     */
    protected void createLayers() {
        TileRendererLayer tileRendererLayer = AndroidUtil.createTileRendererLayer(this.tileCaches.get(0),
                this.mapView.getModel().mapViewPosition, getMapFile(), getRenderTheme(), false, true);
        this.mapView.getLayerManager().getLayers().add(tileRendererLayer);
    }

    /**
     * Creates the tile cache with the AndroidUtil helper
     */
    protected void createTileCaches() {
        this.tileCaches.add(AndroidUtil.createTileCache(this, getPersistableId(),
                this.mapView.getModel().displayModel.getTileSize(), this.getScreenRatio(),
                this.mapView.getModel().frameBufferModel.getOverdrawFactor()));
    }

    @Override
    protected MapPosition getDefaultInitialPosition() {
        return new MapPosition(new LatLong(85.287037, 27.68886), (byte) 5);
    }
}