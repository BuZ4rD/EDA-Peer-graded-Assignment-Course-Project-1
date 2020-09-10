
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
data.tf$Voltage <- as.numeric(data.tf$Voltage)
data.tf$Global_reactive_power <- as.numeric(data.tf$Global_reactive_power)


data.tf$datetime <- strptime(paste(data.tf$Date,
                           data.tf$Time,
                           sep=" ")
                     ,"%d/%m/%Y %H:%M:%S") 

png("plot4.png",
      width=480,
      height=480)


par(mfrow = c(2,2), mar = c(4,4,4,4), oma = c(3,0,3,0))
with (data.tf, {
  plot(datetime, Global_active_power,
       type = "l",
       col="black",
       main="",
       ylab="Global Active Power (kilowatts)",
       xlab = "",
       cex=0.2)
})
with (data.tf, {
      plot(datetime, Voltage,
           type = "l",
           col="black",
           main="",
           ylab="Voltage",
           xlab = "datetime") 
})
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
         cex = 0.5,
         bg = "white",
         col = c("black", "red", "blue"),
         legend = c("Sub_metering_1",
                    "Sub_metering_2",
                    "Sub_metering_3"))
})
with (data.tf, {
  plot(datetime, Global_reactive_power,
       type = "l",
       col="black",
       main="",
       ylab="Global Reactive Power",
       xlab = "datetime") 
})

dev.off()
rm(list=ls())


