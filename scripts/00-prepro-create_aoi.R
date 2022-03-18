# prepro create aois

source("setup.R")


ref = st_read("data/reference_polygons.gpkg")


walk(unique(ref$region), function(r){
    
    ref %>% filter(region == r) %>%
        st_buffer(dist = 1000) %>%
        st_transform(4326) %>% 
        st_bbox() %>% st_as_sfc() %>% st_as_sf(region = r) -> region_poly
    
    st_write(region_poly, paste0("data/misc/aoi_", str_to_lower(r), ".gpkg"))
    
    
})
