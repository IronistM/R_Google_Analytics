require(googleVis)
input<- final_dataset
select<- input[which(input$avgPLGroupNum<18),]
Map<- data.frame(select$country, select$avgPageLoadTime)
names(Map)<- c("Country", "avgPageLoadTime")
Geo=gvisGeoMap(Map, locationvar="Country", numvar="avgPageLoadTime",
               options=list(height=350, dataMode='regions'))
plot(Geo)
