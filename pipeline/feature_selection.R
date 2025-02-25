# feature selection


spatial_variable_selection = function(modelname, training_samples, predictors, response, folds, hyperparameter){
    
    training_samples = training_samples %>% 
        dplyr::select(all_of(c(predictors, response))) %>% 
        st_drop_geometry()
    
    i = folds
    set.seed(4815)
    
    
    ffsModel = CAST::ffs(predictors = training_samples %>% dplyr::select(all_of(predictors)),
                         response = training_samples %>% pull(response),
                         method = "ranger",
                         tuneGrid = hyperparameter,
                         num.trees = 100,
                         trControl = caret::trainControl(method = "cv",number = 10,
                                                         index = i$index, indexOut = i$indexOut,
                                                         savePredictions = "final"),
                         importance = "permutation",
                         withinSE = TRUE)
    
    saveRDS(ffsModel, paste0(modelname, "/rfmodel.RDS"))
    return(ffsModel)
    
}

