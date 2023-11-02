# Week 3 Check Met Files:

srs6.AF <- read.csv('Ameriflux_week2_KEY.csv')

library(dplyr)

all.equal(srs6.AF, srs6.AF[, -2])

# Check Column Names: 
names(srs6.AF )
all.equal(names(srs6.AF ), names(srs6.AF[,-2] ))


# Check Columns: 
all.equal(srs6.AF$RH_1_1_1,srs6.AF$RH_8_1_1 )
