rm(list = ls())
library(fpp3)

recent_production <- aus_production %>% 
    filter(year(Quarter) >= 1992)

# Grafico de la variable v/s su lag. Importante para ver correlacion con lags
recent_production %>% gg_lag(Beer, geom = "point")