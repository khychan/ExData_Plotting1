## Code to create "plot4" for Exploratory Data Analysis Assignment 1
## Written by khychan on 18 JUN 2016

## Initialise names
file.name <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
powerDataZip <- "./powerData.zip"

## Check if the data is downloaded and if not, download and unzip the file
if (!file.exists(file.name)) {
        download.file(url,destfile = powerDataZip)
        unzip(powerDataZip)
        file.remove(powerDataZip)
}

## Read the file and make allowance for missing values "?"
DT <- read.table(file.name,header=TRUE,sep=";",na.strings=c("NA","?"))
DT$Date <- as.Date(DT$Date,format="%d/%m/%Y")

## extract information only for the specified dates
subsetDT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]

# for plot 1
subsetDT$Global_active_power <- as.numeric(subsetDT$Global_active_power)

# for plot 2
subsetDT$Voltage <- as.numeric(subsetDT$Voltage)

# for plot 3
subsetDT$Sub_metering_1 <- as.numeric(subsetDT$Sub_metering_1)
subsetDT$Sub_metering_2 <- as.numeric(subsetDT$Sub_metering_2)
subsetDT$Sub_metering_3 <- as.numeric(subsetDT$Sub_metering_3)

# for plot 4
subsetDT$Global_reactive_power <- as.numeric(subsetDT$Global_reactive_power)

## define dateTime for the graphs
dateTime <- paste(subsetDT$Date,subsetDT$Time, sep=" ")
dateTime <- strptime(dateTime,format="%Y-%m-%d %H:%M:%S")

## complete the graphs
png(file="plot4.png",width=480,height=480,units="px")

# make two rows and two columns
par(mfrow=c(2,2))

# plot 1 - global active power
plot(dateTime,subsetDT$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# plot 2 - voltage
plot(dateTime,subsetDT$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# plot 3 - energy sub metering
plot(dateTime,subsetDT$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering", 
     col="black")
lines(dateTime,subsetDT$Sub_metering_2, col="red")
lines(dateTime,subsetDT$Sub_metering_3, col="blue")
legend("topright",lty=1,bty="n",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot 4 - global reactive power
plot(dateTime,subsetDT$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()
