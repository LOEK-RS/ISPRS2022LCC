# figure prediction

source("setup.R")
library(tmap)

p_f = readRDS("lcc_modelling/lcc_ffs/eiderstedt_prediction.RDS")
a = readRDS("lcc_modelling/lcc_ffs/eiderstedt_aoa.RDS")

p_a = readRDS("lcc_modelling/lcc_lpo/eiderstedt_prediction.RDS")
a = readRDS("lcc_modelling/lcc_lpo/eiderstedt_aoa.RDS")

eiderstedt = read_stars("data/predictors/eiderstedt.tif")
eiderstedt = split(eiderstedt)
names(eiderstedt) = c("B02","B03","B04","B05","B06","B07","B08","B8A","B11","B12","NDVI","EVI")


#p = readRDS("lcc_modelling/lcc_lpo/eiderstedt_prediction.RDS")
#a = readRDS("lcc_modelling/lcc_lpo/eiderstedt_aoa.RDS")


testareas = st_read("data/reference_polygons.gpkg")
testareas = testareas %>% filter(region == "Eiderstedt") %>% st_centroid()


pal = c(agriculture = "darkgoldenrod2", forest = "seagreen", grassland = "seagreen2",
        roads = "grey30", settlement = "firebrick2", water = "cornflowerblue")



# Map prediction

prediction_map = tm_shape(p)+
    tm_raster(palette = pal, title = "Prediction")+
    tm_grid(lines = TRUE, projection = 4326, n.x = 5, n.y = 5, alpha = 0.3, col = "black")+
    tm_layout(frame = FALSE, 
              legend.bg.color = "white",
              legend.bg.alpha = 0.7,
              legend.frame = FALSE,
              legend.text.size = 0.9,
              legend.title.size = 1.2)

prediction_map


# Map AOA

aoa_map = tm_shape(a$AOA)+
    tm_raster(palette = c("0" = "grey30", "1" = "grey90"), style = "cat", legend.show = FALSE)+
    tm_grid(lines = TRUE, projection = 4326, n.x = 5, n.y = 5, col = "black", alpha = 0.6, labels.show = FALSE)+
    tm_layout(frame = FALSE, 
              legend.bg.color = "white",
              legend.frame = FALSE)

aoa_map



# Combined Map

comb_map = tm_shape(p)+
    tm_raster(palette = pal, title = "Prediction")+
    tm_shape(a$AOA)+
    tm_raster(palette = c("0" = "grey30", "1" = NA), style = "cat", legend.show = FALSE)+
    tm_grid(lines = TRUE, projection = 4326, n.x = 5, n.y = 5, alpha = 0.3, col = "black")+
    tm_layout(frame = FALSE, 
              legend.bg.color = "white",
              legend.bg.alpha = 0.7,
              legend.frame = FALSE,
              legend.text.size = 0.9,
              legend.title.size = 1.2)


comb_map

# RGB










tmap_save(prediction_map, filename = "writing/eiderstedt_prediction.png")
tmap_save(aoa_map, filename = "writing/eiderstedt_aoa.svg")
tmap_save(rgb_map, filename = "writing/eiderstedt_rgb.svg")



p_d = p_a == p_f
plot(p_d)
