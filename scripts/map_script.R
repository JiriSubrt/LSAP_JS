# Cities Map

# Libraries
library(ggplot2)
library(dplyr)
install.packages("ggrepel")
library(ggrepel)
library(maps)

Scotland <- map_data("world") %>% filter(subregion=="Scotland")

cities_scot <- world.cities %>% filter(lat > "55" & country.etc=="UK")

my_cities <- c("Edinburgh", "Perth", "Glasgow", "Falkirk", "Aberdeen", "Dundee")

my_cities_scot <- cities_scot %>% filter(name %in% my_cities)

my_cities_scot <- my_cities_scot %>% mutate(pop=pop/1000000) 

mybreaks <- c(0.02, 0.04, 0.08, 0.2, 0.5, 0.7)

library(viridis)

my_cities_scot %>%
  arrange(desc(pop)) %>% 
  mutate( name=factor(name, unique(name))) %>% 
  ggplot() +
  geom_polygon(data = UK, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( aes(x=long, y=lat, color=pop), alpha=0.9) +
  geom_text_repel( data=my_cities_scot %>% arrange(pop), aes(x=long, y=lat, label=name), size=5) +
  scale_size_continuous(range=c(1,12)) +
  scale_color_viridis(trans="log", name="Population (in M)", breaks=mybreaks) +
  ggtitle("Scottish cities used in the study") +
  theme_void() + ylim(50,59) + coord_map() +
  theme(
    legend.position = c(0.85, 0.8),
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA), 
    panel.background = element_rect(fill = "#f5f5f2", color = NA), 
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    plot.title = element_text(size= 16, hjust=0.1, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
  )


