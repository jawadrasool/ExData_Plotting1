# Plot 4

# Download zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.zip")) {
    download.file(url, "household_power_consumption.zip", mode = "wb")
}

# Unzip zip file
if (!file.exists("household_power_consumption.txt")) {
    unzip("household_power_consumption.zip")
}

data <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
                   header = TRUE, stringsAsFactors = FALSE)

dim(data)
# [1] 2075259       9

names(data)
# [1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"              
# [6] "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

# Filter data for the dates 2007-02-01 and 2007-02-02
data_filtered <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]

dim(data_filtered)
# [1] 2880    9

# Convert the Date and Time variables to Date/Time classes
data_filtered$DateTime <- strptime(paste(data_filtered$Date, data_filtered$Time), "%d/%m/%Y %H:%M:%S")
data_filtered$Date <- as.Date(data_filtered$Date, "%d/%m/%Y")

# plotting 

par(mfcol = c(2,2), mar = c(5,4,4,2))

plot(data_filtered$DateTime, data_filtered$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col = "red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.7, bty = "n")

plot(data_filtered$DateTime, data_filtered$Voltage, type = "l", 
     xlab="datetime", ylab="Voltage")

plot(data_filtered$DateTime, data_filtered$Global_reactive_power, type = "l", 
     xlab="datetime", ylab="Global_reactive_power")



# Copy the plot to a PNG file
dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()
