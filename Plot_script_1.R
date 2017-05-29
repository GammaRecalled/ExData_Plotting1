
# Grabs the data
File_url_from_coursera <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File_name <- "power_data.txt"
download.file(File_url_from_coursera, File_name)
unzip(File_name)

#This reads in each of the needed documents.
power_info <- read.table("household_poweR_consumption.txt", sep = ";", header = TRUE, dec=".")

power_info$Date <- as.Date(as.character(power_info[,1]), format= "%d/%m/%Y") # Reformats Date
power_info$Date_Time <- as.POSIXct(paste(power_info$Date, power_info$Time), format="%Y-%m-%d %H:%M:%S") # Adds Date and Time combined column

# Removes "?" and replaces them with NA for easier management 
power_info$Global_active_power[power_info$Global_active_power== "?" ] <- NA
power_info$Global_reactive_power[power_info$Global_reactive_power== "?" ] <- NA
power_info$Voltage[power_info$Voltage== "?" ] <- NA
power_info$Global_intensity[power_info$Global_intensity== "?" ] <- NA
power_info$Sub_metering_1[power_info$Sub_metering_1== "?" ] <- NA
power_info$Sub_metering_2[power_info$Sub_metering_2== "?" ] <- NA
power_info$Sub_metering_3[power_info$Sub_metering_3== "?" ] <- NA

#Selects only the asked for data.
power_info_subset <- subset(power_info, power_info$Date == as.Date("2007-02-02") | power_info$Date == as.Date("2007-02-01"))

#Generates Plot1
globalActivePower <- as.numeric(power_info_subset$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

#Generates Plot2
globalActivePower <- as.numeric(power_info$Global_active_power)
globalReactivePower <- as.numeric(power_info$Global_reactive_power)


png("plot2.png", width=480, height=480)
plot(power_info$Date_Time, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#Generates Plot Three

M_sub1 <- as.numeric(power_info_subset$Sub_metering_1)
M_sub2 <- as.numeric(power_info_subset$Sub_metering_2)
M_sub3 <- as.numeric(power_info_subset$Sub_metering_3)


png("plot3.png", width=480, height=480)
plot(power_info_subset$Date_Time, M_sub1, type="l", ylab="Energy Submetering", xlab="")
lines(power_info_subset$Date_Time, M_sub2, type="l", col="red")
lines(power_info_subset$Date_Time, M_sub3, type="l", col="blue")
legend("topright", c("Sub_m_1", "Sub_m_2", "Sub_m_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

#
globalActivePower <- as.numeric(power_info_subset$Global_active_power)
globalReactivePower <- as.numeric(power_info_subset$Global_reactive_power)
voltage <- as.numeric(power_info_subset$Voltage)

# Generates plot Four 
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 


plot(power_info_subset$Date_Time, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(power_info_subset$Date_Time, voltage, type="l", xlab="datetime", ylab="Voltage")
plot(power_info_subset$Date_Time, M_sub1, type="l", ylab="Energy Submetering", xlab="")

lines(power_info_subset$Date_Time, M_sub2, type="l", col="red")
lines(power_info_subset$Date_Time, M_sub3, type="l", col="blue")
legend("topright", c("Sub_m_1", "Sub_m_2", "Sub_m_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(power_info_subset$Date_Time, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()


 

