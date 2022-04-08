# 54 figure AOA

source("setup.R")
library(tmap)



a_ffs = readRDS("lcc_ffs/results/eiderstedt_aoa.RDS")
a_lpo = readRDS("lcc_lpo/results/eiderstedt_aoa.RDS")



a_both = a_ffs$AOA | a_lpo$AOA


aoa_map = tm_shape(a_ffs$AOA)+
    tm_raster(style = "cat", palette = c("0" = "deepskyblue1", "1" = NA), legend.show = FALSE)+
    tm_shape(a_lpo$AOA)+
    tm_raster(style = "cat", palette = c("0" = "deeppink3", "1" = NA), legend.show = FALSE)+
    tm_shape(a_both)+
    tm_raster(style = "cat", palette = c("FALSE" = "darkgoldenrod", "TRUE" = NA), legend.show = FALSE)+
    tm_layout(bg.color = "grey95",
              legend.bg.color = "white",
              frame = FALSE)+
    tm_add_legend(type = "fill",
                  col = c("deepskyblue1", "deeppink3", "darkgoldenrod"),
                  labels = c("Simplified Model",
                             "Full Model",
                             "Simplified + Full"), title = "Outside AOA")+
    tm_add_legend(type = "fill",
                  col = c("grey95"),
                  labels = c("Simplified + Full"),
                  title = "Inside AOA")

aoa_map

tmap_save(aoa_map, filename = "writing/eiderstedt_aoa.png", width = 15, height = 15, units = "cm")

