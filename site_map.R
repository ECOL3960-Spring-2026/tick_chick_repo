# Make a map of NEON sites!

## Load packages
#install.packages('maps')
library(tidyverse)
library(maps)

## Read in metadata for all NEON sites
sites_all <- read_csv('data/NEON_Field_Site_Metadata_20210226_0.csv') %>% 
  select(domainID:colocated_site, latitude:longitude, state:country)

## Define the list of your project's sites
mySites <- c('GRSM','HEAL','OSBS','SERC','TALL','TEAK')

## Subset "sites" object for your project sites
sites <- sites_all %>% 
  filter(siteID %in% mySites) %>% arrange(siteID)

## List state names of your sites
myStates <- as.character(sites$state)

## Map your sites!
# Run the chunk below all at once to avoid plotting errors
par(oma=c(2,2,1,1), mar = c(0,0,0,0),mgp=c(0,0,0))
maps::map('state', col='black', lwd=2) 
maps::map('state', region = myStates, add = T, fill=T, 
          col= 'tomato')  # Customize the fill color if you want!
points(sites$longitude, sites$latitude, 
       col='black', pch=16, cex=1.5,lwd=1)
axis(1, at=seq(-124,-68, 8), padj=1.5, cex.axis=1)
mtext("Longitude", 1, line=2.5, cex=1.25)
axis(2, at=c(25,31, 37, 43, 49), las=2, hadj=1.75, cex.axis=1)
mtext("Latitude", 2, line=2.5, cex=1.25)
text(sites$longitude, sites$latitude, sites$siteID,
     cex=1, font=2, 
     pos = c(4, 1, 3, 2, 1, 1, 1)) # 1 = below; 2 = left; 3 = above; 4 = right

# Notes: Alaska can't plot using this script! Omit site or just omit from map :)
# You'll likely need to mess around with the pos = values to make site names
# show up as legibly as possible; the order is alpha- by siteID (and will include
# any AK sites even though they're not shown on the map)
