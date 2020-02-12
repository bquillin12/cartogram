
######################################
## Generic Cartogram  ################
######################################


# Set working dir ---------------------------------------------------------

setwd() 


# Packages ----------------------------------------------------------------

# install.packages(c("rgdal", "sp", "Rcartogram", "getcartr))
library(rgdal)
library(sp) 
library(Rcartogram)
library(getcartr)
library(ggplot2)

# Read data ---------------------------------------------------------------

worldR <- readOGR(dsn = getwd(), layer= "TM_WORLD_BORDERS-0.3") # http://thematicmapping.org/downloads/world_borders.php
proj4string(worldR)
datR <- read.csv("population.csv") # scaling variable https://population.un.org/wpp/


# Create cartogram --------------------------------------------------------

# Merge SpatialPolygonsDataFrame with other info
map_dat <- merge(worldR, datR, by.x="ISO3",by.y="iso")

#remove coordinate reference system arguments
proj4string(map_dat) <- CRS(as.character(NA)) 
world.carto <- quick.carto(map_dat, map_dat$pop, blur = 0)


# Plot cartogram ----------------------------------------------------------

my.palette = c("skyblue1", "skyblue4", "royalblue2", "blue1", "blue4")
plot(world.carto) 
spplot(world.carto, 'pop', col.regions = my.palette, cuts = length(my.palette)-1,main="World Population")



