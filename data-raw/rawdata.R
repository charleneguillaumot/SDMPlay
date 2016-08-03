# Script that contains the modifications done on the dataset before adding it to the /data folder

# Script for the echinoids data
#=============================
datapaper<-read.csv("data-raw/Echinoids_Kerguelen_Plateau_1872_2015.csv",header=T,sep=";")

# Ctenocidaris nutrix occurrences from MD03 & MD04 campaigns
esp70S_cteno<-subset(datapaper,datapaper$year==1974 | datapaper$year==1975)
esp70S_cteno<-subset(esp70S_cteno,esp70S_cteno$scientific.name=="Ctenocidaris_nutrix")

# Ctenocidaris nutrix occurrences from POKER and PROTEKER campaigns
esp2000S_cteno<-subset(datapaper,datapaper$year==2010 | datapaper$year==2011 | datapaper$year==2013 | datapaper$year==2014 | datapaper$year==2015)
esp2000S_cteno<-subset(esp2000S_cteno,esp2000S_cteno$scientific.name=="Ctenocidaris_nutrix")

ctenocidaris.nutrix<-rbind(esp70S_cteno,esp2000S_cteno)
id<-seq(from=1,to=nrow(ctenocidaris.nutrix),by=1)
ctenocidaris.nutrix <- cbind (id,ctenocidaris.nutrix[,c(-1,-14,-15)])

devtools::use_data(ctenocidaris.nutrix) # function that creates a .Rda object and put it in the /data folder

###########################################################################

# Brisaster antarcticus occurrences from MD03 & MD04 campaigns
esp70S_brisaster<-subset(datapaper,datapaper$year==1974 | datapaper$year==1975)
esp70S_brisaster<-subset(esp70S_brisaster,esp70S_brisaster$scientific.name=="Brisaster_antarcticus")

# Brisaster antarcticus occurrences from POKER and PROTEKER campaigns
esp2000S_brisaster<-subset(datapaper,datapaper$year==2010 | datapaper$year==2011 | datapaper$year==2013 | datapaper$year==2014 | datapaper$year==2015)
esp2000S_brisaster<-subset(esp2000S_brisaster,esp2000S_brisaster$scientific.name=="Brisaster_antarcticus")

brisaster.antarcticus<-rbind(esp70S_brisaster,esp2000S_brisaster)
id<-seq(from=1,to=nrow(brisaster.antarcticus),by=1)
brisaster.antarcticus <- cbind (id,brisaster.antarcticus[,c(-1,-14,-15)])

devtools::use_data(brisaster.antarcticus,overwrite=T) # function that creates a .Rda object and put it in the /data folder

###################################################################################
# production of the maps inside the package
# Ctenocidaris nutrix ; different colors according the decades; plot on the depth raster
blue.palette <- c("dodgerblue4","dodgerblue3","dodgerblue2","dodgerblue1","dodgerblue","deepskyblue2","deepskyblue1","deepskyblue","cadetblue2","cadetblue1","lightblue","azure1","azure")
library(maptools)
kerg<-readShapeSpatial("data/kerg_dem_con100m.shp") # inside model folder
kerg0<-subset(kerg,kerg$CONTOUR==0)

# Ctenocidaris
plot(profKER, col=blue.palette)
plot(kerg0, add=T)
points(esp70S_cteno[,c("decimal.Longitude","decimal.Latitude")],col="orange",pch=16)
points(esp2000S_cteno[,c("decimal.Longitude","decimal.Latitude")],col="darkgreen",pch=16)
legend("bottomleft", legend=c("Ctenocidaris nutrix 1974-1975","Ctenocidaris nutrix 2010-2013"),col= c("orange","darkgreen"), pch= c(15, 15),cex=0.9)

# Brisaster
plot(profKER, col=blue.palette)
plot(kerg0, add=T)
points(esp70S_brisaster[,c("decimal.Longitude","decimal.Latitude")],col="orange",pch=16)
points(esp2000S_brisaster[,c("decimal.Longitude","decimal.Latitude")],col="darkgreen",pch=16)
legend("bottomleft", legend=c("Brisaster antarcticus 1974-1975","Brisaster antarcticus 2010-2013"),col= c("orange","darkgreen"), pch= c(15, 15),cex=0.9)

