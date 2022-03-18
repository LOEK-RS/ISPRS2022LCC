# 54 figure AOA

source("setup.R")
library(tmap)



a_ffs = readRDS("lcc_modelling/lcc_ffs/eiderstedt_aoa.RDS")
a_lpo = readRDS("lcc_modelling/lcc_lpo/eiderstedt_aoa.RDS")



a_both = a_ffs$AOA | a_lpo$AOA


aoa_map = tm_shape(a_ffs$AOA)+
    tm_raster(style = "cat", palette = c("0" = "deepskyblue1", "1" = NA), legend.show = FALSE)+
    tm_shape(a_lpo$AOA)+
    tm_raster(style = "cat", palette = c("0" = "deeppink3", "1" = NA), legend.show = FALSE)+
    tm_shape(a_both)+
    tm_raster(style = "cat", palette = c("FALSE" = "darkgoldenrod", "TRUE" = NA), legend.show = FALSE)+
    tm_layout(bg.color = "grey95",
              legend.bg.color = "white")+
    tm_add_legend(type = "fill",
                  col = c("deepskyblue1", "deeppink3", "darkgoldenrod"),
                  labels = c("Spatial Variable Selection",
                             "Full Model",
                             "Both"), title = "Outside AOA")

tmap_save(aoa_map, filename = "writing/eiderstedt_aoa.png")

