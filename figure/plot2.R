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

## Plot 2 creation
with(data, plot(Time, Global_active_power, main = "", xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
with(data, lines(Time, Global_active_power))
dev.copy(png, filename = "plot2.png", width = 480, height = 480)
dev.off()
