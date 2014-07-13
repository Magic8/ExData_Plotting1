data_file <- function(fileURL, this_file) {
  if(!file.exists(this_file)) {
    download.file(fileURL, destfile=this_file, method="curl")
  }
  this_file
}

read_data <- function() {
  this_file <- data_file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
  connection <- unz(this_file, "household_power_consumption.txt")
  this_data_table <- read.table(connection, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
  this_data_table <- this_data_table[(this_data_table$Date == "1/2/2007") | (this_data_table$Date == "2/2/2007"),]
  this_data_table$DateTime <- strptime(paste(this_data_table$Date, this_data_table$Time), "%d/%m/%Y %H:%M:%S")
  this_data_table
}

make_plot3 <- function() {
  this_table <- read_data()
  png(filename = "plot3.png", width = 480, height = 480, units = "px")
  this_columns = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  plot(this_table$DateTime, this_table$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(this_table$DateTime, this_table$Sub_metering_2, type="l", col="red")
  lines(this_table$DateTime, this_table$Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=this_columns)
  dev.off()
}

make_plot3()