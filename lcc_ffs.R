# lcc feature selection

source("setup.R")

modelname = "lcc_ffs"
initModel(modelname)

# static input
training_samples = st_read("data/training_samples.gpkg")
testing_samples = st_read("data/testing_samples.gpkg")


predictor_names = c("B02", "B03", "B04", "B05", "B06", "B07", "B08", "B8A", "B11", "B12", "NDVI", "EVI")



folds = CAST::CreateSpacetimeFolds(training_samples,
                                   spacevar = "polygonID",
                                   k = 20, 
                                   class = "lcc2", 
                                   seed = 11)


saveRDS(folds, "lcc_ffs/folds.RDS")

###### Modelling

hyperparameter = expand.grid(mtry = 2,
                             splitrule = "gini",
                             min.node.size = 5)



# train model
model = train_model_index(modelname, training_samples,
                          predictors = c("B03", "B04", "B11", "B12", "NDVI"), response = "lcc2",
                          folds = folds, hyperparameter = hyperparameter)

model = spatial_variable_selection(modelname, training_samples, predictors = predictor_names, response = "lcc2",
                          folds = folds, hyperparameter = hyperparameter)

tdi = pi_trainDI(modelname, model)






