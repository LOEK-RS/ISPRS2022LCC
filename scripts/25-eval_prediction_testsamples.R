source("setup.R")

modelname = "lcc_ffs"

model = readRDS(paste0("lcc_modelling/", modelname, "/rfmodel.RDS"))
testdata = readRDS(paste0("lcc_modelling/", modelname, "/testdata_prediction.RDS"))



# number of predictors
colnames(model$trainingData)
length(colnames(model$trainingData))-1


# spatial cv accuracy
model



# find out correcly classified test data
testdata = testdata %>% mutate(correct = if_else(lcc2 == prediction, 1, 0))



# filter sand pixel (excluded from accuracy assessment)
testdata_nosand = testdata %>% filter(lcc2 != "sand")
testdata_sand = testdata %>% filter(lcc2 == "sand")


# test accuracy = % of correct classifications
table(testdata_nosand$correct)["1"] / sum(table(testdata_nosand$correct))

# wrong classification but outside AOA
testdata_nosand %>% filter(correct == 0) %>% pull(AOA) %>% table() / testdata_nosand %>% filter(correct == 0) %>% nrow()


# correct classification but outside AOA
testdata_nosand %>% filter(correct == 1) %>% pull(AOA) %>% table() / testdata_nosand %>% filter(correct == 1) %>% nrow()


# sand outside AOA
testdata_sand %>% pull(AOA) %>% table() / nrow(testdata_sand)


