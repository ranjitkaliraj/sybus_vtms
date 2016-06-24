\echo Dropping any previous table.
DROP TABLE destinations;

\echo Creating destination table.
CREATE TABLE DESTINATIONS (
	id BigSerial PRIMARY KEY,
	osm_id BigSerial not null,
	name Text NOT NULL,
	way geometry(POINT,900913) NOT NULL
);

\echo Inserting data in destination table.
--Update: also include public transport
INSERT INTO DESTINATIONS(osm_id, name, way) SELECT osm_id, name, way FROM planet_osm_point WHERE (name IS NOT NULL AND place IS NOT NULL OR public_transport IS NOT NULL) AND st_x(st_transform(st_setsrid(way,900913),4326)) BETWEEN 85.1983 AND 85.4385 AND st_y(st_transform(st_setsrid(way,900913),4326)) BETWEEN 27.6093 AND 27.7853 AND UPPER(name) NOT LIKE UPPER('%-%') AND UPPER(name) NOT LIKE UPPER('%:%');

--offices names, polygon only university, bus_station and hospital are selected.
INSERT INTO DESTINATIONS(osm_id, name, way) select osm_id, name, ST_Centroid(way) from planet_osm_polygon where name != '' AND amenity IN('university', 'bus_station', 'hospital') AND st_x(st_transform(st_setsrid(ST_Centroid(way),900913),4326)) BETWEEN 85.1983 AND 85.4385 AND st_y(st_transform(st_setsrid(ST_Centroid(way),900913),4326)) BETWEEN 27.6093 AND 27.7853;



\echo Dropping any old table.
DROP TABLE mainroads;

\echo Creating new table mainroads.
CREATE TABLE MainRoads(
	_id Bigint NOT NULL,
	road_name Text NOT NULL,
	roadline geometry(LINESTRING,4326) NOT NULL
);

\echo Inserting data.
--inserting the data from osm table.
INSERT INTO mainroads (select osm_id, name, st_transform(way,4326) as way FROM planet_osm_line WHERE highway IN ('trunk','primary','secondary') AND name IS NOT NULL AND st_x(st_transform(st_setsrid(st_startpoint(way),900913),4326)) BETWEEN 85.1983 AND 85.4385 AND st_y(st_transform(st_setsrid(st_endpoint(way),900913),4326)) BETWEEN 27.6093 AND 27.7853);

