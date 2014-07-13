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

make_plot4 <- function() {
  this_table <- read_data()
  png(filename = "plot4.png", width = 480, height = 480, units = "px")
  
  par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
  with(this_table, {
    plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l")
    plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l")
    
    this_columns = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, type="l", col="red")
    lines(DateTime, Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=this_columns, bty="n")
    
    plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")        
  })    
  dev.off()
}

make_plot4()