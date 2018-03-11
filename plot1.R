require(graphics)
require(grDevices)

getdata <- function(unzip_path = "./ExploratoryDataAnalysis/CourseProject1", download=TRUE) {
    if (download) {
        temp <- tempfile()
        dataurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url = dataurl, destfile =  temp, mode = "wb")
        unzip(zipfile = temp, exdir = unzip_path)
        unlink(temp)
    }
    # return the path of the raw data file
    paste0(unzip_path, .Platform$file.sep, "household_power_consumption.txt")
}

load.data <- function(filepath) {
    if (!file.exists(filepath)) {
        print("In load.data() file not found")
        return
    }
    
    con <- file(filepath, "r")
    df <- data.frame()
    
    line <- readLines(con, n = 1)
    fieldnames <- strsplit(line, ";")[[1]]
    
    while ( TRUE ) {
        line <- readLines(con, n = 1)
        if (line == "" | grepl("3/2/2007", line)) {
            break
        }
        
        if ( grepl("1/2/2007", line) | 
             grepl("2/2/2007", line)) {
            fieldvalues <- strsplit(line, ";")[[1]]
            newrow <- data.frame(DateTime = strptime(paste(fieldvalues[1], fieldvalues[2]), format = "%d/%m/%Y %H:%M:%S"),
                                 Global_active_power = as.numeric(fieldvalues[3]),
                                 Global_reactive_power = as.numeric(fieldvalues[4]),
                                 Voltage = as.numeric(fieldvalues[5]),
                                 Global_intensity = as.numeric(fieldvalues[6]),
                                 Sub_metering_1 = as.numeric(fieldvalues[7]),
                                 Sub_metering_2 = as.numeric(fieldvalues[8]),
                                 Sub_metering_3 = as.numeric(fieldvalues[9])
            )
            df <- rbind(df, newrow)
        }
    }
    close(con)
    
    df
}

# start program logic
resultingfile <- getdata(download = F)
resultingdata <- load.data(resultingfile)

outputfilename <- getSrcFilename(getdata)
outputfilename <- paste0(strsplit(outputfilename, "\\.")[[1]][1], ".png")

png(filename = outputfilename, width = 480, height = 480)

hist(x = resultingdata$Global_active_power
    ,col = "red"
    ,main = "Global Active Power"
    ,xlab = "Global Active Power (kilowatts)"
    )

dev.off()
