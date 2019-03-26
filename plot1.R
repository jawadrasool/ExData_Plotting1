# Plot 1

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

# Histogram
hist(data_filtered$Global_active_power, main="Global Active Power", 
     xlab = "Global Active Power (killowatts)", col = "red")

# Copy the plot to a PNG file
dev.copy(png, width = 480, height = 480, file = "plot1.png")

dev.off()
