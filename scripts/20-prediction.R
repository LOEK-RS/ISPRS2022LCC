source("setup.R")

modelname = "lcc_lpo"



model = readRDS(paste0("lcc_modelling/", modelname, "/rfmodel.RDS"))
tdi = readRDS(paste0("lcc_modelling/", modelname ,"/trainDI.RDS"))

pi_predict = function(predictors, model){
    predictors = split(predictors, "band")
    names(predictors) = c("B02", "B03", "B04", "B05", "B06", "B07", "B08", "B8A", "B11", "B12", "NDVI", "EVI")
    prediction = predict(predictors, model)
    return(prediction)
}


pi_aoa = function(predictors, trainDI, model){
    predictors = split(predictors, "band")
    names(predictors) = c("B02", "B03", "B04", "B05", "B06", "B07", "B08", "B8A", "B11", "B12", "NDVI", "EVI")
    a = CAST::aoa(newdata = predictors, trainDI = trainDI, model = model)
    return(a)
}



eider = read_stars("data/predictors/eiderstedt.tif")
eider_p = pi_predict(eider, model)
saveRDS(eider_p, paste0("lcc_modelling/", modelname ,"/eiderstedt_prediction.RDS"))

eider_a = pi_aoa(eider, tdi, model)
saveRDS(eider_a, paste0("lcc_modelling/",modelname,"/eiderstedt_aoa.RDS"))



detmold = read_stars("data/predictors/detmold.tif")
detmold_p = pi_predict(detmold, model)
saveRDS(detmold_p, paste0("lcc_modelling/", modelname ,"/detmold_prediction.RDS"))
detmold_a = pi_aoa(detmold, tdi, model)
saveRDS(detmold_a, paste0("lcc_modelling/", modelname ,"/detmold_aoa.RDS"))

aachen = read_stars("data/predictors/aachen.tif")
aachen_p = pi_predict(aachen, model)
saveRDS(aachen_p, paste0("lcc_modelling/", modelname ,"/aachen_prediction.RDS"))

aachen_a = pi_aoa(aachen, tdi, model)
saveRDS(aachen_a, paste0("lcc_modelling/", modelname ,"/aachen_aoa.RDS"))
#########################
