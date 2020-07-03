rm(list = ls())
library(fpp3)

# Serie de tiempo de la electricidad
vic_elec %>% 
    filter(year(Time) == 2014) %>% 
    autoplot(Demand) +
    xlab("Year: 2014") + ylab(NULL) +
    ggtitle("Half-hourly electricity demand: Victoria, Australia")

# Serie de tiempo de la temperatura
vic_elec %>% 
    filter(year(Time) == 2014) %>% 
    autoplot(Temperature) +
    xlab("Year: 2014") + ylab(NULL) +
    ggtitle("Half-hourly temperatures: Melbourne, Australia")

# Vemos ambas con un scatterplot
vic_elec %>% 
    filter(year(Time) == 2014) %>% 
    ggplot(aes(Temperature,Demand)) +
    geom_point() +
    ylab("Demand (GW)") + xlab("Temperature (Celsius)")

# Scatterplot matrix
visitors <- tourism %>% 
    group_by(State) %>% 
    summarise(Trips = sum(Trips))

visitors %>% 
    ggplot(aes(Quarter, Trips)) +
    geom_line() +
    facet_grid(State~., scales = "free_y") +
    ylab("Number of visitor nights each quarter (millions)")

visitors %>% 
    spread(State, Trips) %>% 
    GGally::ggpairs(columns = 2:9)
