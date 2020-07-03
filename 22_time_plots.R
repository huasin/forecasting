rm(list = ls())
library(fpp3)

a10 <- readRDS("files/a10.rds")

melsyd_economy <- ansett %>% 
    filter(Airports == "MEL-SYD", Class =="Economy")

melsyd_economy  %>% 
    autoplot(Passengers) +
    labs(title = "Ansett economy class passengers", subtitle = "Melbourne-Sydney") +
    xlab("Year")

a10 %>% autoplot(Cost) +
    ggtitle("Antidiabetic drug sales") +
    ylab("$ million") + xlab("Year")

