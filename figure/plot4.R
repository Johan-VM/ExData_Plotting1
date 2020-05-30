## Johan Vásquez Mazo
## Universidad Nacional de Colombia - Sede Medellín

#setwd("./figure/")
Sys.setlocale("LC_TIME", "English")
Sys.setenv(TZ = "GMT")

## Zip file download
if (!file.exists("household_power_consumption.txt")) {
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile = "file.zip")
    unzip("file.zip")
}

## Data reading
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# Date conversion
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Subsetting from dates "2007-02-01" and "2007-02-02"
data <- subset(data, (Date >= "2007-02-01") & (Date <= "2007-02-02"))
# Time conversion
DateTime <- paste(data$Date, data$Time)
data$Time <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")

## Plot 4 creation
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
par(mar = c(4, 4, 1, 1))
# Subplot 1
with(data, plot(Time, Global_active_power, main = "", xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
with(data, lines(Time, Global_active_power))
# Subplot 2
with(data, plot(Time, Voltage, main = "", xlab = "datetime", ylab = "Voltage", type = "n"))
with(data, lines(Time, Voltage))
# Subplot 3
with(data, plot(Time, Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering", type = "n"))
with(data, lines(Time, Sub_metering_1, col = "black"))
with(data, lines(Time, Sub_metering_2, col = "red"))
with(data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1, box.lty = 0, inset = 0.01)
# Subplot 4
with(data, plot(Time, Global_reactive_power, main = "", xlab = "datetime", ylab = "Global_reactive_power", type = "n"))
with(data, lines(Time, Global_reactive_power))
# PNG export
# dev.copy(png, filename = "plot4.png", width = 480, height = 480)
dev.off()
