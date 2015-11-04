## Andrew J Austin - ajausti1@gmail.com - 11/4/15
##
## Exploratory Data Analysis Project 1 - Graphing - plot3
##
## Assumes that the dataset to be graphed exists in a file named 'household_power_consumption.txt' located in 
## the immediate parent directory.  This dataset is provided as a link in the project introduction and was
## downloaded from (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) on 11/3/15.
##
## Make a line graph of time on the X and energy sub metering on the Y, using colors 'black' for SM1, 'red' for SM2
## and 'blue' for SM3.
print("Exploratory Data Analysis Graph plot3.R")

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
png(width = 480, height = 480, filename = "plot3.png")
with(dateBasedSubsetDT, plot(posixDate, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dateBasedSubsetDT, lines(posixDate, Sub_metering_2, type="l", col="red"))
with(dateBasedSubsetDT, lines(posixDate, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
print("Graph directed to plot3.png in working directory")