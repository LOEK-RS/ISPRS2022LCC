# 53 figure RGB

source("setup.R")

eiderstedt = read_stars("data/predictors/eiderstedt.tif")
eiderstedt = split(eiderstedt)
names(eiderstedt) = c("B02","B03","B04","B05","B06","B07","B08","B8A","B11","B12","NDVI","EVI")

testareas = st_read("data/reference_polygons.gpkg")
testareas = testareas %>% filter(region == "Eiderstedt") %>% st_centroid()


pal = c(agriculture = "darkgoldenrod2", forest = "seagreen", grassland = "seagreen2",
        roads = "grey30", settlement = "firebrick2", water = "cornflowerblue", sand = "pink")

rgb_map = tm_shape(eiderstedt)+ 
    tm_rgb(r = 3, g = 2, b = 1, max.value = 2500)+
    tm_shape(testareas)+
    tm_symbols(title.col = "Landcover\nTestsamples", palette = pal, col = "lcc2")+
    tm_grid(lines = TRUE, projection = 4326, n.x = 5, n.y = 5, col = "black", alpha = 0.6, labels.show = TRUE)+
    tm_layout(frame = FALSE, 
              legend.bg.color = "white",
              legend.frame = FALSE,
              legend.outside = FALSE)

rgb_map
tmap_save(rgb_map, filename = "writing/eiderstedt_rgb.png")
