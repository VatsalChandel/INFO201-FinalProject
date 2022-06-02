library(ggplot2)
library(plotly)
library("tidyverse")
library("dplyr")


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")
caffine_price <- read.csv("data/caffeine_price.csv", header = TRUE, sep = ",")
View(caffeine_data)
colnames(caffeine_data)


topdrinks_caffine <- caffine_price %>% filter(price > 0, na.rm = TRUE) %>% mutate("Volume_Price_Ratio" = Volume..ml. / Caffeine..mg.)

Value <- ggplot(data = topdrinks_caffine) +
  geom_col(aes(x = price, 
               y = Volume_Price_Ratio, 
               fill = drink),
           position = "dodge")

ggplotly(Value)

caff_drink_plot <- ggplot(data = caffeine_data) +
  geom_point(mapping = aes(x = Volume..ml., y = Caffeine..mg., color = type)) +
  labs(
    title = "Title",
    x = "X axis", y = "Y axis"
  )




ggplotly(caff_drink_plot)




smallest <- caffeine_data %>% filter(Caffeine..mg. == min(Caffeine..mg.)) 
smallest

data_new1 <- caffeine_data[order(caffeine_data$Caffeine..mg., decreasing = TRUE), ]
data_new1 <- Reduce(rbind,                                 # Top N highest values by group
                    by(data_new1,
                       data_new1["Caffeine..mg."],
                       head,
                       n = 3))
data_new1[1:10]                                                  # Print updated data