# Script for the environmental data
#===================================
library(ncdf4)
library(maptools)
library(raster)
library(sp)
library(dismo)
library(rgdal)
library(dismo)
library(gdata)# pour la fonction resample
library(rJava)

#chargement des rasters

profKER<-raster("data/profKER.nc")

temp_surf<-raster("data/temp_surf.nc")
temp_5564_surf<-raster("data/temp_5564_surf.nc")
temp_6574_surf<-raster("data/temp_6574_surf.nc")
temp_7594_surf<-raster("data/temp_7594_surf.nc")
temp_0512_surf<-raster("data/temp_0512_surf.nc")

ampli_temp_all_surf<-raster("data/ampli_temp_all_surf.nc")
ampli_temp_5564_surf<-raster("data/ampli_temp_5564_surf.nc")
ampli_temp_6574_surf<-raster("data/ampli_temp_6574_surf.nc")
ampli_temp_7594_surf<-raster("data/ampli_temp_7594_surf.nc")
ampli_temp_0512_surf<-raster("data/ampli_temp_0512_surf.nc")

temp_fond_all<-raster("data/temp_fond_all.nc")
temp_fond_5564<-raster("data/temp_fond_5564.nc")
temp_fond_6574<-raster("data/temp_fond_6574.nc")
temp_fond_7594<-raster("data/temp_fond_7594.nc")
temp_fond_0512<-raster("data/temp_fond_0512.nc")

ampli_temp_fond_all<-raster("data/ampli_temp_fond_all.nc")
ampli_temp_fond_5564<-raster("data/ampli_temp_fond_5564.nc")
ampli_temp_fond_6574<-raster("data/ampli_temp_fond_6574.nc")
ampli_temp_fond_7594<-raster("data/ampli_temp_fond_7594.nc")
ampli_temp_fond_0512<-raster("data/ampli_temp_fond_0512.nc")

sali_surf<-raster("data/sali_surf.nc")
sali_surf_5564<-raster("data/sali_5564_surf.nc")
sali_surf_6574<-raster("data/sali_6574_surf.nc")
sali_surf_7594<-raster("data/sali_7594_surf.nc")
sali_surf_0512<-raster("data/sali_0512_surf.nc")

ampli_sali_surf<-raster("data/ampli_sali_surf.nc")
ampli_sali_surf_5564<-raster("data/ampli_sali_surf_5564.nc")
ampli_sali_surf_6574<-raster("data/ampli_sali_surf_6574.nc")
ampli_sali_surf_7594<-raster("data/ampli_sali_surf_7594.nc")
ampli_sali_surf_0512<-raster("data/ampli_sali_surf_0512.nc")

sali_fond_all<-raster("data/sali_fond_all.nc")
sali_fond_5564<-raster("data/sali_fond_5564.nc")
sali_fond_6574<-raster("data/sali_fond_6574.nc")
sali_fond_7594<-raster("data/sali_fond_7594.nc")
sali_fond_0512<-raster("data/sali_fond_0512.nc")

ampli_sali_fond_all<-raster("data/ampli_sali_fond_all.nc")
ampli_sali_fond_5564<-raster("data/ampli_sali_fond_5564.nc")
ampli_sali_fond_6574<-raster("data/ampli_sali_fond_6574.nc")
ampli_sali_fond_7594<-raster("data/ampli_sali_fond_7594.nc")
ampli_sali_fond_0512<-raster("data/ampli_sali_fond_0512.nc")

chloro_ete<-raster("data/chloro_ete.nc")
geomorpho<-raster("data/geomorpho.nc")
sediments<-raster("data/sediments.nc")
pente<-raster("data/pente.nc")
oxy_fond<-raster("data/oxy_fond.nc")
roughness<-raster("data/roughness.nc")

origin(profKER)<-0
origin(pente)<-0
origin(geomorpho)<-0
origin(chloro_ete)<-0
origin(roughness)<-0

