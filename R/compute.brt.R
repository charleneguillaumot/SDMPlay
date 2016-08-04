#' Compute BRT (Boosted Regression Trees) model
#'
#'@description Compute species distribution models with Boosted Regression Trees
#'
#'@usage
#'compute.brt(x, proj.predictors, tc = 2, lr = 0.001, bf = 0.75,
#'            n.trees = 50, step.size = n.trees)
#'
#'@param x \link{SDMtab} object or dataframe that contains id, longitude, latitude and values of environmental descriptors at corresponding locations
#'
#'@param proj.predictors RasterStack of environmental descriptors on which the model will be projected
#'
#'@param tc Integer. Tree complexity. Sets the complexity of individual trees
#'
#'@param lr Learning rate. Sets the weight applied to individual trees
#'
#'@param bf Bag fraction. Sets the proportion of observations used in selecting variables
#'
#'@param n.trees Number of initial trees to fit. Set at 50 by default
#'
#'@param step.size Number of trees to add at each cycle
#'
#'@return
#'\itemize{
#'A list of 4
#'\item \emph{model$algorithm} "brt" string character
#'\item \emph{model$data} x dataframe that was used to implement the model
#'\item \emph{model$response} Parameters returned by the model object
#'\item \emph{model$raster.prediction} Raster layer that predicts the potential species distribution}
#'
#'
#'@details
#'The function realizes a BRT model according to the \link[dismo]{gbm.step} function provided by Elith et al.(2008). See the publication for further information about setting decisions. \cr The map produced provides species presence probability on the projected area.
#'
#'@note
#'See Barbet Massin et al. (2012) for information about background selection to implement BRT models
#'
#'@seealso
#'\link[dismo]{gbm.step}

#'@references
#'Barbet Massin M, F Jiguet, C Albert & W Thuiller (2012) Selecting pseudo absences for species distribution models: how, where and how many? \emph{Methods in Ecology and Evolution}, 3(2): 327-338.
#'
#'Elith J, J Leathwick & T Hastie (2008) A working guide to boosted regression trees. \emph{Journal of Animal Ecology}, 77(4): 802-813.
#'
#'
#'@examples
#'\dontrun{
#'#Download the presence data
#'data('ctenocidaris.nutrix')
#'occ <- ctenocidaris.nutrix
#'# select longitude and latitude coordinates among all the information
#'occ <- ctenocidaris.nutrix[,c('decimal.Longitude','decimal.Latitude')]
#'
#'#Download the environmental predictors restricted on geographical extent and depth (-1500m)
#'envi <- raster::stack(system.file('extdata', 'pred.grd',package='SDMPlay'))
#'envi
#'
#'#Open SDMtab matrix
#'x <- system.file(file='extdata/SDMdata1500.csv',package='SDMPlay')
#'SDMdata <- read.table(x,header=TRUE, sep=';')
#'
#'#Run the model
#'model <- SDMPlay:::compute.brt (x=SDMdata, proj.predictors=envi,lr=0.0005)
#'
#'#Plot the partial dependance plots
#'dismo::gbm.plot(model$response)
#'
#'#Get the contribution of each variable for the model
#'model$response$contributions
#'
#'#Get the interaction between variables
#'dismo::gbm.interactions(model$response)
#'#Plot the interactions
#'int <- dismo::gbm.interactions(model$response)
#'# choose the interaction to plot
#'dismo::gbm.perspec(model$response,int$rank.list[1,1],int$rank.list[1,3])
#'
#'#Plot the map prediction
#'library(grDevices) # add nice colors
#'palet.col <- colorRampPalette(c('deepskyblue','green','yellow', 'red'))( 80 )
#'raster::plot(model$raster.prediction, col=palet.col)
#'#add data
#'points(occ, col='black',pch=16)
#'
#'
#'# SECOND EXAMPLE: projecting the model on another period
#'# Remark: to predict on a different RasterStack, the rasterlayer names of the two
#'# stacks must be the same and the number of layers must be the same as well.
#'# Changes have been done in this example by attributing similar names to pred
#'# and pred2000 stacks and adding extra blank layers (NA layers) to pred2000 stack.
#'envi2000 <- raster::stack(system.file('extdata', 'pred2000.grd',package='SDMPlay'))
#'
#'#Run the model
#'model2 <- SDMPlay:::compute.brt (x=SDMdata, proj.predictors=envi2000,lr=0.0005)
#'
#'#Plot the new predicting map
#'raster::plot(model2$raster.prediction, col=palet.col)
#'#add data
#'points(occ, col='black',pch=16)}

compute.brt <- function(x, proj.predictors, tc = 2, lr = 0.001, bf = 0.75, n.trees = 50, step.size = n.trees) {

    if (!requireNamespace("dismo")) {
        stop("you need to install the dismo package to run this function")
    }

    model <- dismo::gbm.step(data = x, gbm.x = 4:ncol(x), gbm.y = 1, tree.complexity = tc, learning.rate = lr,
        bag.fraction = bf, n.trees = n.trees, step.size = step.size)

    # map prediction
    prediction <- raster::predict(object = proj.predictors, model = model, n.trees = model$gbm.call$best.trees,
        type = "response", na.rm = TRUE)
    return(list(algorithm = "brt", data = x, response = model, raster.prediction = prediction))


}
