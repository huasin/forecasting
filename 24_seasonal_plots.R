rm(list = ls())
library(fpp3)

# Data
a10 <- readRDS("files/a10.rds")

a10 %>% gg_season(Cost, labels = "both") +
    ylab("$ millon") +
    ggtitle("Seasonal plot: antiabetic drug sales")


vic_elec %>% gg_season(Demand, period = "day") +
    theme(legend.position = "none")

vic_elec %>% gg_season(Demand, period = "week") +
    theme(legend.position = "none")

vic_elec %>% gg_season(Demand, period = "year")
