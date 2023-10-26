# Welcome to week 2: 

rm(list=ls()) #clears your environment:

# Download data and add to your Eddy-Co Folder: 
# https://drive.google.com/file/d/1z76t6OXR9ca6D6e1GKY35SyCEApHyXCX/view?usp=drive_link


# Import the data:
load(file= "Week2_EC_Training.RDATA")

###### CHECK and FILTER DATA ######
# Look at Data file:
summary(srs6.met)

# Atmospheric Data:
ggplot(data = srs6.met) + geom_point( aes( x=TIMESTAMP, y = RH1_Avg))
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

## Values out of range

## EXAMPLE fixing sensor failure or drift:

ggplot(data=srs6.met[which(srs6.met$TIMESTAMP < as.POSIXct("2018-03-20 13:30:00 EST", tz="EST", 
                                                           format="%Y-%m-%d %H:%M:%S") ),] ) + geom_point(aes(x=TIMESTAMP, y=Tair8_Avg ))

srs6.met$Tair8_Avg[srs6.met$TIMESTAMP < as.POSIXct("2018-03-20 12:30:00 EST", tz="EST", 
                                                   format="%Y-%m-%d %H:%M:%S")] <- NA

ggplot(data=srs6.met) + geom_point(aes(x=TIMESTAMP, y=Tair8_Avg ))

# EXAMPLE fixing issues with values out of range:

ggplot(data=srs6.met) + geom_point(aes(x=TIMESTAMP, y=LUpCo_Avg ))

srs6.met$LUpCo_Avg[ srs6.met$LUpCo_Avg > 1000] <- NA

# Filter all ISSUES in the data:





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


srs6$TIMESTAMP <- format( srs6$TS, "%Y%m%d%H%M%S") #
srs6$PA <- srs6$BP_mbar_Avg*0.1
srs6$Tair1_Avg 


srs6$Rain_1_Tot

# You need to finish this:
AF.names <- c(RH1_Avg = 'RH_1_1_1', RH2_Avg = 'RH_8_1_1',
              Tair1_Avg ='TA_8_1_1',
              Tair2_Avg ='TA_7_1_1',
              Tair3_Avg ='TA_6_1_1',
              Tair4_Avg ='TA_5_1_1',
              Tair5_Avg ='TA_4_1_1',
              Tair6_Avg ='TA_3_1_1',
              Tair7_Avg ='TA_2_1_1',
              Tair8_Avg ='TA_1_1_1',
              
              Rain_1_Tot = 'P_RAIN_8_1_1',
              Rain_2_Tot = 'P_RAIN_1_1_1',
              
              
              )

rename(srs6, all_of(AF.names)) # rename columns that are in the correct units


#Subset all variable that go to AmeriFlux. Add all vars needed here

srs6.AF <- srs6[c('TIMESTAMP', 'PA' )]

# export the file

write.csv( srs6.AF, 'Ameriflux_week2.csv')