# # minimum extent
mini<-profKER+temp_surf+temp_5564_surf+temp_6574_surf+temp_7594_surf+temp_0512_surf+ampli_temp_all_surf+ampli_temp_5564_surf+ampli_temp_6574_surf+ampli_temp_7594_surf+ampli_temp_0512_surf+temp_fond_all+temp_fond_5564+temp_fond_6574+temp_fond_7594+temp_fond_0512+ampli_temp_fond_all+ampli_temp_fond_5564+ampli_temp_fond_6574+ampli_temp_fond_7594+ampli_temp_fond_0512+sali_surf+sali_surf_5564+sali_surf_6574+sali_surf_7594+sali_surf_0512+ampli_sali_surf+ampli_sali_surf_5564+ampli_sali_surf_6574+ampli_sali_surf_7594+ampli_sali_surf_0512+sali_fond_all+sali_fond_5564+sali_fond_6574+sali_fond_7594+sali_fond_0512+ampli_sali_fond_all+ampli_sali_fond_5564+ampli_sali_fond_6574+ampli_sali_fond_7594+ampli_sali_fond_0512+chloro_ete+geomorpho+sediments+pente+oxy_fond+roughness

# remplacement des NA par des valeurs numériques (-999)
profKER<-crop(profKER,extent(mini))

temp_surf<-crop(temp_surf,extent(mini))
temp_5564_surf<-crop(temp_5564_surf,extent(mini))
temp_6574_surf<-crop(temp_6574_surf,extent(mini))
temp_7594_surf<-crop(temp_7594_surf,extent(mini))
temp_0512_surf<-crop(temp_0512_surf,extent(mini))

ampli_temp_all_surf<-crop(ampli_temp_all_surf,extent(mini))
ampli_temp_5564_surf<-crop(ampli_temp_5564_surf,extent(mini))
ampli_temp_6574_surf<-crop(ampli_temp_6574_surf,extent(mini))
ampli_temp_7594_surf<-crop(ampli_temp_7594_surf,extent(mini))
ampli_temp_0512_surf<-crop(ampli_temp_0512_surf,extent(mini))

temp_fond_all<-crop(temp_fond_all,extent(mini))
temp_fond_5564<-crop(temp_fond_5564,extent(mini))
temp_fond_6574<-crop(temp_fond_6574,extent(mini))
temp_fond_7594<-crop(temp_fond_7594,extent(mini))
temp_fond_0512<-crop(temp_fond_0512,extent(mini))

ampli_temp_fond_all<-crop(ampli_temp_fond_all,extent(mini))
ampli_temp_fond_5564<-crop(ampli_temp_fond_5564,extent(mini))
ampli_temp_fond_6574<-crop(ampli_temp_fond_6574,extent(mini))
ampli_temp_fond_7594<-crop(ampli_temp_fond_7594,extent(mini))
ampli_temp_fond_0512<-crop(ampli_temp_fond_0512,extent(mini))

sali_surf<-crop(sali_surf,extent(mini))
sali_surf_5564<-crop(sali_surf_5564,extent(mini))
sali_surf_6574<-crop(sali_surf_6574,extent(mini))
sali_surf_7594<-crop(sali_surf_7594,extent(mini))
sali_surf_0512<-crop(sali_surf_0512,extent(mini))

ampli_sali_surf<-crop(ampli_sali_surf,extent(mini))
ampli_sali_surf_5564<-crop(ampli_sali_surf_5564,extent(mini))
ampli_sali_surf_6574<-crop(ampli_sali_surf_6574,extent(mini))
ampli_sali_surf_7594<-crop(ampli_sali_surf_7594,extent(mini))
ampli_sali_surf_0512<-crop(ampli_sali_surf_0512,extent(mini))

sali_fond_all<-crop(sali_fond_all,extent(mini))
sali_fond_5564<-crop(sali_fond_5564,extent(mini))
sali_fond_6574<-crop(sali_fond_6574,extent(mini))
sali_fond_7594<-crop(sali_fond_7594,extent(mini))
sali_fond_0512<-crop(sali_fond_0512,extent(mini))

ampli_sali_fond_all<-crop(ampli_sali_fond_all,extent(mini))
ampli_sali_fond_5564<-crop(ampli_sali_fond_5564,extent(mini))
ampli_sali_fond_6574<-crop(ampli_sali_fond_6574,extent(mini))
ampli_sali_fond_7594<-crop(ampli_sali_fond_7594,extent(mini))
ampli_sali_fond_0512<-crop(ampli_sali_fond_0512,extent(mini))

