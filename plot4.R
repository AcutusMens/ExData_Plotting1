## COURSERA - EXPLORATORY DATA - ASSIGNMENT 1 ##
## PLOT 4 ##

plot4 <- function(){
        
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        ## DO NOT DOWNLOAD FILE IF IT EXISTS ALREADY ##
        
        if (!file.exists("tempfile.zip")) { 
                file <- download.file(url, "tempfile.zip") 
                unzip ("tempfile.zip")
        }
        
        ## READ FIRST FEW ROWS TO DETERMINE CLASS OF EVERY COLUMN ##
        ## THEN TELL THE READ FUNCTION CLASS OF EVERY COLUMN TO EXECUTE IT FASTER ##
        
        tab2rows <- read.table("household_power_consumption.txt", 
                               header = TRUE, nrows = 2)
        classes <- sapply(tab2rows, class)
        rm(tab2rows)
        all.data <- read.table("household_power_consumption.txt", 
                               header = TRUE, sep = ";", na.strings = "?", 
                               colClasses = classes)
        all.data$Date <- as.Date(all.data$Date, "%d/%m/%Y")     # CONVERT TO DATE
        
        
        data <- all.data[all.data$Date == "2007-02-01" | 
                                 all.data$Date == "2007-02-02", ]
        rm(all.data)                                            # FREE UP MEMORY
        
        png(filename = "plot4.png")
        par(mar = c(4, 4, 2, 2))
        par(mfcol = c(2,2))
        plot(data[, 3], type = "l", main = "", ylab = "Global Active Power (kilowatts)", xaxt='n', ann = FALSE)
        axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu","Fri","Sat"))
        title(ylab = "Global Active Power")
        plot(data[, 7], type = "l", main = "", xaxt='n', ann = FALSE)
        lines(data[, 8], col = "red")
        lines(data[, 9], col = "blue")
        title(ylab = "Energy sub metering")
        axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu","Fri","Sat"))
        legend("topright", colnames(data[, 7:9]), lty=c(1,1), col = c("black", "red", "blue"), 
               bty = 'n', cex = 0.7)
        plot(data[, 5], type = "l", main = "", xaxt='n', ann = FALSE)
        title(xlab = "datetime")
        axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu","Fri","Sat"))
        title(ylab = "Voltage")
        plot(data[, 4], type = "l", main = "", xaxt='n', ann = FALSE)
        title(xlab = "datetime")
        axis(side = 1, at = c(1, 1440, 2880), labels = c("Thu","Fri","Sat"))
        title(ylab = "Global_reactive_power")
        dev.off()                                               # CLOSE DEVICE
}