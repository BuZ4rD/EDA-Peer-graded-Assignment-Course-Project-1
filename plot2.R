
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")){
  if (!file.exists("epc.zip")){
    download.file(url, destfile = "./epc.zip")
  }
  unzip("epc.zip")
}

data <- read.table("household_power_consumption.txt",
              
                  sep=";",
                  stringsAsFactors=FALSE,
                  dec=".")

data.tf <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data.tf$Global_active_power <- as.numeric(data.tf$Global_active_power)

data.tf$datetime <- strptime(paste(data.tf$Date,
                           data.tf$Time,
                           sep=" ")
                     ,"%d/%m/%Y %H:%M:%S") 

png("plot2.png",
     width=480,
     height=480)

plot(data.tf$datetime, data.tf$Global_active_power,
     type = "l",
     col="black",
     main="",
     ylab="Global Active Power (kilowatts)",
     xlab = "")

dev.off()
rm(list=ls())
