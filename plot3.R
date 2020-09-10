
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

data.tf$Sub_metering_1 <- as.numeric(data.tf$Sub_metering_1)
data.tf$Sub_metering_2 <- as.numeric(data.tf$Sub_metering_2)
data.tf$Sub_metering_3 <- as.numeric(data.tf$Sub_metering_3)


data.tf$datetime <- strptime(paste(data.tf$Date,
                           data.tf$Time,
                           sep=" ")
                     ,"%d/%m/%Y %H:%M:%S") 

png("plot3.png",
     width=480,
     height=480)



with (data.tf, {
  plot(datetime, Sub_metering_1,
       main = "",
       type = "l",
       ylab = "Energy sub metering",
       xlab = "",
       col = "black")
  lines(datetime, Sub_metering_2,
       main = "",
       type = "l",
       ylab = "Energy sub metering",
       xlab = "",
       col = "red")
  lines(datetime, Sub_metering_3,
       main = "",
       ylab = "Energy sub metering",
       xlab = "",
       type = "l",
       col = "blue")
  legend("topright",
         lty=1,
         col = c("black", "red", "blue"),
         legend = c("Sub_metering_1",
         "Sub_metering_2",
         "Sub_metering_3"))
})
dev.off()
rm(list=ls())


