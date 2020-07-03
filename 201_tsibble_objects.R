library(tsibble)
library(dplyr)

# Crear un tsibble
y <- tsibble(Year = 2015:2019, Observation = c(123,39,78,52,110), index = Year)

# Funcion para tener dato clase yearmonth
yearmonth("201901")

# Acepta funciones de dplyr: select, mutate, filter, summarise...
a10 <- PBS %>%
  filter(ATC2=="A10") %>%
  select(Month, Concession, Type, Cost) %>%
  summarise(TotalC = sum(Cost)) %>%
  mutate(Cost = TotalC/1e6)

# Leer csv
prison <- readr::read_csv("https://OTexts.com/fpp3/extrafiles/prison_population.csv")

# Transformas a tsibble
# Es necesario tener un único index para c/ combinacion de keys
prison <- prison %>% 
    mutate(quarter = yearquarter(date)) %>% 
    select(-date) %>% 
    as_tsibble(key = c(state,gender,legal,indigenous), index = quarter)

prison

# El df a10 se ocupa mas adelante
saveRDS(a10,"files/a10.rds")