chloro_ete<-crop(chloro_ete,extent(mini))
geomorpho<-crop(geomorpho,extent(mini))
sediments<-crop(sediments,extent(mini))
pente<-crop(pente,extent(mini))
oxy_fond<-crop(oxy_fond,extent(mini))
roughness<-crop(roughness,extent(mini))

# construction du jeu de données des prédicteurs
predictors<-stack(c(profKER,temp_surf,temp_5564_surf,temp_6574_surf,temp_7594_surf,temp_0512_surf,ampli_temp_all_surf,ampli_temp_5564_surf,ampli_temp_6574_surf,ampli_temp_7594_surf,ampli_temp_0512_surf,temp_fond_all,temp_fond_5564,temp_fond_6574,temp_fond_7594,temp_fond_0512,ampli_temp_fond_all,ampli_temp_fond_5564,ampli_temp_fond_6574,ampli_temp_fond_7594,ampli_temp_fond_0512,sali_surf,sali_surf_5564,sali_surf_6574,sali_surf_7594,sali_surf_0512,ampli_sali_surf,ampli_sali_surf_5564,ampli_sali_surf_6574,ampli_sali_surf_7594,ampli_sali_surf_0512,sali_fond_all,sali_fond_5564,sali_fond_6574,sali_fond_7594,sali_fond_0512,ampli_sali_fond_all,ampli_sali_fond_5564,ampli_sali_fond_6574,ampli_sali_fond_7594,ampli_sali_fond_0512,chloro_ete,geomorpho,sediments,pente,oxy_fond,roughness))



ens<-seq(1,47,1)
#période 1965_1974
ens.70<-ens[-c(1,4,9,14,19,24,29,34,39,42:47)]#c(): liste des couches à garder, du coup, ens.70: liste à supprimer
predictors1965_1974<-dropLayer(predictors,ens.70)
names(predictors1965_1974)<-c("depth","seasurface_temperature_mean_1965_1974","seasurface_temperature_amplitude_1965_1974","seafloor_temperature_mean_1965_1974","seafloor_temperature_amplitude_1965_1974","seasurface_salinity_mean_1965_1974","seasurface_salinity_amplitude_1965_1974","seafloor_salinity_mean_1965_1974","seafloor_salinity_amplitude_1965_1974","chlorophyla_summer_mean_2002_2009","geomorphology","sediments","slope","seafloor_oxygen_mean_1955_2012","roughness")
save(predictors1965_1974,file="predictors1965_1974.grd",compress="xz",compression_level = 9)

devtools::use_data(predictors1965_1974,compress="xz")

#période 2005_2012
ens.201013<-ens[-c(1,6,11,16,21,26,31,36,41,42:47)]#c(): liste des couches à garder, du coup, ens.70: liste à supprimer
predictors2005_2012<-dropLayer(predictors,ens.201013)
names(predictors2005_2012)<-c("depth","seasurface_temperature_mean_2005_2012","seasurface_temperature_amplitude_2005_2012","seafloor_temperature_mean_2005_2012","seafloor_temperature_amplitude_2005_2012","seasurface_salinity_mean_2005_2012","seasurface_salinity_amplitude_2005_2012","seafloor_salinity_mean_2005_2012","seafloor_salinity_amplitude_2005_2012","chlorophyla_summer_mean_2005_2012","geomorphology","sediments","slope","seafloor_oxygen_mean_2005_2012","roughness")
devtools::use_data(predictors2005_2012,compress="xz" )


####################### FUTURE ENVIRONMENTAL DATA ##### AIB 2200 IPCC SCENARIO #################################
# Stack compilation for 2200 A1B IPCC scenario

profKER<-raster("data/profKER.nc")
sali_surf_2200<-raster("data/sali_surf_2200.nc")
temp_surf_2200<-raster("data/temp_surf_2200.nc")
ampli_temp_surf_2200<-raster("data/ampli_temp_surf_2200.nc")

chloro_ete<-raster("data/chloro_ete.nc")
geomorpho<-raster("data/geomorpho.nc")
sediments<-raster("data/sediments.nc")
pente<-raster("data/pente.nc")
oxy_fond<-raster("data/oxy_fond.nc") # à lisser
roughness<-raster("data/roughness.nc")

