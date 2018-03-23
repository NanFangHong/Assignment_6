
library(ggmap)
library(tidyverse)
library(magick)

#### use the geocode function to get the lon and lat.

#L1 <-geocode("Crooklet Beach")
#L2 <-geocode("Summerleaze Beach")
#L3 <-geocode("Bude North Cornwall Cricket Club")
#L4 <-geocode("The Barrel at Bude")

### it would be better to save the lon and lat as a df than read it online everytime. 

df_lon <- c(-4.553962,-4.551349,-4.552814,-4.543023)
df_lat <- c(50.83587,50.83054,50.83347,50.83007)

### Create Labels for location
Location_name <- c("Crooklet Beach","Summerleaze Beach","Bude North Cornwall Cricket Club","The Barrel at Bude" )
#Location_name <- c("Crooklet Beach","Summerleaze Beach","Bude North Cornwall Cricket Club","The Barrel at Bude" )

df4 <- data.frame("lon" = df_lon, "lat" = df_lat)

df_lon_1 <- c(-4.552814,-4.543023)
df_lat_2 <- c(50.83347,50.83007)

df5 <- data.frame("lon" = df_lon_1, "lat" = df_lat_2)




map <-get_googlemap("Bude",markers = df4,path=df5,zoom = 14)
map2<-ggmap(map)+
    geom_point(
    aes(x=lon,y=lat),
    data=df4, size = 4)+
    geom_label(map,aes(label = Location_name),size =3,hjust=-0.1)
plot(map2)

saveRDS(map2,file="route_map.rds")

map3 <-get_map(df4,source="stamen",zoom = 14,maptype = "watercolor")
map4<-ggmap(map3)+
    geom_point(
    aes(x=lon,y=lat),
    data=df4, size = 4)+
    geom_label(map3,aes(label = Location_name ),size =2.5,hjust=-0.1)
plot(map4)

saveRDS(map4,file="water_map.rds")

### Get some picture about this city online 
  
Crooklet_Beach <- image_read('https://www.visitbude.info/wp-content/uploads/2016/07/Crooklets-Beach-Huts-1.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Crooklet Beach", size = 20, color = "white")

print(Crooklet_Beach)

Summerleaze_Beach <- image_read('http://www.visitbude.info/wp-content/uploads/2015/04/Summerleaze-Decking-3.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Summerleaze Beach", size = 20, color = "white")

print(Summerleaze_Beach)

Bude_North_Cornwall_Cricket_Club <- image_read('https://i.pinimg.com/originals/42/21/20/42212062d2dbf181dc1b1eaa160dce53.jpg')%>%
  image_scale("600x") %>%
  image_annotate("Bude North Cornwall Cricket Club", size = 20, color = "white")

print(Bude_North_Cornwall_Cricket_Club)

The_Barrel_at_Bude <- image_read('http://www.micropubassociation.co.uk/wp-content/uploads/barrel-800x800.jpg')%>%
  image_scale("600x") %>%
  image_annotate("The Barrel at Bude", size = 20, color = "white")

print(The_Barrel_at_Bude)

# ---------------------------------------------
# Adding Hotels 
# ---------------------------------------------

# Tommy Jacks Beach Hotel
tommyjacks <- geocode("Crooklets Beach Cafe, Crooklets, Bude EX23 8NF, UK")

# Edgcumbe Hotel
edgecumbe <- geocode("Edgecumbe Hotel, 19 Summerleaze Cres, Bude EX23 8HJ, UK")

#Add these hotels to maps of Bude

#road map
ggmap(map) + 
  geom_point(aes(x=lon,y=lat), data=df4) + 
  geom_point(aes(x = as.numeric(edgecumbe$lon), y = as.numeric(edgecumbe$lat))) +
  geom_text(aes(x = as.numeric(edgecumbe$lon), y = as.numeric(edgecumbe$lat), label = "Edgecumbe Hotel", hjust=1, vjust=1)) +
  geom_point(aes(x = as.numeric(tommyjacks$lon), y = as.numeric(tommyjacks$lat))) +
  geom_text(aes(x = as.numeric(tommyjacks$lon), y = as.numeric(tommyjacks$lat), label = "Tommy Jacks Beach Hotel", hjust=1, vjust=1))


# watercolor map 
ggmap(map3)+
  geom_point(aes(x=lon,y=lat),data=df4)+
  geom_point(aes(x = as.numeric(edgecumbe$lon), y = as.numeric(edgecumbe$lat))) +
  geom_text(aes(x = as.numeric(edgecumbe$lon), y = as.numeric(edgecumbe$lat), label = "Edgecumbe Hotel", hjust=1, vjust=1)) +
  geom_point(aes(x = as.numeric(tommyjacks$lon), y = as.numeric(tommyjacks$lat))) +
  geom_text(aes(x = as.numeric(tommyjacks$lon), y = as.numeric(tommyjacks$lat), label = "Tommy Jacks Beach Hotel", hjust=1, vjust=1))

