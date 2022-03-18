# testdata extract predictions

source("setup.R")
modelname = "lcc_ffs"

model = readRDS(paste0("lcc_modelling/", modelname, "/rfmodel.RDS"))
testdata = st_read("lcc_modelling/data/testing_samples.gpkg")


# extract predictions

eider = readRDS(paste0("lcc_modelling/", modelname, "/eiderstedt_prediction.RDS"))
detmold = readRDS(paste0("lcc_modelling/", modelname, "/detmold_prediction.RDS"))
aachen = readRDS(paste0("lcc_modelling/", modelname, "/aachen_prediction.RDS"))

eider_e = st_extract(eider, testdata)
detmold_e = st_extract(detmold, testdata)
aachen_e = st_extract(aachen, testdata)


e = rbind(eider_e, detmold_e, aachen_e)
e = na.omit(e)

testdata = st_join(testdata, e)


# extract AOA

eider_a = readRDS(paste0("lcc_modelling/", modelname, "/eiderstedt_aoa.RDS"))
detmold_a = readRDS(paste0("lcc_modelling/", modelname, "/detmold_aoa.RDS"))
aachen_a = readRDS(paste0("lcc_modelling/", modelname, "/aachen_aoa.RDS"))

eider_e = st_extract(eider_a$AOA, testdata)
detmold_e = st_extract(detmold_a$AOA, testdata)
aachen_e = st_extract(aachen_a$AOA, testdata)

e = rbind(eider_e, detmold_e, aachen_e)
e = na.omit(e)

testdata = st_join(testdata, e)


saveRDS(testdata, paste0("lcc_modelling/", modelname, "/testdata_prediction.RDS"))