origin(profKER)<-0
origin(pente)<-0
origin(geomorpho)<-0
origin(chloro_ete)<-0
origin(roughness)<-0

mini<-profKER+sali_surf_2200+temp_surf_2200+ampli_temp_surf_2200+chloro_ete+geomorpho+sediments+pente+oxy_fond+roughness

# Extent changing
profKER<-crop(profKER,extent(mini))
sali_surf_2200<-crop(sali_surf_2200,extent(mini))
temp_surf_2200<-crop(temp_surf_2200,extent(mini))
ampli_temp_surf_2200<-crop(ampli_temp_surf_2200,extent(mini))

chloro_ete<-crop(chloro_ete,extent(mini))
geomorpho<-crop(geomorpho,extent(mini))
sediments<-crop(sediments,extent(mini))
pente<-crop(pente,extent(mini))
oxy_fond<-crop(oxy_fond,extent(mini))
roughness<-crop(roughness,extent(mini))


predictors2200AIB<-stack(c(profKER,sali_surf_2200,temp_surf_2200,ampli_temp_surf_2200,chloro_ete,geomorpho,sediments,pente,oxy_fond,roughness))
names(predictors2200AIB)<-c("depth","seasurface_salinity_mean_2200_A1B","seasurface_temperature_mean_2200_A1B","seasurface_temperature_amplitude_2200_A1B","chlorophyla_summer_mean_2002_2009","geomorphology","sediments","slope","seafloor_oxygen_mean_1955_2012","roughness")

devtools::use_data(predictors2200AIB,compress="xz")



#################################### INTERNAL DATA #######################################
# example of delimited area
#===========================

pred <- delim.area(predictors = predictors1965_1974,longmin = 63,longmax = 81, latmin = -56,latmax = -46,interval = c(0,-1500))
#writeRaster(pred, file="pred.grd")
writeRaster(pred, file="pred.grd", datatype='INT2S', force_v4=TRUE, compression=7)
#save(pred, file="pred.grd",compress = "xz",compression_level = 9)
#devtools::use_data(pred,compress="xz")
# quote
envi <-stack(system.file("extdata", "pred.grd",package="SDMPlay"))
envi <-pred

data(predictors1965_1974)
data(predictors2005_2012)
pred2000 <-  delim.area(predictors = predictors2005_2012,longmin = 63,longmax = 81, latmin = -56,latmax = -46,interval = c(0,-1500))
names(pred2000) <- names(predictors1965_1974)
#save(pred2000, file="pred2000.grd",compress = "xz",compression_level = 9)
envi2000 <-stack(system.file("extdata", "pred2000.grd",package="SDMPlay"))
#devtools::use_data(pred2000,compress="xz")
writeRaster(pred2000, file="pred2000.grd", datatype='INT2S', force_v4=TRUE, compression=7)

# example of SDM tab
#====================
data('ctenocidaris.nutrix')
occ <- ctenocidaris.nutrix
z <- SDMtab(xydata=occ[,c('decimal.Longitude','decimal.Latitude')],predictors=pred)
write.table(z,file="SDMdata.csv")
devtools::use_data(z,compress="xz")
# open
SDMdata <- read.table(system.file("extdata","SDMdata.csv",package="SDMPlay"),header=T, sep=";")
head(SDMdata)

data('ctenocidaris.nutrix')
occ <- ctenocidaris.nutrix
z2 <- SDMtab(xydata=occ[,c('decimal.Longitude','decimal.Latitude')],predictors=pred)
write.table(z2,file="SDMdata_1500.csv")
write.table(z2,file="SDMdata.csv")
# open
SDMdata <- read.table(system.file("extdata","SDMdata_1500.csv",package="SDMPlay"),header=T, sep=";")
head(SDMdata)

# example of model
#==================
model <- compute.brt (x=SDMdata, proj.predictors=envi,lr=0.01)
model <- compute.maxent (x=SDMdata, proj.predictors=envi)
save(model, file="model.RData",compress="xz",compression_level = 9)

# open it
load("model.RData")
modelBRT <- model
