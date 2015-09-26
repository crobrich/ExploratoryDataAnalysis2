## Emissions by type from 1999-2008 for Baltimore City, Maryland

## Use setwd first if needed

png(file="plot3.png")
 
library(ggplot2)

## Reading Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## Initialize vectors for plot coordinates
years<-c(1999,2002,2005,2008)
xem<-rep(years,times=4)
yem<-rep(0,times=16)

## Vector of types of emissions
types<-c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD")

##Select data for Baltimore City, Maryland
NEI<-subset(NEI, fips == "24510")

## Loop to build dataframe for ggplot2
for(i in 1:4){
  
  k=(i-1)*4
  
  ##Select data for type
  NEIS<-subset(NEI, type==types[i])
  
  ## Emmissions sums into vector for plot y-coordinates
  NEI99<-subset(NEIS,year==1999,select=Emissions)
  yem[1+k]<-sum(NEI99$Emissions)
  
  NEI02<-subset(NEIS,year==2002,select=Emissions)
  yem[2+k]<-sum(NEI02$Emissions)
  
  NEI05<-subset(NEIS,year==2005,select=Emissions)
  yem[3+k]<-sum(NEI05$Emissions)
  
  NEI08<-subset(NEIS,year==2008,select=Emissions)
  yem[4+k]<-sum(NEI08$Emissions)
  
  
}

## Types for dataframe for ggplot2
tem<-rep("POINT", times=16)
tem[1:4]<-rep("POINT",times=4)
tem[5:8]<-rep("NONPOINT", times=4)
tem[9:12]<-rep("ON-ROAD", times=4)
tem[13:16]<-rep("NON-ROAD", times=4)

## Unit conversion
yem<-yem/1000.0

## Datafrmae for ggplot2
pointdata<-data.frame(xem, yem, tem)

## ggplot2 plotting
g<-ggplot(pointdata, aes(xem,yem))
g+geom_point()+geom_line()+ theme(axis.text.x=element_text(angle=50))+ facet_grid(.~tem)+labs(title="Baltimore City, MD Results",x="Year", y="PM2.5 Emissions (thousands of tons)")
 
 
dev.off()
