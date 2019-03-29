# compile shiny server function
shinyServer(function(input, output, session) {

    # create a reactive data frame based on checkbox inputs 
    filtered_geo <- reactive({

        geo_data %>% 
            filter(Code %in% input$groupSelect) %>% 
            filter(ZIP_FIVE %in% input$zipSelect)
        
    })
    
    updateSelectizeInput(session, 'groupSelect', choices = groups_codes, server = TRUE)
    
    updateSelectizeInput(session, 'zipSelect', choices = geo_data$ZIP_FIVE, server = TRUE)
    
    
    # create color palette for coloring groups on map 
    colorpal <- reactive({
        # re-ordered version of the Set2 palette from RColorBrewer
        colorFactor(
            c('#66C2A5', '#FC8D62', '#8DA0CB', '#E78AC3', '#FFD92F', '#A6D854', '#B3B3B3', '#E5C494'), groups)
    })
    
    # create base for leaflet map output
    output$map <- renderLeaflet({
        
        leaflet(geo_data, options = leafletOptions(minZoom = 10, maxZoom = 18)) %>% 
            addProviderTiles(provider = providers$CartoDB.Positron) %>% 
            setView(lng = -76.62, lat = 39.29, zoom = 11) %>% 
            addPolygons(data = zip_bounds, fill = TRUE, fillOpacity = .01, weight = 2, opacity = 1,
                        label = lapply(labs, HTML), color = '#3498db') %>% 
            addResetMapButton() 

    })
    
    # add circlemarkers based on groups input
    observe({
        
        pal <- colorpal()

        leafletProxy('map', data = filtered_geo()) %>%
            clearMarkers() %>% 
            addCircleMarkers(lng = ~lon,
                             lat = ~lat,
                             radius = ~log(Assets + 100),
                             fillOpacity = .6,
                             color = ~pal(Group),
                             stroke = FALSE,
                             popup = ~paste0(Name, '<br/>',
                                            '<strong>Assets: </strong>', dollar(Assets), '<br/>',
                                            '<strong>Income: </strong>', dollar(Income), '<br/>',
                                            '<strong>Revenue: </strong>', dollar(Revenue), '<br/>',
                                            '<strong>Code: </strong>', Code
                                            )
                             )

    }) 
    
    # create legend that shows groups selected with input 
    observe({
        
        pal <- colorpal()

        leafletProxy('map', data = filtered_geo()) %>%
            clearControls() %>% 
            addLegend(position = 'bottomright',
                      pal = pal, values = filtered_geo()$Group
                      )
    })
    
    # create DataTable output utilizing input filter function
    output$table <- renderDataTable(DT::datatable({
        
        filtered_geo() %>% 
            select(Name, Street, Assets, Income, Revenue, Group, Code)
        
    }, 
    #extensions = 'Scroller',
    #options = list(
    #    deferRender = TRUE,
    #    scrollY = 200,
    #    scroller = TRUE)
    extensions = 'Responsive') %>% 
        formatCurrency(columns = c('Assets', 'Income', 'Revenue'), digits = 0
                       )
    )
    


    
}
)