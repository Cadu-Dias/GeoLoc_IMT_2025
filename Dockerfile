FROM jupyter/datascience-notebook

RUN pip install \
  geopandas \
  OSMPythonTools \
  OSMnx \
  folium \
  keplergl \
  sqlalchemy \
  psycopg2-binary \
  geoalchemy2 \
  geopy