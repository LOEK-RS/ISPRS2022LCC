# workflow random cv


source("setup.R")

modelname = "lcc_lpo"
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


saveRDS(folds, "lcc_lpo/folds.RDS")

###### Modelling

hyperparameter = expand.grid(mtry = c(2,4,6,8),
                             splitrule = c("gini", "extratree"),
                             min.node.size = c(5,10,15))



# train model


model = train_model_index(modelname, training_samples, predictors = predictor_names, response = "lcc2",
                    folds = folds, hyperparameter = hyperparameter)

tdi = pi_trainDI(modelname, model)

