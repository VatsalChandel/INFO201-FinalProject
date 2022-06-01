library(ggplot2)
library(plotly)
library("tidyverse")
library("dplyr")


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")
View(caffeine_data)


caffeine_data <- caffeine_data %>%
  mutate(caffeine_by_vol = Caffeine..mg. / Volume..ml.)



total_caff <- caffeine_data %>%
  group_by(type) %>%
  summarize(mean_caffeine = mean(Caffeine..mg.))


temp_plot2 <- ggplot(data = total_caff) +
  geom_col(aes(x = type, y = mean_caffeine,
               fill = type),
           width = 0.5) +
  labs(
    title = "Average Caffeine Amounts Per Drink Types",
    x = "Drink Types", y = "Average Caffeine (mg)"
  )



ggplotly(temp_plot2)
