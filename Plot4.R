# Making Plot 4 - DataTime versus Global_active_power, data Time versus Voltage
# DataTime versus Energy sub metering, DataTime versus Global_reactive_power

# Loads and adds the package "data.table"

library("data.table")

# Returns the current directory before the change, invisibly and with 
# the same conventions as getwd.

setwd("C:/Users/Pabricio Marcos/Desktop/Coursera/curso")

# Reads the data GAP (Global active power) from file then subsets data for specified 
# dates
GAP <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
GAP[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
GAP[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02

GAP <- GAP[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1, 2, 3 and 4 

# Plot 1

plot(GAP[, dateTime], GAP[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2

plot(GAP[, dateTime],GAP[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3

plot(GAP[, dateTime], GAP[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(GAP[, dateTime], GAP[, Sub_metering_2], col="red")
lines(GAP[, dateTime], GAP[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4

plot(GAP[, dateTime], GAP[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
