rm(list = ls())
library(fpp3)

# Data
recent_production <- aus_production %>%
  filter(year(Quarter) >= 1992)

# Auto correlation function (autocorrelation coefficients) ACF
recent_production %>% ACF(Beer, lag_max = 9)

# Plotearla
# Se ven los pics positivos en 4 y 8,los negativos en 2 y 6
# Coincide con el lag plot
recent_production %>% ACF(Beer) %>% autoplot

# Trend and Seasonality
# Tendencia -> Decreciente
# Estacionalidad -> "olas" que se forman

a10 <- readRDS("files/a10.rds")
a10 %>% ACF(Cost, lag_max = 48) %>% autoplot