# SDMPlay
SDMPlay is a package developed to provide simple functions to build species distribution models and ready to use sets of marine biological and environmental data. The functions allow to compute models with two popular machine learning approaches, BRT (Boosted Regression Trees) and MaxEnt (Maximum Entropy). They include the possibility of managing the main parameters for the construction of the models. 
Classic tools to evaluate model performance are provided (Area Under the Curve, omission rate and confusion matrix, map standard deviation) and are completed with tools to perform null models. 

The biological dataset includes original occurrences of two species of the class Echinoidea (sea urchins) present on the Kerguelen Plateau and that show contrasted ecological niches. The dataset has been recently updated in Guillaumot et al. (submitted). The environmental dataset includes the corresponding statistics for 15 abiotic and biotic descriptors summarized for the Kerguelen Plateau and for different periods in a raster format. Sources are listed in Guillaumot et al. 2016. 

The package can be used for practicals to teach and learn the basics of species distribution modelling. Maps of potential distribution can be produced based on the example data included in the package, which brings prior observations of the influence of spatial and temporal heterogeneities on modelling performances. The user can also provide his own datasets to use the modelling functions. 

References=
Guillaumot C, A Martin, S Fabri-Ruiz, M Eleaume & T Saucede. Echinoids of the Kerguelen Plateau: Occurrence data and environmental setting for past, present, and future species distribution modelling.Zookeys, Manuscript submitted for publication. 

Guillaumot, C., Martin , A., Fabri-Ruiz, S., Eleaume, M. and Saucede, T. (2016) Environmental parameters (1955-2012) for echinoids distribution modelling on the Kerguelen Plateau. Australian Antarctic Data Centre - doi:10.4225/15/578ED5A08050F
