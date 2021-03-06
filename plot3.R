#install required packages
if( !("data.table" %in% installed.packages()) ){install.packages("data.table")}
library(data.table)

#read-in data or download, unzip, and read-in data
if( file.exists("household_power_consumption.txt") ){
  hpc <-  fread("household_power_consumption.txt")
} else {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "raw_data.zip")
  unzip("raw_data.zip")
  hpc <-  fread("household_power_consumption.txt")
}

#format data
hpc[, Global_active_power := as.numeric(Global_active_power)]
hpc[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

#subset data
hpc <- hpc[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03"),]

#Plot 3
png("plot3.png", width=480, height=480)
plot(hpc[, DateTime], hpc[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(hpc[, DateTime], hpc[, Sub_metering_2],col="red")
lines(hpc[, DateTime], hpc[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))
dev.off()
