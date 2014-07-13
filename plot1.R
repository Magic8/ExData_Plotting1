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

make_plot1 <- function() {
  this_table <- read_data()
  png(filename = "plot1.png", width = 480, height = 480, units = "px")
  hist(this_table$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
  dev.off()
}

make_plot1()