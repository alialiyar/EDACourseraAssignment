library("data.table")
HouseDT <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

## formatind Date to date type
HouseDT$Date <- as.Date(HouseDT$Date, "%d/%m/%y")
