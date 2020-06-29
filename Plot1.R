# Making Plot 1 - Histogram of the Global active power

# Loads and adds the package "data.table"

library("data.table")

# Returns the current directory before the change, invisibly and with 
# the same conventions as getwd.

setwd("C:/Users/Pabricio Marcos/Desktop/Coursera/curso")

# Reads the data GAP (Global active power) from file then subsets data for specified dates

GAP <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents histogram from printing in scientific notation

GAP[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type

GAP[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02

GAP <- GAP[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(GAP[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
