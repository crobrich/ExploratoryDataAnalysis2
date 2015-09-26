## Compare Motor Vehicle PM2.5 Emissions for Baltimore and Los Angeles County

## Use setwd first if needed
  
png(file="plot6.png")

## Reading Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initialize vectors for plot coordinates 
xem<-c(1999,2002,2005,2008)
yem<-c(0,0,0,0)


## SCC$EI.Sector for Motor Vehicles (via table function) 

## Mobile - Aircraft 
## Mobile - Commercial Marine Vessels 
## Mobile - Locomotives 
## Mobile - Non-Road Equipment - Diesel  
## Mobile - Non-Road Equipment - Gasoline 
## Mobile - Non-Road Equipment - Other 
## Mobile - On-Road Diesel Heavy Duty Vehicles  
## Mobile - On-Road Diesel Light Duty Vehicles  
## Mobile - On-Road Gasoline Heavy Duty Vehicles 
## Mobile - On-Road Gasoline Light Duty Vehicles

SCCMotor<-subset(SCC, EI.Sector=="Mobile - Aircraft"| EI.Sector=="Mobile - Commercial Marine Vessels"| EI.Sector=="Mobile - Locomotives"| EI.Sector=="Mobile - Non-Road Equipment - Diesel"|EI.Sector=="Mobile - Non-Road Equipment - Gasoline"| EI.Sector=="Mobile - Non-Road Equipment - Other"| EI.Sector=="Mobile - On-Road Diesel Heavy Duty Vehicles"| EI.Sector=="Mobile - On-Road Diesel Light Duty Vehicles"| EI.Sector=="Mobile - On-Road Gasoline Heavy Duty Vehicles"|EI.Sector=="Mobile - On-Road Gasoline Light Duty Vehicles",select=SCC)
index<-which(NEI$SCC %in% SCCMotor[,1])
NEI<-NEI[index,]

##Select data for Baltimore City and Los Angeles County
NEIB<-subset(NEI, fips == "24510")
NEIL<-subset(NEI, fips == "06037")

## Baltimore Emissions sums into vector for plot y-coordinates
NEI99<-subset(NEIB,year==1999,select=Emissions)
yem[1]<-sum(NEI99$Emissions)

NEI02<-subset(NEIB,year==2002,select=Emissions)
yem[2]<-sum(NEI02$Emissions)

NEI05<-subset(NEIB,year==2005,select=Emissions)
yem[3]<-sum(NEI05$Emissions)

NEI08<-subset(NEIB,year==2008,select=Emissions)
yem[4]<-sum(NEI08$Emissions)

## Unit conversion
yem<-yem/1000.0

## Set up side by side plots for the two localities
par(mfrow=c(1,2))


## Plot in base system
plot(xem,yem, type="b", col= "red", xaxt="n", xlab="Year", ylab="Motor Vehicle PM2.5 Emissions (thousands of tons)")
title(main="Baltimore City, MD")
axis(1,at=xem)

## Los Angeles Emissions sums into vector for plot y-coordinates
NEI99<-subset(NEIL,year==1999,select=Emissions)
yem[1]<-sum(NEI99$Emissions)

NEI02<-subset(NEIL,year==2002,select=Emissions)
yem[2]<-sum(NEI02$Emissions)

NEI05<-subset(NEIL,year==2005,select=Emissions)
yem[3]<-sum(NEI05$Emissions)

NEI08<-subset(NEIL,year==2008,select=Emissions)
yem[4]<-sum(NEI08$Emissions)

## Unit conversion
yem<-yem/1000.0

## Plot in base system
plot(xem,yem, type="b", col= "red", xaxt="n", xlab="Year", ylab="Motor Vehicle PM2.5 Emissions (thousands of tons)")
title(main="Los Angeles County, California")
axis(1,at=xem)


dev.off() 
 

