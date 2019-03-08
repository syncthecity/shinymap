library(tidyverse)
library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

x <- c(1, 2, 3)
y <- c(4, 5, 6)

# load organizations csv  
geo_data <- read_csv("geo_all.csv") 

shinyServer(function(input, output) {
    
    # reactive expression for filtering map points
    # filteredData <- reactive({
    #     geo_data[geo_data$codes == input$codes]
    # })
    
    # create base for leaflet map output
    output$map <- renderLeaflet({
        
        leaflet() %>% 
            addProviderTiles(provider = providers$OpenStreetMap.BlackAndWhite) %>% 
            setView(lng = -76.62, lat = 39.29, zoom = 12) 
            
    })
    
    # add parts of the map that will change in their own observers
    # observe({
    #     leafletProxy('map', data = filteredData())
    # })
    

    # create data table
    output$table <- renderDataTable(DT::datatable({
        data <- data.frame(x, y)
    
    data
    }))
}
)