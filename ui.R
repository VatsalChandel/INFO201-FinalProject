library(plotly)
library(bslib)
library(markdown)
library("tidyverse")


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

page_1 <- tabPanel(
  "Interactive Page 1",
  fluidPage(
    "Page 1"
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