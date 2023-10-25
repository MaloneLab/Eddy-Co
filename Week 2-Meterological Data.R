# Welcome to week 2: 

# install.packages("googledrive")
library(googledrive)

temp <- tempfile(fileext = ".zip", tmpdir =getwd())
dl <- drive_download(
  as_id("1VLqqz3l8qNTdJFwVwVLjZaa9M4cdx7U6WhvNCLQKStg"), path = temp, overwrite = TRUE)

out <- unzip(temp, exdir = tempdir())

met.data <- read.csv(out[2], sep = ";")
