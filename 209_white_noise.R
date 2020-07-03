rm(list = ls())
library(fpp3)

set.seed(30)

# Error blanco es una serie de tiempo que no muestra autocorrelación
y <- tsibble(sample = 1:50, wn = rnorm(50), index = sample)
y %>% autoplot(wn) + ggtitle("White noise")

# Si las barras se encuentran dentro de los límites, se considera cero (no corr -> white noise)
y %>% ACF(wn) %>% autoplot
