# Week 4 Importing and Filtering Eddypro Data.
library(ggplot2)
library(dplyr)

rm(list=ls())
# Import your the EddyPro full_output file:
file <- "/Users/sm3466/Dropbox (YSE)/Research/EC_Training/Eddy-Co/data/SRS6_03012018_04042018_IRGA_DATA/OUTPUT/eddypro_SRS6_TRAINING_full_output_2023-11-09T083406_exp.csv"

#Bring in the header only
header <- read.csv(file, nrows=1, skip=1)

# Bring in the data without the header and units lines:
flux_raw <- read.csv(file, header=FALSE, skip=3, stringsAsFactors=FALSE)

# Assign the column names using the header:
colnames( flux_raw ) <- colnames(header)

# Format the date:
flux_raw$Date <- as.Date(flux_raw$date)
class(flux_raw$Date)

# Create a timestamp using the date and the time column:
flux_raw <- flux_raw %>% mutate( TIMESTAMP = as.POSIXct(paste( Date, time, sep=" "), tz = "EST", format="%Y-%m-%d %H:%M"))
flux_raw$TIMESTAMP
# Create a full half hourly timestamp, format it:
ts <- data.frame(TIMESTAMP =seq.POSIXt(as.POSIXct("2018-03-01 00:00:00 EST"), as.POSIXct("2018-04-05 23:30:00 EST"), units = "sec", by = 1800))
ts$TIMESTAMP <- as.POSIXct(ts$TIMESTAMP , tz = "EST", format="%Y-%m-%d %H:%M:%S")

# Merge your full timestamp with the flux file:
srs6_raw  <-  ts %>% left_join(flux_raw , by="TIMESTAMP")

# Change all -9999.000 to NA
srs6_raw  [srs6_raw   == -9999.000] <- NA

# Calculate the flux for NEE, LE, and H:
srs6_raw$NEE <- srs6_raw$co2_flux -  srs6_raw$co2_strg
srs6_raw$LE <- srs6_raw$LE +  srs6_raw$LE_strg
srs6_raw$H <- srs6_raw$H +  srs6_raw  $H_strg

# Filter by values out of bounds. These are site specific!
ggplot(data=srs6_raw) + geom_point(aes(x=TIMESTAMP, y=NEE))
ggplot(data=srs6_raw) + geom_point(aes(x=TIMESTAMP, y=H))
ggplot(data=srs6_raw) + geom_point(aes(x=TIMESTAMP, y=LE))


srs6_raw$NEE[ srs6_raw$NEE >  40 | srs6_raw$NEE <  -45] <- NA
srs6_raw$H[ srs6_raw$H >  100 | srs6_raw$H <  -100] <- NA
srs6_raw$LE[ srs6_raw$LE > 100 | srs6_raw$LE <  -100] <- NA

# Filter by Quality Flags: https://www.licor.com/env/support/EddyPro/topics/flux-quality-flags.html
unique(srs6_raw$qc_Tau)
unique(srs6_raw$qc_H)
unique(srs6_raw$qc_LE)

srs6_raw$NEE[ srs6_raw$qc_co2_flux == 2] <- NA
srs6_raw$H[ srs6_raw$qc_H == 2] <- NA
srs6_raw$LE[ srs6_raw$qc_LE == 2] <- NA
srs6_raw$Tau[ srs6_raw$qc_Tau == 2] <- NA

# If you have methane you filter filter by rssi_77_mean!

# Create a column to track filtering by conditions:
srs6_raw$filter <- 0 

# Filtering for u* historical and contemporary data:
srs6_raw$u. <- as.numeric(srs6_raw $u.)
srs6_raw$filter[srs6_raw $u. < 0.21] <- 1

# Filter by low signal strength:
srs6_raw$filter[srs6_raw$co2_signal_strength_7500_mean < 25] <- 1

# Apply filter to the Data
srs6_raw$NEE[srs6_raw $filter ==1] <- NA

# Plot data:
ggplot(data=srs6_raw) + geom_point( aes( x=TIMESTAMP, y=NEE))

# Subset data: https://www.licor.com/env/support/EddyPro/topics/output-files-full-output.html

names(srs6_raw)

af.flux.sub <- srs6_raw[,c('co2_mixing_ratio', 'X.z.d..L', 'air_pressure', 
            'Tau', 'co2_flux', 'co2_strg', 
            'h2o_mixing_ratio', 'H', 'H_strg', 'LE', 'LE_strg')]

# Rename Columns: https://ameriflux.lbl.gov/data/aboutdata/data-variables/

# Unit conversions:

af.flux.sub$air_pressure_kpa = af.flux.sub$air_pressure*0.001

# You need to finish this:
AF.names.flux <- c(  'CO2_MIXING_RATIO_1_1_1'= 'co2_mixing_ratio', 
                    "ZL_1_1_1" ='X.z.d..L', 
                    "PA_1_1_1" = 'air_pressure_kpa',
                    'TAU_1_1_1' = 'Tau',
                    'FC_1_1_1' = 'co2_flux', 
                    'SC_1_1_1' = 'co2_strg', 
                    'H2O_MIXING_RATIO_1_1_1' ='h2o_mixing_ratio', 
                    'H_1_1_1' = 'H', 
                    'SH_1_1_1' = 'H_strg', 
                    'LE_1_1_1' = 'LE', 
                    'SLE_1_1_1' = 'LE_strg')

srs6.af.flux <- rename(af.flux.sub, all_of(AF.names.flux)) # rename columns that are in the correct units

# Export the flux file to the datafile: call the file: AF_Flux_SRS6_032018-042018.csv

