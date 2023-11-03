#Week 2 Ket

library(gtools)
library(xts)
library(dplyr)
library(ggplot2)

rm(list=ls()) #clears your environment:

# Download data and add to your Eddy-Co Folder: 
# https://drive.google.com/file/d/1z76t6OXR9ca6D6e1GKY35SyCEApHyXCX/view?usp=drive_link


# Import the data:
load(file= "Week2_EC_Training.RDATA")

###### CHECK and FILTER DATA ######
# Look at Data file:
summary(srs6.met)

# Atmospheric Data:
ggplot(data = srs6.met ) + geom_point( aes( x=TIMESTAMP, y = RH1_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = RH2_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = BP_mbar_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair1_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair2_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair3_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair4_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair5_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair6_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair7_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Tair8_Avg))


## Soil Data:
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST1_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST2_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST3_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST4_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST5_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST6_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST7_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = ST8_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = SH1_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = SH2_Avg))

# PRECIPITATION:
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Rain_1_Tot))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Rain_2_Tot))

# RADIATION:
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = SUp_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = SDn_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = LUp_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = LDn_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = RsNet_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = RlNet_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Albedo_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = UpTot_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = DnTot_Avg ))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = Rnet_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = LUpCo_Avg ))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = LDnCo_Avg))
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = PAR_Den1_Avg))

##### NOTES (List of columns with issues to fix)#####

# Filter all ISSUES in the data:
sd <-as.POSIXct("2018-03-15 00:00:00 EST", tz="EST", format="%Y-%m-%d %H:%M:%S")
ed <-as.POSIXct("2018-03-21 00:00:00 EST", tz="EST", format="%Y-%m-%d %H:%M:%S")

srs6.met$RH1_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed ] <- NA
srs6.met$RH2_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$BP_mbar_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair1_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair2_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair3_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair4_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair5_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair6_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair7_Avg[srs6.met$TIMESTAMP >= sd & srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$Tair8_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST1_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST2_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST3_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST4_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST5_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST6_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST7_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$ST8_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$SH1_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$SH2_Avg[srs6.met$TIMESTAMP <= ed] <- NA

srs6.met$SDn_Avg[ srs6.met$SDn_Avg < -100] <- NA
srs6.met$LUp_Avg[ srs6.met$LUp_Avg >= 0] <- NA
srs6.met$LDn_Avg[ srs6.met$LDn_Avg >= 10] <- NA
srs6.met$RlNet_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$LUpCo_Avg[srs6.met$TIMESTAMP <= ed] <- NA
srs6.met$LDnCo_Avg[srs6.met$TIMESTAMP <= ed] <- NA



###### FINAL FORMATING #########

# Convert minute data into 30 minute averages:
srs6.met$TS <- align.time(srs6.met$TIMESTAMP, n=1800) # Rounds time to the nearest half-hour
srs6 <- aggregate(srs6.met, by = list(as.character(srs6.met$TS)), FUN="mean", na.rm=T) # aggrgates data to the halfhour
srs6$TIMESTAMP <- srs6$Group.1 <- NULL
ts <- data.frame(TS =seq.POSIXt(as.POSIXct("2018-01-01 00:00:00 EST", tz="EST"), as.POSIXct("2018-04-30 23:30:00 EST", tz="EST"), units = "sec", by = 1800))

srs6 <- merge( ts, srs6, all.x=T, by="TS"); rm(ts) # Merge the TS file with the met file

# Check the data:
ggplot(data = srs6) + geom_point( aes( x=TS, y = RH1_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = RH2_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = BP_mbar_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair1_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair2_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair3_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair4_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair5_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair6_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair7_Avg))
ggplot(data = srs6) + geom_point( aes( x=TS, y = Tair8_Avg))

# Format for AmeriFlux:  https://ameriflux.lbl.gov/data/aboutdata/data-variables/
# https://docs.google.com/document/d/1psFQZUl67hOF-xVbWkDBJRPh2HhwNTJfMcRSkk2C43k/edit?usp=sharing

srs6$TIMESTAMP <- format( srs6$TS, "%Y%m%d%H%M%S") #
srs6$PA <- srs6$BP_mbar_Avg*0.1

# Soil heatflux in mV
srs6$G_1_8_1 = srs6$SH1_Avg*0.001
srs6$G_2_8_1 = srs6$SH2_Avg*0.001

# You need to finish this:
AF.names <- c('PA_1_1_1' = 'PA',#Atmosphere
              'RH_1_1_1' ='RH1_Avg', 
              'RH_1_8_1' ='RH2_Avg',
              'TA_1_8_1'='Tair1_Avg',
              'TA_1_7_1'='Tair2_Avg',
              'TA_1_6_1'= 'Tair3_Avg',
              'TA_1_5_1'='Tair4_Avg',
              'TA_1_4_1' ='Tair5_Avg',
              'TA_1_3_1'='Tair6_Avg',
              'TA_1_2_1' = 'Tair7_Avg',
              'TA_1_1_1'= 'Tair8_Avg',
              
              # Precipitation
              'P_RAIN_1_8_1'= 'Rain_1_Tot',
              'P_RAIN_1_1_1' = 'Rain_2_Tot',
              
              # Soil Heat flux
              'G_1_8_1'='G_1_8_1',
              "G_1_8_1" = 'G_1_8_1',
              
              # Soil Temperature
              'TS_1_8_1'= 'ST1_Avg',
              'TS_2_8_1' = 'ST2_Avg',
              'TS_3_8_1'= 'ST3_Avg',
              'TS_4_8_1'='ST4_Avg',
              'TS_5_8_1'= 'ST5_Avg',
              'TS_6_8_1'='ST6_Avg',
              'TS_7_8_1'='ST7_Avg',
              'TS_8_8_1'= 'ST8_Avg',
              
              # Radiation
              'SW_OUT_1_1_1' = 'SUp_Avg',
              'SW_IN_1_1_1'='SDn_Avg',
              #'LW_OUT_1_1_1' = 'LUp_Avg',
              #'LW_IN_1_1_1'='LDn_Avg',
              'LW_OUT_1_1_1' = 'LUpCo_Avg',
              'LW_IN_1_1_1'='LDnCo_Avg',
              'ALB_1_1_1'= 'Albedo_Avg',
              'NETRAD_1_1_1' = 'Rnet_Avg',
              'PPFD_IN_1_1_1'= 'PAR_Den1_Avg')

srs6.af <- rename(srs6, all_of(AF.names)) # rename columns that are in the correct units

names(srs6.af)
#Subset all variable that go to AmeriFlux. Add all vars needed here

AF.cols <- c('TIMESTAMP', 'PA_1_1_1','RH_1_1_1', 'RH_8_1_1',
              'TA_8_1_1','TA_7_1_1', 'TA_6_1_1','TA_5_1_1',
              'TA_4_1_1','TA_3_1_1','TA_2_1_1','TA_1_1_1',
              'P_RAIN_8_1_1','P_RAIN_1_1_1',
              'G_8_1_1', "G_8_2_1",  
              'TS_8_1_1', 'TS_8_2_1','TS_8_3_1',
              'TS_8_4_1','TS_8_5_1','TS_8_6_1',
              'TS_8_7_1','TS_8_8_1',
              'SW_OUT_1_1_1' ,'SW_IN_1_1_1',
              'LW_OUT_1_1_1','LW_IN_1_1_1','ALB_1_1_1',
              'NETRAD_1_1_1','PPFD_IN_1_1_1')

srs6.AF <- srs6.af[,c(AF.cols )]

# export the file
write.csv( srs6.AF, 'Ameriflux_week2_KEY.csv')
