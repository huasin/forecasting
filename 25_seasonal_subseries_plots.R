rm(list = ls())
library(fpp3)

a10 <- readRDS("files/a10.rds")

# Agrupa por mes del año, y plotea todos los años de cada mes para ver una tentndia

a10 %>% 
    gg_subseries(Cost) +
    ylab("$ millon") +
    xlab("Year") +
    ggtitle("Seasonal subseries plot: antidiabetic drug sales")

 # Ejemplo: Australian holiday tourism

 holidays <- tourism %>% 
    filter(Purpose == "Holiday") %>% 
    group_by(State) %>% 
    summarise(Trips = sum(Trips))

holidays %>% autoplot(Trips) +
    ylab("thousand of trips") +
    xlab("Year") +
    ggtitle("Australian domestic holiday nights")

holidays %>% gg_season(Trips) +
    ylab("thousand of trips") +
    ggtitle("Australian domestic holiday nights")

holidays %>% gg_subseries(Trips) +
    ylab("thousands of trips") +
    ggtitle("Australian domestic holiday nights")