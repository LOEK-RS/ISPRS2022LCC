source("setup.R")

model_all = readRDS("lcc_modelling/lcc_lpo/rfmodel.RDS")
model_ffs = readRDS("lcc_modelling/lcc_ffs/rfmodel.RDS")


# Predictors

colnames(model_all$trainingData)
colnames(model_ffs$trainingData)



# Cross Validation Accuracy

round(CAST::global_validation(model_all), 3)["Accuracy"]
round(CAST::global_validation(model_ffs), 3)["Accuracy"]


# Testdata Accuracy

testdata = readRDS("lcc_modelling/lcc_ffs/testdata_prediction.RDS")
# testdata = readRDS("lcc_modelling/lcc_lpo/testdata_prediction.RDS")


# class confusion


testdata_relevant = testdata %>% filter(lcc2 %in% c("agriculture", "grassland", "settlement"))
testdata_nosand = testdata %>% filter(lcc2 != "sand")
testdata_sand = testdata %>% filter(lcc2 == "sand")

cm = caret::confusionMatrix(table(as.character(testdata_nosand$lcc2), as.character(testdata_nosand$prediction)), mode = "everything")
cm$table

table(testdata_nosand$prediction[testdata_nosand$lcc2 == "agriculture"])

library(xtable)
xtable(cm$table)





# davon outside AOA

testdata %>% filter(lcc2 == "agriculture" & aoa_ffs == 0) %>% pull(prediction_ffs) %>% table()
testdata %>% filter(lcc2 == "grassland" & aoa_ffs == 0) %>% pull(prediction_ffs) %>% table()
testdata %>% filter(lcc2 == "sand" & aoa_ffs == 0) %>% pull(prediction_ffs) %>% table()

## less relevant classes

testdata %>% filter(lcc2 == "water") %>% pull(prediction_ffs) %>% table()
testdata %>% filter(lcc2 == "forest") %>% pull(prediction_ffs) %>% table()
testdata %>% filter(lcc2 == "settlement") %>% pull(prediction_ffs) %>% table()
testdata %>% filter(lcc2 == "roads") %>% pull(prediction_ffs) %>% table()


# model all


testdata %>% filter(lcc2 == "agriculture") %>% pull(prediction_all) %>% table()
testdata %>% filter(lcc2 == "grassland") %>% pull(prediction_all) %>% table()
testdata %>% filter(lcc2 == "sand") %>% pull(prediction_all) %>% table()


table(testdata$lcc2, testdata$prediction_all)
table(testdata$lcc2, testdata$prediction_ffs)

table(testdata$lcc2, testdata$aoa_all)
table(testdata$lcc2, testdata$aoa_ffs)



testdata = testdata %>% filter(region == "Eiderstedt")



cm = caret::confusionMatrix(model)

library(xtable)
xtable(round(cm$table, 2))


