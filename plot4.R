library("data.table")
HouseDT <- read.table("household_power_consumption.txt", head = TRUE, sep = ";", na.strings = "?", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

## formatind Date to date type
HouseDT$Date <- as.Date(HouseDT$Date, "%d/%m/%y")

## filtering data set from 2007-02-01 to 2007-02-02
HouseDT <- subset(HouseDT, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Remove incomplete observations
HouseDT <- HouseDT[complete.cases(HouseDT),]

## combine data and time column
dateTime <- paste(HouseDT$Date, HouseDT$Time)

## remove date and time columns
HouseDt <- HouseDT[, !(names(HouseDT) %in% c("Time", "Date"))]

## add dateTime column
HouseDT <- cbind(dateTime, HouseDT)

## format dateTime column
HouseDT$dateTime <- as.POSIXct(dateTime)




## Plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(t, {
  plot(Global_active_power~dateTime, type ="l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  plot(Voltage~dateTime, type = "l", 
       ylab = "Voltage (volt)", xlab = "")
  plot(Sub_metering_1~dateTime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~dateTime, col = 'Red')
  lines(Sub_metering_3~dateTime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type = "l", 
       ylab="Global Rective Power (kilowatts)", xlab = "")
})

## save to file
dev.copy(png, file="plot4.png", height = 960 , width = 1366)
dev.off()
