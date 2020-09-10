
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")){
  if (!file.exists("epc.zip")){
    download.file(url, destfile = "./epc.zip")
  }
  unzip("epc.zip")
}

data <- read.table("household_power_consumption.txt",
                  header=TRUE,
                  sep=";",
                  stringsAsFactors=FALSE,
                  dec=".")

data.tf <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data.tf$Global_active_power <- as.numeric(data.tf$Global_active_power)

png("plot1.png",
    width=480,
    height=480)

hist(data.tf$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()
rm(list=ls())