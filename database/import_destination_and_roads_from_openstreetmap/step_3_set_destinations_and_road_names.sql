\echo Deleting any old data in destination table.
DELETE FROM destination;

\echo Inserting data.
INSERT INTO destination(osm_id, destination_name, location_point) SELECT osm_id, name, way FROM destinations;

\echo Dropping the temp table destinations.
DROP TABLE destinations;

\echo deleting any old data in routeroad table.
DELETE FROM routeroad;

\echo Inderting data.
INSERT INTO routeroad(name, roadline) SELECT road_name, roadline FROM mainroads;

\echo Dropping the temp table mainroads.
DROP TABLE mainroads;