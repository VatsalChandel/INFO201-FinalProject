library(ggplot2)
library(plotly)
library(dplyr)


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")


server <- function(input, output) {
  output$caff_drink_plot <- renderPlotly({
    filtered_df <- caffeine_data %>%
      filter(type %in% input$category_select) %>%
      filter(Volume..ml. >= input$volume_slider[1] &
        Volume..ml. <= input$volume_slider[2])
    validate(
      need(input$category_select, "Please select a category!")
    )


    caff_drink_plot <- ggplot(data = filtered_df) +
      geom_point(mapping = aes(
        x = Volume..ml.,
        y = Caffeine..mg.,
        color = type,
        text = paste(
          "Volume (ml):", Volume..ml.,
          "\nCaffeine (mg):", Caffeine..mg.,
          "\nDrink:", drink
        )
      )) +
      labs(
        title = "Caffeine of Various Types of Drinks and Volume",
        x = "Volume (ml)",
        y = "Caffeine (mg)"
      )

    gg_caff <- ggplotly(caff_drink_plot,
      tooltip = "text",
      height = 800,
      width = 1000
    )

    return(gg_caff)
  })
}
