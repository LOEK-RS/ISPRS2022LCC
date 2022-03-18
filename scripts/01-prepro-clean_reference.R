# training data cleaning

source("setup.R")



samples = st_read("data/trainingsites_remotesensingcourse.gpkg")


# Removing the obvious
samples = samples %>% filter(Kategorie_2 != "Wolken")
samples = samples %>% filter(Kategorie_2 != "Kulturlandschaft")



# Aachen is wrong
samples = samples %>% filter(Region != "Aachen")

samples$Region[samples$Region == "trainData_aachen_kai.RDS"] = "Aachen"
samples$Region[samples$Region == "Trainingsdaten_Heidelberg_Sophia.RDS"] = "Heidelberg"
samples$Region[samples$Region == "Noerdliches_Ruhrgebiet"] = "Bottrop"


samples = samples %>% filter(Kategorie_2 != "Industrie")
samples = samples %>% filter(Kategorie_2 != "Offenboden")

samples$polygonID = paste0(samples$Region, str_pad(samples$ID, 2, pad = 0))

samples = samples %>% select(all_of(c("polygonID", "Region", "Kategorie_1", "Kategorie_2")))

samples$Kategorie_1[samples$Kategorie_1 == "Gewässer"] = "water" 
samples$Kategorie_1[samples$Kategorie_1 == "Industrie"] = "industrial"
samples$Kategorie_1[samples$Kategorie_1 == "Infrastruktur"] = "infrastructure"
samples$Kategorie_1[samples$Kategorie_1 == "Küste"] = "coast"
samples$Kategorie_1[samples$Kategorie_1 == "Offenboden"] = "soil"
samples$Kategorie_1[samples$Kategorie_1 == "Siedlung "] = "settlement"
samples$Kategorie_1[samples$Kategorie_1 == "Vegetation"] = "vegetation"


samples$Kategorie_2[samples$Kategorie_2 == "Bebauung"] = "settlement"
samples$Kategorie_2[samples$Kategorie_2 == "Fliessgewaesser"] = "water"
samples$Kategorie_2[samples$Kategorie_2 == "Gruenland"] = "grassland"
samples$Kategorie_2[samples$Kategorie_2 == "Landwirtschaft"] = "agriculture"
samples$Kategorie_2[samples$Kategorie_2 == "Salzwasser"] = "water"
samples$Kategorie_2[samples$Kategorie_2 == "Sand"] = "sand"
samples$Kategorie_2[samples$Kategorie_2 == "See"] = "water"
samples$Kategorie_2[samples$Kategorie_2 == "Verkehrswege"] = "roads"
samples$Kategorie_2[samples$Kategorie_2 == "Wald "] = "forest"


samples = samples %>% rename(lcc1 = Kategorie_1,
                             lcc2 = Kategorie_2,
                             region = Region)


# remove heidelberg
samples = samples %>% filter(region != "Heidelberg")


samples$set = "training"



samples$set[samples$region %in% c("Eiderstedt", "Aachen", "Detmold")] = "testing"



st_write(samples, "data/reference_polygons.gpkg", append = FALSE)





