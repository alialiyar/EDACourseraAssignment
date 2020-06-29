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




## Plot 2
plot(HouseDT$Global_active_power ~ t$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") 
dev.copy(png, "plot2.png", width = 1344, height = 960)
dev.off()

