% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Environmental_data_2005_2012_description.R
\docType{data}
\name{predictors2005_2012}
\alias{predictors2005_2012}
\title{Environmental descriptors for 2005-2012 (Kerguelen Plateau)}
\format{
RasterStack of 15 environmental descriptors. Grid: nrow= 100, ncol= 179, ncells= 17900 pixels. Spatial resolution: 0.1. Spatial extent: 63/81W; -46/-56S. \cr Crs : +proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0. Origin=0

\itemize{
  \item \strong{depth} \cr Bathymetric grid around the Kerguelen Plateau \cr
  Unit=meter. Reference=Guillaumot et al. (2016), derived from Smith & Sandwell (1997) \cr \url{https://topex.ucsd.edu/WWW_html/mar_topo.html}

  \item \strong{seasurface_temperature_mean_2005_2012} \cr Mean sea surface temperature over 2005-2012 \cr Unit=Celsius degrees. Reference= World Ocean Circulation Experiment 2013 \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seasurface_temperature_amplitude_2005_2012} \cr Amplitude between mean summer and mean winter sea surface temperature over 2005-2012  \cr Unit=Celsius degrees. Reference= World Ocean Circulation Experiment 2013 \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seafloor_temperature_mean_2005_2012} \cr Mean seafloor temperature over 2005-2012 \cr Unit=Celsius degrees. Reference=Guillaumot et al. (2016), derived from World Ocean Circulation Experiment 2013 sea surface temperature layers \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seafloor_temperature_amplitude_2005_2012} \cr Amplitude between mean summer and mean winter seafloor temperature over 2005-2012 \cr Unit=Celsius degrees. Reference=Guillaumot et al. (2016,submitted), derived from World Ocean Circulation Experiment 2013 sea surface temperature layers \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seasurface_salinity_mean_2005_2012} \cr Mean sea surface salinity over 2005-2012 \cr Unit=PSS. Reference= World Ocean Circulation Experiment 2013 \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seasurface_salinity_amplitude_2005_2012} \cr Amplitude between mean summer and mean winter sea surface salinity over 2005-2012 \cr Unit=PSS. Reference= World Ocean Circulation Experiment 2013 \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seafloor_salinity_mean_2005_2012} \cr Mean seafloor salinity over 2005-2012 \cr Unit=PSS. Reference= Guillaumot et al. (2016), derived from World Ocean Circulation Experiment 2013 sea surface salinity layers. \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{seafloor_salinity_amplitude_2005_2012} \cr Amplitude between mean summer and mean winter seafloor salinity over 2005-2012 \cr Unit=PSS. Reference= Guillaumot et al. (2016), derived from World Ocean Circulation Experiment 2013 sea surface salinity layers \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{chlorophyla_summer_mean_2002_2009} \cr Surface chlorophyll a concentration. Summer mean over 2002-2009 \cr Unit=mg/m3.Reference=MODIS AQUA (NASA) 2010 \cr \url{https://oceandata.sci.gsfc.nasa.gov/}

  \item \strong{geomorphology} \cr Geomorphologic features \cr Unit= 27 categories. Reference= ATLAS ETOPO2 2014 (Douglass et al. 2014)

  \item \strong{sediments} \cr Sediment features \cr Unit= 14 categories. Reference= McCoy (1991), updated by Griffiths 2014 (unpublished).

  \item \strong{slope} \cr Bathymetric slope \cr Unitless. Reference= Smith & Sandwell (1997)

  \item \strong{seafloor_oxygen_mean_1955_2012} \cr Mean seafloor oxygen concentration over 1955-2012 \cr Unit=mL/L. Reference= Guillaumot et al. (2016), derived from World Ocean Circulation Experiment 2013 sea surface oxygen concentration layers \cr \url{https://www.nodc.noaa.gov/OC5/woa13/woa13data.html}

  \item \strong{roughness} \cr Rugosity index (difference between minimal and maximal depth values of the 8 neighbour-pixels) \cr Unit= meters. Reference=Guillaumot et al.(2016), derived from bathymetric layer
  }
}
\usage{
data('predictors2005_2012')
}
\description{
RasterStack that compiles 15 environmental descriptors on the Kerguelen Plateau (63/81W; -46/-56S). See Guillaumot et al. (2016) for more information
}
\examples{
data('predictors2005_2012')
raster::plot(predictors2005_2012)

}
\references{
Douglass L, Turner J, Grantham HS, Kaiser S, Constable A, Nicoll R, Raymond B, Post A, Brandt A, Beaver D (2014) A hierarchical classification of benthic biodiversity and assessment of protected areas in the Southern Ocean. PloS one 9(7): e100551. doi: 10.1371/journal.pone.0100551.

Guillaumot, C., Martin , A., Fabri-Ruiz, S., Eleaume, M. and Saucede, T. (2016) Environmental parameters (1955-2012) for echinoids distribution modelling on the Kerguelen Plateau. Australian Antarctic Data Centre - doi:10.4225/15/578ED5A08050F

McCoy FW (1991) Southern Ocean sediments: circum-Antarctic to 30S. Marine Geological and Geophysical Atlas of the circum-Antarctic to 30S. (ed. by D.E. Hayes). Antarctic Research Series.

Smith W, Sandwell D (1997) Global seafloor topography from satellite altimetry and ship depth soundings. Science 277(5334): 1957-1962. doi: 10.1126/science.277.5334.1956.
}
\keyword{datasets}
