library(ggplot2)
library(plotly)
library(dplyr)


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")

caffeine_data <- caffeine_data %>%
  mutate(caffeine_by_vol = Caffeine..mg. / Volume..ml.)

total_caff <- caffeine_data %>%
  group_by(type) %>%
  summarize(mean_caffeine = mean(Caffeine..mg.))


server <- function(input, output) {
  output$caff_drink_plot <- renderPlotly({
    filtered_df <- caffeine_data %>%
      filter(type %in% input$category_select)
    validate(
      need(input$category_select, "Please select a category!")
    )
    
    caff_drink_plot <- ggplot(data = caffeine_data) +
      geom_point(mapping = aes(x = Volume..ml., y = Caffeine..mg., color = type)) +
      labs(
        title = "Title",
        x = "X axis", y = "Y axis"
      )
    
    return(caff_drink_plot)
  })
}