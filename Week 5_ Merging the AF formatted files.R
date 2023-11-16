library(dplyr)

# Import your CSV files: import your met file af.met and your flux file af.flux
# HINT: read.csv()

# You will need a column that is the same in both files to merge the documents (TIMESTAMP):
# The two columns must be formatted the same. 

# Example:
af.flux$TIMESTAMP <- as.POSIXct(af.flux$TIMESTAMP, tz = "EST", format="%Y-%m-%d %H:%M:%S")
af.met$TIMESTAMP <- as.POSIXct(af.met$TIMESTAMP, tz = "EST", format="%Y-%m-%d %H:%M:%S")

# Merge the two data frames. Check to see if you have the correct number of rows.

af.total <- af.flux %>% left_join( af.met, by= "TIMESTAMPS")

# Revisit AF website to ensure your naming conventions and units are correct. Make any changes now:

# Export your file as a .csv:
# HINT: write.csv()