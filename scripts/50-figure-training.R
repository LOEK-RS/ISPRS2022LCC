library(tmap)
library(sf)
library(mapview)
library(tidyverse)
library(rnaturalearth)


mapview::mapviewOptions(fgb = FALSE)


aois = list.files("data/misc/", full.names = TRUE) %>% map_dfr(st_read)
aois = aois %>% filter(!region %in% c("Pisa", "Rheinau", "Heidelberg", "Garmisch"))


aois$set = "Training"
aois$set[aois$region %in% c("Eiderstedt", "Detmold", "Aachen")] = "Test"

# prepare basemap
sf_use_s2(FALSE)
europe = rnaturalearth::ne_countries(scale = 10, continent = "Europe", returnclass = "sf")
europe = europe %>% filter(name != "Germany") %>% select(name)
ger = rnaturalearth::ne_states(country = "Germany", returnclass = "sf") %>% select(name)
europe = rbind(europe, ger)

europe = europe %>% st_crop(st_bbox(st_buffer(aois, 0.5)))




tm_shape(europe)+
    tm_borders()+
    tm_shape(aois)+
    tm_polygons(col = "set", title = "Reference")+
    tm_grid(lines = FALSE, projection = 4326, n.x = 5, n.y = 5,
            col = "black", labels.inside.frame = FALSE, labels.cardinal = TRUE)+
    tm_layout(frame = FALSE)

tmap_save(filename = "writing/studyarea.png")










