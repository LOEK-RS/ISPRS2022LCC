# extract polygons

source("setup.R")


ref = st_read("data/reference_polygons.gpkg")

area_files = list.files("data/predictors/", pattern = ".tif$", full.names = TRUE)
area = sort(unique(ref$region))



extraction = map2(area, area_files, function(a, f){
    print(a)
    print(f)
    p = read_stars(f)
    r = ref %>% filter(region == a)
    
    e = p[r] %>%
        as.data.frame() %>%
        na.omit()
    
    e = reshape2::dcast(data = e, formula = x + y ~ band)
    colnames(e) = c("x", "y", "B02","B03","B04","B05","B06","B07","B08","B8A","B11","B12","NDVI","EVI")
    
    e = st_as_sf(e, coords = c("x", "y"), crs = 32632)
    e = st_join(e, r, left = TRUE)
    
    st_write(e, paste0("data/temp/", a, ".gpkg"))
    return(e)
    
})

results = do.call(rbind, extraction)

st_write(results, "data/reference_data.gpkg")
