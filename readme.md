# Sentinel 2 LCC Workflow for ISPRS 2022

This repository contains a reproducible case study of a landcover classification for the manuscript:

Ludwig M., Bahlmann J., Pebesma E., Meyer H. Developing transferable spatial prediction model: a case study of
satellite based landcover mapping - 2022 ISPRS Conference Paper


## Contents

* Sentinel-2 yearly composite acquisition with openEO
* Spatial Variable Selection to optimize the predictor space for spatial transferability
* Assessing spatial transferability with the models area of applicability

## Models

lcc_lpo: Model using 12 Sentinel Bands. Model accuracy evaluated with "leave-polygon-out" Cross Validation

lcc_ffs: Model using 5 Setinel-2 Bands as the outcome of spatial variable selection

Each model contains the associated predicitons and AOAs.




