library(shiny)
library(leaflet)
library(ggplot2)

coral_data <- read.csv("data-formated.csv")

coral_data$value = as.numeric(gsub("[\\%,]", "", coral_data$value))

server <- function(input, output, session) {
  
  corals <- reactive({
    
    if(input$type == "All Corals"){
      plot_var <- ggplot(coral_data, aes(year, value)) + geom_bar(stat = "identity", aes(fill=location),width = 0.4) + facet_grid(-latitude~location~coralType)
      
      if(input$smooth == TRUE) {
        plot_var <- plot_var + geom_smooth(method = "glm", se=FALSE, colour="black")
      }
      plot_var
    }
    
    else {
      sub_df = coral_data[coral_data$coralType == input$type, ]
      
      plot_var <- ggplot(sub_df, aes(year, value)) + geom_bar(stat = "identity", aes(fill=location),width = 0.4) + facet_wrap(~location) + ggtitle(input$type)
      
      if(input$smooth == TRUE) {
        plot_var <- plot_var + geom_smooth(method = "glm", se=FALSE, colour="black")
      }
      plot_var
    }
  })
  
  output$ggplot <- renderPlot({
    corals()
  })
  
  output$map_leaf <- renderLeaflet({
    leaflet(data = coral_data) %>% addTiles() %>% addMarkers(~longitude, ~latitude, popup = paste(coral_data$location,coral_data$latitude,coral_data$longitude), label = paste(coral_data$location,coral_data$latitude,coral_data$longitude))
  })
}