## Andrew J Austin - ajausti1@gmail.com - 11/4/15
##
## Exploratory Data Analysis Project 1 - Graphing - plot4
##
## Assumes that the dataset to be graphed exists in a file named 'household_power_consumption.txt' located in 
## the immediate parent directory.  This dataset is provided as a link in the project introduction and was
## downloaded from (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) on 11/3/15.
##
## Make a quad of line graphs with time on the X and (starting in upper-left and working clockwise): 
##    UL: Global Active Power on the Y (Graph 2)
##    UR: Voltage on the Y, X labeled 'datetime'
##    LL: Energy sub metering on the Y (Graph 3 w/ borderless legend)
##    LR: Global_reactive_power on the Y, X labeled 'datetime'
print("Exploratory Data Analysis Graph plot4.R")

## imports
library(data.table)
library(datasets)

## Assume the dataset is one directory up from the working directory and that
## the file is named `household_power_consumption.txt` - is a `;` separated file,
## and uses `?` for missing values.

## TODO: Read in the file, but only for the dates we are interested in - 2007-02-01 and 2007-02-02
## For now, read in the whole file like a brute
fileName <- "../household_power_consumption.txt"
fullDT <- fread(input = fileName, header = T, sep = ";", na.strings = "?")
print(paste("Load of", fileName, "complete"))

## Convert date/time values using POSIXct
fullDT[,posixDate:= as.POSIXct(paste(fullDT$Date, fullDT$Time), format="%d/%m/%Y %H:%M:%S")]
print("Date/Time converted and posixDate column added to fullDT object")

## Subset out the dates we are interested in
dateBasedSubsetDT <- fullDT[fullDT$posixDate > as.POSIXct("2007-02-01") & fullDT$posixDate < as.POSIXct("2007-02-03"), ]
print("Subset of fullDT taken for dates 2007-02-01 and 2007-02-02 placed in dateBasedSubsetDT")

######
## Make a histogram of Global_active_power on the X to Frequency on the Y as a .png file with dimensions
## of 480 x 480
png(width = 480, height = 480, filename = "plot4.png")

par(mfrow = c(2, 2))

## UL Quadrant - Graph 2
plot(x = dateBasedSubsetDT$posixDate, y = dateBasedSubsetDT$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## UR Quadrant - Voltage x datetime
plot(x = dateBasedSubsetDT$posixDate, y = dateBasedSubsetDT$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## LL Quadrant - Graph 3
with(dateBasedSubsetDT, plot(posixDate, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dateBasedSubsetDT, lines(posixDate, Sub_metering_2, type="l", col="red"))
with(dateBasedSubsetDT, lines(posixDate, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, bty = "n", cex = .8, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## LR Quadrant - Global_active_power x datetime
plot(x = dateBasedSubsetDT$posixDate, y = dateBasedSubsetDT$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
print("Graph directed to plot4.png in working directory")