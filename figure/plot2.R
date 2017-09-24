# Download the data in R & check the size of the data

URL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(URL,"epwrcons.zip")

unzip("epwrcons.zip")

memo<-object.size(read.table("household_power_consumption.txt"))

format(memo,units="Mb")

##At this point, it should come to no surprise that the data is pretty robust, kinda take long to run in R.
##Thus, loading the entire data in R would be more than tedious, as re-running the code will slow down the entire process (at least in my case).
##Therefore, loading only a portion of the data sounds like a good option to me.

# Load and prepare the data in R

library(lubridate)

##The data covers the range of nearly 47 months, among with there are only irregularity: the first and last day.
##The first day consists of only 396 data points, while the last day in the sample consists of 1263 data points. 
##The rest of the data (1440 days observed) is pretty regular, with 1440 data point (which is nothing more than the number of minutes in 1 day, aka 60*24). 

## Calculate the number of skip line

start.date<-as.Date("17-12-2006",format="%d-%m-%Y")
end.date<-as.Date("01-02-2007",format="%d-%m-%Y")

## This is how the number of skip lines was calculated (the last +1 is for the header)
as.numeric(end.date-start.date)*1440+396+1


columname<-read.table("household_power_consumption.txt",nrow=1,sep = ";")
data<-read.table("household_power_consumption.txt",sep=";",header=FALSE,skip=66637,nrow=2880,stringsAsFactors = FALSE,na.strings = "?")

columname<-as.list(columname)

colnames(data)<-unlist(columname)

data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-strptime(paste(data$Date,data$Time),format = "%Y-%m-%d %H:%M:%S")

# Contruct the required plots

## Plot 2

plot(data$Time,data$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
