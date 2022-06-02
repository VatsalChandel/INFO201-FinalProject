library(ggplot2)
library(plotly)
library(dplyr)
library(shiny)


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
        title = "Caffeine vs Volume by Drink Type",
        x = "Volume (ml)",
        y = "Caffeine (mg)"
      )

    gg_caff <- ggplotly(caff_drink_plot,
      tooltip = "text",
      height = 450,
      width = 1000
    )

    return(gg_caff)
  })
  
  
  output$type_plot <- renderPlotly({
    
    brand_df <- caffeine_data %>% 
      mutate("brand" = gsub("\\ .*" , "", caffeine_data$drink)) %>% 
      mutate("caffeine_per_calories" = Caffeine..mg. / Calories) %>% 
      filter_all(all_vars(!is.infinite(.)))
    
    coffee_df <- brand_df%>% 
      filter(type == "Coffee") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    energy_drinks_df <- brand_df %>% 
      filter(type == "Energy Drinks") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    energy_shots_df <- brand_df %>% 
      filter(type == "Energy Shots") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    soft_drinks_df <- brand_df %>% 
      filter(type == "Soft Drinks") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    tea_df <- brand_df %>% 
      filter(type == "Tea") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    water_df <- brand_df %>% 
      filter(type == "Water") %>% 
      arrange(-caffeine_per_calories) %>% 
      slice_max(n = 15, order_by = caffeine_per_calories)
    
    type_df <- rbind(tea_df, water_df, soft_drinks_df, energy_shots_df, energy_drinks_df, coffee_df)
    
    #Brand Renaming
    type_df[type_df$brand == "Oi","brand" ] <- "Oi Ocha"
    type_df[type_df$brand == "Crystal","brand" ] <- "Crystal Light"
    type_df[type_df$brand == "Guayaki","brand" ] <- "Guayaki Yerba Mate"
    type_df[type_df$brand == "Brew","brand" ] <- "Dr Kombucha"
    type_df[type_df$brand == "Master","brand" ] <- "Master Brew"
    type_df[type_df$brand == "Turkey","brand" ] <- "Turkey Hill"
    type_df[type_df$brand == "Sparkling","brand" ] <- "Sparkling Ice"
    type_df[type_df$brand == "Polar","brand" ] <- "Polar Frost"
    type_df[type_df$brand == "Poland","brand" ] <- "Poland Spring"
    type_df[type_df$brand == "Dr","brand" ] <- "Dr Pepper"
    type_df[type_df$brand == "Mountain","brand" ] <- "Mountain Dew"
    type_df[type_df$brand == "Soda","brand" ] <- "Soda Stream"
    type_df[type_df$brand == "Premium","brand" ] <- "Premium Cola"
    type_df[type_df$brand == "Fritz","brand" ] <- "Fritz Kola"
    type_df[type_df$brand == "Afri","brand" ] <- "Afri Cola"
    type_df[type_df$brand == "doc","brand" ] <- "Doc"
    type_df[type_df$brand == "Sun","brand" ] <- "Sun Drop"
    type_df[type_df$brand == "5","brand" ] <- "5 Hour Energy"
    type_df[type_df$brand == "Proper","brand" ] <- "Proper Wild"
    type_df[type_df$brand == "Vital","brand" ] <- "Vital 4U"
    type_df[type_df$brand == "Zombie","brand" ] <- "Zombie Blood"
    type_df[type_df$brand == "Best","brand" ] <- "Best Choice"
    type_df[type_df$brand == "Alani","brand" ] <- "Alani Nu"
    type_df[type_df$brand == "Coffee","brand" ] <- "Coffee Bean & Tea"
    type_df[type_df$brand == "7","brand" ] <- "7 Eleven"
    type_df[type_df$brand == "Tim","brand" ] <- "Tim Hortons"
    type_df[type_df$drink == "doc Soda","drink" ] <- "Doc Soda"
    
   filtered_type_df <- type_df %>%
     filter(type %in% input$type_select)
   
   blank_theme <- theme_bw() +
     theme(
       plot.background = element_blank(), # remove gray background
       plot.title = element_text(hjust = 0.5),
       axis.text = element_text(angle = 90)
     )
    
     type_plot <- ggplot(data = filtered_type_df) +
      geom_col(mapping = aes(
        x = brand,
        y = caffeine_per_calories,
        text = paste(
          "Brand:", brand,
          "\nCaffeine / Calorie =", caffeine_per_calories,
          "\nDrink:", drink
        ),
        fill = drink,
      )) +
       labs(
         title = "Caffeine (mg) / Calorie Content Per Type of Drink",
         x = "Brands",
         y = "Caffeine Content Per Calorie",
         fill = "Drinks"
       ) +
       blank_theme
    
     gg_type <- ggplotly(type_plot,
                         tooltip = "text",
                         height = 450,
                         width = 1000
     )
     
return(gg_type)
  
  })
  
}
