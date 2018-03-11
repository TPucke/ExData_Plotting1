require(graphics)
require(grDevices)

if (!exists("getdata")) {
    stop("Function getdata does not exist.  You must source the file getdata.R")
}

resultingfile <- getdata(download = F)
resultingdata <- load.data(resultingfile)

# Do something here
plot(x=resultingdata$DateTime, 
     y=resultingdata$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
     )
