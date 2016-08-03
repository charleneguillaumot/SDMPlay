#' Evaluate dataset quality
#'
#'@description
#'Evaluate the percentage of occurrences that fall on pixels assigned by NA values in the environmental RasterStack. It may provide interesting information to interpret model robustness.
#'
#'@usage
#'SDMdata.quality(data)
#'
#'
#'@param data \link{SDMtab} object or dataframe that contains id, longitude, latitude and values of environmental descriptors at corresponding locations
#'
#'@return
#'prop Dataframe that provides the proportion of NA values on which the presence data fall, for each environmental predictor
#'
#'
#'@seealso
#'\link{SDMeval}
#'
#' @examples
#' #Open SDMtab object example
#' x <- system.file ("extdata","SDMdata1500.csv", package="SDMPlay")
#' SDMdata <- read.table(x,header=TRUE, sep=";")
#'
#' # Evaluate the dataset
#' SDMPlay:::SDMdata.quality(data=SDMdata)


SDMdata.quality <- function(data) {
    # count the number of NA values in each environmental parameter
    table <- base::colSums(is.na(data[,-c(1:3)]))
    table <- base::data.frame(table)
    # calculate the proportion of NA values
    prop <- (table/base::nrow(data)) * 100
    base::colnames(prop) <- "NA.percent (%)"
    return(prop)
}


