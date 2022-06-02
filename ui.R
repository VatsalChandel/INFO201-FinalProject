library(plotly)
library(bslib)
library(markdown)
library("tidyverse")
library(shiny)


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")

my_theme <- bs_theme(
  bg = "#0b3d91",
  fg = "white",
  primary = "white",
)
my_theme <- bs_theme_update(my_theme, bootswatch = "flatly")


intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("introduction.md")
  )
)

sidebar_panel_widget <- sidebarPanel(
  checkboxGroupInput(
    inputId = "category_select",
    label = "Drink Types",
    choices = c(
      "Coffee",
      "Energy Drinks",
      "Energy Shots",
      "Soft Drinks",
      "Tea",
      "Water"
    ),
    selected = "Coffee",
  ),
  sliderInput(
    inputId = "volume_slider",
    label = "Select Volume (ml) Range",
    min = min(caffeine_data$Volume..ml.),
    max = max(caffeine_data$Volume..ml.),
    sep = "",
    value = c(50, 300)
  )
)

main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "caff_drink_plot")
)

type_sidebar_panel_widget <- sidebarPanel(
  selectInput(
    inputId = "type_select",
    label = "Select Drink Type",
    choices = c(
      "Coffee",
      "Energy Drinks",
      "Energy Shots",
      "Soft Drinks",
      "Tea",
      "Water"
    ),
  )
)

type_main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "type_plot")
)


page_1 <- tabPanel(
  "Type",
  sidebarLayout(
  type_sidebar_panel_widget,
  type_main_panel_plot,
  ),
  includeMarkdown("type_page.md")
)

page_2 <- tabPanel(
  "Value",
  fluidPage(
    "Page 2"
  ),

)

page_3 <- tabPanel(
  "Safety",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  ),
  includeMarkdown("saftey_page.md")
)

conclusion_page <- tabPanel(
  "Conclusion",
  fluidPage(
    "Conclusions about 250"
  )
)

ui <- navbarPage(
  theme = my_theme,
  "Assesment of Various Caffeinated Drinks",
  intro_tab,
  page_1,
  page_2,
  page_3,
  conclusion_page
)
