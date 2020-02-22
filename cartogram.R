
###############################################################################################
## Cartogram that distorts the spatial geometry of a world map by each country's population  ##
###############################################################################################


# Set working dir ---------------------------------------------------------

setwd() # enter your working directory

# Packages ----------------------------------------------------------------

# install.packages(c("rgdal", "sp", "Rcartogram", "getcartr"))
library(rgdal)
library(sp) 
library(Rcartogram)
library(getcartr)

# Read data ---------------------------------------------------------------

map <- readOGR(dsn = getwd(), layer= "TM_WORLD_BORDERS-0.3") # http://thematicmapping.org/downloads/world_borders.php
proj4string(map)
data <- read.csv("population.csv") # scaling variable https://population.un.org/wpp/

# Create cartogram --------------------------------------------------------

# Merge SpatialPolygonsDataFrame with other info
map_data <- merge(map, data, by.x="ISO3", by.y="iso")

#remove coordinate reference system arguments
proj4string(map_data) <- CRS(as.character(NA)) 
cartogram <- quick.carto(data, data$pop, blur = 0)

# Plot cartogram ----------------------------------------------------------

my.palette = c("skyblue1", "skyblue4", "royalblue2", "blue1", "blue4")
plot(cartogram) 
spplot(cartogram, 'pop', col.regions = my.palette, cuts = length(my.palette)-1, main = "World Population")

############################################################################
############################################################################

