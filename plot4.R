## PM2.5 emissions from coal combustion for the USA for 1999-2008

## Use setwd first if needed
   
png(file="plot4.png")

## Reading Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Initialize vectors for plot coordinates 
xem<-c(1999,2002,2005,2008)
yem<-c(0,0,0,0)

## SCC$EI.Sector for Coal COmbustion (via table function)
## Fuel Comb - Comm/Institutional - Coal
## Fuel Comb - Electric Generation - Coal
## Fuel Comb - Industrial Boilers, ICEs - Coal


SCCcoal<-subset(SCC,EI.Sector== "Fuel Comb - Comm/Institutional - Coal"|EI.Sector=="Fuel Comb - Electric Generation - Coal"|EI.Sector=="Fuel Comb - Industrial Boilers, ICEs - Coal", select=SCC)
index<-which(NEI$SCC %in% SCCcoal[,1])
NEI<-NEI[index,]

## Emmissions sums into vector for plot y-coordinates
NEI99<-subset(NEI,year==1999,select=Emissions)
yem[1]<-sum(NEI99$Emissions)

NEI02<-subset(NEI,year==2002,select=Emissions)
yem[2]<-sum(NEI02$Emissions)

NEI05<-subset(NEI,year==2005,select=Emissions)
yem[3]<-sum(NEI05$Emissions)

NEI08<-subset(NEI,year==2008,select=Emissions)
yem[4]<-sum(NEI08$Emissions)

## Unit conversion
yem<-yem/1000.0

## Plot in base system
plot(xem,yem, type="b", col= "red", xaxt="n", xlab="Year", ylab="Coal Combustion PM2.5 Emissions (thousands of tons)")
title(main="Coal Combustion PM2.5 Emissions in USA in Selected Years")
axis(1,at=xem)

dev.off()






