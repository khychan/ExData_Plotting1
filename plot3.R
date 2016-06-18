# Code to create "plot3" for Exploratory Data Analysis Assignment 1
# Written by khychan on 18 JUN 2016

# Initialise names
file.name <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
powerDataZip <- "./powerData.zip"

# Check if the data is downloaded and if not, download and unzip the file
if (!file.exists(file.name)) {
        download.file(url,destfile = powerDataZip)
        unzip(powerDataZip)
        file.remove(powerDataZip)
}

# Read the file and make allowance for missing values "?"
DT <- read.table(file.name,header=TRUE,sep=";",na.strings=c("NA","?"))
DT$Date <- as.Date(DT$Date,format="%d/%m/%Y")

# extract information only for the specified dates
subsetDT <- DT[DT$Date >= as.Date("2007-02-01") & DT$Date <= as.Date("2007-02-02"),]
subsetDT$Sub_metering_1 <- as.numeric(subsetDT$Sub_metering_1)
subsetDT$Sub_metering_2 <- as.numeric(subsetDT$Sub_metering_2)
subsetDT$Sub_metering_3 <- as.numeric(subsetDT$Sub_metering_3)

# define dateTime for the graphs
dateTime <- paste(subsetDT$Date,subsetDT$Time, sep=" ")
dateTime <- strptime(dateTime,format="%Y-%m-%d %H:%M:%S")

# complete the graph
png(file="plot3.png",width=480,height=480,units="px")
plot(dateTime,subsetDT$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering", 
     col="black")
lines(dateTime,subsetDT$Sub_metering_2, col="red")
lines(dateTime,subsetDT$Sub_metering_3, col="blue")
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
