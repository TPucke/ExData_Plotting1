if (!exists("getdata")) {
    stop("Function getdata does not exist.  You must source the file getdata.R")
}

resultingfile <- getdata(download = F)
resultingdata <- load.data(resultingfile)
print("done")
