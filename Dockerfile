FROM jupyter/datascience-notebook

RUN pip install \
  geopandas \
  OSMPythonTools \
  OSMnx \
  folium \
  keplergl \
  sqlalchemy \
  psycopg2-binary \
  geoalchemy2

  # Original List of dependencies

  # RUN pip install \
  # shapely \
  # streamlit \
  # geopandas \
  # pyarrow \
  # keplergl \
  # OSMPythonTools \
  # OSMnx \
  # folium \
  # keplergl \
  # sqlalchemy \
  # pydeck \ 
  # psycopg2-binary \
  # geoalchemy2