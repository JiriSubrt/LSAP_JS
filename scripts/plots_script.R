# plots
library(ggplot2)
library(dplyr)
library(scales)
library(gridExtra)

#loading data
NOx_change<-c(100,100,100,100,100,100)
nox<-c(98.05,98.48,100.09,97.66,95.86,97.17)
group<-c("EDI", "DUN", "ABE", "PER", "FAL", "GLA")
a<-data.frame(NOx_change,nox,group)

NO2_change<-c(100,100,100,100,100,100)
no2 <- c(98.98,99.23,99.98,98.52,97.67,98.45)
group<-c("EDI", "DUN", "ABE", "PER", "FAL", "GLA")
b <- data.frame(NO2_change,no2,group)

PM10_change <- c(100,100,100,100,100,100)
PM10 <- c(97.51,98.15,98.92,96.94,97.19,97.11)
group <- c("EDI", "DUN", "ABE", "PER", "FAL", "GLA")
c <- data.frame(PM10_change,PM10,group)

#plots
no2_plot <-  ggplot(b) + geom_segment(aes(x="",xend=".",y=NO2_change,yend=no2, colour=group), arrow = arrow(length = unit(0.1,"cm")), size=.75)+
  geom_text(label="NO2 %Change", x=0,     y=1)+
  scale_color_discrete(name = "Cities") +
  ylim(95.86, 100.1) +
  theme(text = element_text(size = 15))+
  #  Labelling as desired
  labs(
    xlab("y") +
    theme(legend.position = "none")  
  )

nox_plot <- ggplot(a) + geom_segment(aes(x="",xend=".",y=NOx_change,yend=nox, colour=group), arrow = arrow(length = unit(0.1,"cm")), size=.75)+
  geom_text(label="NOx %Change", x=0,     y=1)+
  scale_color_discrete(name = "Cities") +
  ylim(95.86, 100.1) +
  theme(text = element_text(size = 15))+
  #  Labelling as desired
  labs(
    xlab("y") +
      theme(axis.text=element_blank())
  )


PM10_plot <- ggplot(c) + geom_segment(aes(x="",xend=".",y=PM10_change,yend=PM10, colour=group),arrow = arrow(length = unit(0.1,"cm")), size=.75)+
  geom_text(label="PM10_Change", x=0,     y=1)+
  scale_color_discrete(name = "Cities") +
  ylim(95.86, 100.1) +
  theme(text = element_text(size = 15))+
  #  Labelling as desired
  labs(
    xlab("y") +
      theme(axis.text=element_blank())
  )


# grid
grid.arrange(nox_plot, no2_plot, PM10_plot, ncol = 3)

(panel <- grid.arrange(
  nox_plot + guides(col = FALSE) + ggtitle("(a)") + ylab("NOx %Δ") + xlab("Before                       After") +   # adding labels to the different plots
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")),
  
  no2_plot + guides(col = FALSE) + ggtitle("(b)") + ylab("NO2 %Δ") + xlab("Before                       After") +
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")),
  
  PM10_plot + ggtitle("(c)") + ylab("PM10 %Δ") + xlab("Before                       After") +
    theme(plot.margin = unit(c(0.2, 0.2, 0.2, 0.2), units = , "cm")) +
    theme(legend.text = element_text(size = 12, face = "italic"),     
          legend.title = element_blank(),                                   
          legend.position = c(0.85, 0.85)), 
  
  ncol = 3)) 

