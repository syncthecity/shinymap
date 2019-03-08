library(shiny)
library(shinydashboard)
library(leaflet)
library(DT)

x <- c(1, 2, 3)
y <- c(4, 5, 6)

shinyServer(function(input, output) {
    
    # create base for leaflet map output
    output$map <- renderLeaflet({
        
        leaflet() %>% 
            addTiles() %>% 
            setView(lng = -76.62, lat = 39.29, zoom = 12) 
            
    })
    
    # create data table
    output$table <- renderDataTable(DT::datatable({
        data <- data.frame(x, y)
    
    data
    }))
}
)