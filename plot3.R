## COURSERA - EXPLORATORY DATA - ASSIGNMENT 1 ##
## PLOT 3 ##

plot3 <- function(){
        
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
        
        png(filename = "plot3.png")
        par(mar = c(2, 4, 2, 2))
        plot(data[, 7], type = "l", main = "", xaxt='n', ann = FALSE)
        lines(data[, 8], col = "red")
        lines(data[, 9], col = "blue")
        title(ylab = "Energy sub metering")
        legend("topright", colnames(data[, 7:9]), lty=c(1,1), col = c("black", "red", "blue"))
        dev.off()                                               # CLOSE DEVICE
}