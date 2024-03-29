% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SDMdata.quality.R
\name{SDMdata.quality}
\alias{SDMdata.quality}
\title{Evaluate dataset quality}
\usage{
SDMdata.quality(data)
}
\arguments{
\item{data}{\link{SDMtab} object or dataframe that contains id, longitude, latitude and values of environmental descriptors at corresponding locations}
}
\value{
prop Dataframe that provides the proportion of NA values on which the presence data fall, for each environmental predictor
}
\description{
Evaluate the percentage of occurrences that fall on pixels assigned by NA values in the environmental RasterStack. It may provide interesting information to interpret model robustness.
}
\examples{
#Generate a SDMtab
data('ctenocidaris.nutrix')
occ <- ctenocidaris.nutrix
# select longitude and latitude coordinates among all the information
occ <- ctenocidaris.nutrix[,c('decimal.Longitude','decimal.Latitude')]

library(raster)
data("predictors2005_2012")
envi <- predictors2005_2012
envi

#Create the SDMtab matrix
SDMtable_ctenocidaris <- SDMPlay:::SDMtab(xydata=occ,
                                         predictors=predictors2005_2012,
                                         unique.data=FALSE,
                                         same=TRUE)

# Evaluate the matrix quality
\dontrun{
SDMPlay:::SDMdata.quality(data=SDMtable_ctenocidaris)}
}
\seealso{
\link{SDMeval}
}
