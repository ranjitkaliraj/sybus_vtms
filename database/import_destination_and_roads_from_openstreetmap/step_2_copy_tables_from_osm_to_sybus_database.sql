pg_dump -U postgres -t mainroads osm | psql -U postgres sybus
pg_dump -U postgres -t destinations osm | psql -U postgres sybus