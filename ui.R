library(plotly)
library(bslib)
library(markdown)
library("tidyverse")


caffeine_data <- read.csv("data/caffeine.csv", header = TRUE, sep = ",")

caffeine_data <- caffeine_data %>%
  mutate(caffeine_by_vol = Caffeine..mg. / Volume..ml.)




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
    label = "Select Drink Type",
    choices = c("Coffee" = "Coffee",
                "Energy Drinks
" = "Energy Drinks
"
    ),
  ),
)

main_panel_plot <- mainPanel(
  plotlyOutput(outputId = "caff_drink_plot")
)

page_1 <- tabPanel(
  "Interactive Page 1",
  sidebarLayout(
    sidebar_panel_widget,
    main_panel_plot,
  )
)

page_2 <- tabPanel(
  "Interactive Page 2",
  fluidPage(
    "Page 2"
  )
)
page_3 <- tabPanel(
  "Interactive Page 3",
  fluidPage(
    "Page 3"
  )
)

conclusion_page <- tabPanel(
  "Conclusion Page",
  fluidPage(
    "Conclusions about 250"
  )
)

ui <- navbarPage(
  theme = my_theme,
  "Title!",
  intro_tab,
  page_1,
  page_2,
  page_3,
  conclusion_page
)