


source("setup.R")
source("scripts/openEO-sentinel.R")



openeo::connect("https://openeo.cloud")




walk(list.files("data/misc/", full.names = TRUE, pattern = ".gpkg$"), function(r){
    
    aoi = st_read(r)
    process_graph = sentinel_composite(region = aoi, t = c("2021-04-01", "2021-10-01"))
    
    
    process_json <- jsonlite::toJSON(process_graph$serialize(), auto_unbox = TRUE, force = TRUE)
    
    cat(process_json, file = paste0("openEO/get_", aoi$region, ".json"))
    
    
})
