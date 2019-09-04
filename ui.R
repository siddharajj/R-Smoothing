library(shiny)
library(leaflet)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Coral Bleaching"),
  
  fluidRow(
    selectInput(
      inputId = "type",
      label = "Coral Type",
      choices = c("All Corals"="All Corals",
                  "blue corals" = "blue corals",
                  "hard corals" = "hard corals",
                  "sea fans" = "sea fans",
                  "sea pens" = "sea pens",
                  "soft corals" = "soft corals"),
    
      selected = "All Corals"),
    checkboxInput(inputId = "smooth", value = FALSE, label = "Smooth")),
  
  fluidRow(
    plotOutput(outputId = "ggplot",height = 720)),
  
  fluidRow(
    leafletOutput(outputId = "map_leaf"))
)
