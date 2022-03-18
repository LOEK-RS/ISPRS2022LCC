# extract polygons

source("setup.R")


ref = st_read("data/reference_polygons.gpkg")
area = sort(unique(ref$region))


extraction = map(area, function(a){
    print(a)
    f = paste0("data/predictors/", str_to_lower(a), ".tif")
    p = read_stars(f)
    r = ref %>% filter(region == a)
    
    e = p[r] %>%
        as.data.frame() %>%
        na.omit()
    
    e = reshape2::dcast(data = e, formula = x + y ~ band)
    colnames(e) = c("x", "y", "B02","B03","B04","B05","B06","B07","B08","B8A","B11","B12","NDVI","EVI")
    
    e = st_as_sf(e, coords = c("x", "y"), crs = 32632)
    e = st_join(e, r, left = TRUE)
    
    st_write(e, paste0("data/temp/", a, ".gpkg"), append = FALSE)
    return(e)
    
})

results = do.call(rbind, extraction)

st_write(results, "data/reference_data.gpkg", append = FALSE)



# split into train and test and save for modelling


train_data = results %>% filter(set == "training")
test_data = results %>% filter(set == "testing")


train_data = train_data %>% filter(lcc2 != "sand")




train_sample = train_data %>% group_by(lcc2) %>% slice_sample(n = 2500)
st_write(train_sample, "lcc_modelling/data/training_samples.gpkg", append = FALSE)

test_sample = test_data %>% group_by(lcc2) %>% slice_sample(n = 2500)
st_write(test_sample, "lcc_modelling/data/testing_samples.gpkg", append = FALSE)



