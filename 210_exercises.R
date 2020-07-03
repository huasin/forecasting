rm(list = ls())
library(fpp3)
theme_set(theme_minimal())

# 1. explorar la data gafa_stock, PBS, vic_elec, pelt ###
?gafa_stock # Stock prices Google, Amazon, Facebook and Apple.
?PBS # Monthly Medicare Australia prescription
?vic_elec # Half-hourly electricity demand for Victoria
?pelt # Pelt trading records

# 1.a. autoplot ###
gafa_stock %>% autoplot

PBS %>% 
    group_by(Concession) %>% 
    summarise(Scripts = sum(Scripts)) %>% 
    autoplot(Scripts)

vic_elec %>% autoplot(Demand)

pelt %>% autoplot(Hare)

pelt %>% autoplot(Lynx)

vic_elec

# 1.b. Time interval per series
# gafa_stock -> day
# PBS -> month
# vic_elec -> 30 minute
# pelt -> year

# 1.c. Usar filter para encontrar los días con el peak en el closing price para c/stock
gafa_stock %>% group_by(Symbol) %>% filter(Close == max(Close))

# Por separado
gafa_stock %>% filter(Symbol == "AAPL") %>% filter(Close == max(Close))
gafa_stock %>% filter(Symbol == "AMZN") %>% filter(Close == max(Close))
gafa_stock %>% filter(Symbol == "FB") %>% filter(Close == max(Close))
gafa_stock %>% filter(Symbol == "GOOG") %>% filter(Close == max(Close))

# 2. tute1

# 2.a. leer el archivo
tute1 <- readr::read_csv("http://otexts.com/fpp3/extrafiles/tute1.csv")
View(tute1)

# 2.b. Convertir en ts
tute1 <- tute1 %>% 
    mutate(Quarter = yearmonth(Quarter))
    as_tsibble(index = Quarter)

# 2.c. Plotear 3 series
tute1 %>% 
    pivot_longer(cols = 2:4, values_to = "Value", names_to = "Key") %>% 
    autoplot() + facet_grid(Key~., scale = "free_y")

# 3.a. Leer tourism con read_excel
# system("cd files && wget http://otexts.com/fpp3/extrafiles/tourism.xlsx")
tour <- readxl::read_excel("files/tourism.xlsx")

# 3.b. Crear un tourism igual al del paquete
tour <- tour %>% 
    mutate(Quarter = yearquarter(Quarter)) %>% 
    as_tsibble(key = c(Region, State, Purpose), index = Quarter)

# 3.c. Encontrar la combinación Region-Purpose que tiene el maximo nro de overnight trips en avg
tour  %>% 
    as_tibble %>% 
    group_by(Region, Purpose) %>% 
    summarise(avg_trips = mean(Trips)) %>% 
    arrange(-avg_trips)

# 3.d. Crear un nuevo tsibble que combine Purpose y Region y el total de trips por estado
tour %>% 
    group_by(Region, Purpose) %>% 
    summarise(Trips = sum(Trips, na.rm = T))

# 4. Crear plot de Bricks (aus_production), Lynx (pelt), Close (gafa_stocks), Demand (vic_elec)
aus_production %>% autoplot(Bricks)
pelt %>% autoplot(Lynx)
gafa_stock %>% autoplot(Close)
vic_elec %>% autoplot(Demand)

# 5. aus_arrivals from Japan, New Zeland, UK, US
# Usar autoplot, season, subseries
aus_arrivals %>% autoplot()
aus_arrivals %>% gg_season()
aus_arrivals %>% gg_subseries()

# 6. Seleccionar una seriea l azar de aus_retail y aplicar gráficos
set.seed(1234)

myts <- aus_retail %>% 
    filter(`Series ID` == sample(aus_retail$`Series ID`,1))

myts %>% autoplot(Turnover)
myts %>% gg_season(Turnover)
myts %>% gg_subseries(Turnover)
myts %>% gg_lag(Turnover, geom = "point", alpha = .4)
myts %>% ACF(Turnover, lag_max = 20) %>% autoplot


# 9. No es para nada un ruido blanco

aus_livestock %>% 
    filter(State == "Victoria", Animal == "Pigs", year(Month) %in% 1990:1995) %>% 
    autoplot

aus_livestock %>% 
    filter(State == "Victoria", Animal == "Pigs", year(Month) %in% 1990:1995) %>% 
    ACF(Count) %>% autoplot

aus_livestock$Animal %>% table

# 10.

dgoog <- gafa_stock %>%
  filter(Symbol == "GOOG", year(Date) >= 2018) %>%
  mutate(trading_day = row_number()) %>%
  update_tsibble(index = trading_day, regular = TRUE) %>%
  mutate(diff = difference(Close))

dgoog %>% autoplot(Close)
dgoog %>% ACF(Close) %>% autoplot

