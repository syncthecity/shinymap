# data manipulation
library(tidyverse)
library(scales)
# web framework
library(shiny)
library(shinydashboard)
# map and table output
library(leaflet)
library(leaflet.extras)
library(DT)

# load organizations csv  
geo_data <- read_csv("geo_all.csv") 

# create object of organization groups for checkbox input
groups <- c('Arts and Culture', 
            'Children and Family Health',
            'Crime and Safety',
            'Education and Youth',
            'Housing and Community Development',
            'Sustainability',
            'Workforce and Economic Development',
            'Unknown')

# add groupings to organization codes 
AC_list <- c('Animal-Related',
             'Arts, Culture and Humanities', 	
             'Civil Rights, Social Action, Advocacy',
             'Mutual/Membership Benefit Organizations, Other',
             'Recreation, Sports, Leisure, Athletics',
             'Religion-Related, Spiritual Development')

CFH_list <- c('Diseases, Disorders, Medical Disciplines',
              'Health - General and Rehabilitative',
              'Human Services - Multipurpose and Other',
              'Medical Research',
              'Mental Health, Crisis Intervention',
              'Social Science Research Institutes, Services')

CS_list <- c('Crime, Legal-Related',
             'International, Foreign Affairs and National Security',
             'Public Safety, Disaster Preparedness and Relief')

EY_list <- c('Educational Institutions and Related Activities',
             'Youth Development')

HCD_list <- c('Community Improvement, Capacity Building',
              'Housing, Shelter',
              'Public, Society Benefit - Multipurpose and Other')

S_list <- c('Environmental Quality, Protection and Beautification',
            'Food, Agriculture and Nutrition',
            'Science and Technology Research Institutes, Services')

WED_list <- c('Employment, Job-Related',
              'Philanthropy, Voluntarism and Grantmaking Foundations')

# add variable for organization group based on code
geo_data <- geo_data %>% 
    mutate(Group = ifelse(codes %in% AC_list, 'Arts and Culture',
                          
                   ifelse(codes %in% CFH_list, 'Children and Family Health', 
                                 
                   ifelse(codes %in% CS_list, 'Crime and Safety', 
                                        
                   ifelse(codes %in% EY_list, 'Education and Youth', 
                                               
                   ifelse(codes %in% HCD_list, 'Housing and Community Development',
                                                      
                   ifelse(codes %in% S_list, 'Sustainability',
                                                             
                   ifelse(codes %in% WED_list, 'Workforce and Economic Development',
                          
                          'Unknown'
                          )))))))) %>%
    # rename variables for cleaner presention in DataTable
    rename(Name = NAME) %>% 
    rename(Street = STREET) %>% 
    rename(Assets = ASSET_AMT) %>% 
    rename(Income = INCOME_AMT) %>% 
    rename(Revenue = REVENUE_AMT) %>% 
    rename(Code = codes)
    # convert number vars to dollar format 
    #mutate(ASSET_AMT = dollar(ASSET_AMT)) %>% 
    #mutate(INCOME_AMT = dollar(INCOME_AMT)) %>%
    #mutate(REVENUE_AMT = dollar(REVENUE_AMT)) 


# begin shiny server function
shinyServer(function(input, output) {

    # create a reactive data frame based on checkbox inputs 
    filtered_geo <- reactive({ # if no groups are selected

        geo_data %>% 
            filter(Group %in% input$groupSelect) 

    })
    
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
                             fillOpacity = .5,
                             color = ~pal(Group),
                             stroke = FALSE)

    }) 
    
    # create legend that shows groups selected with input 
    observe({
        
        pal <- colorpal()

        leafletProxy('map', data = filtered_geo()) %>%
            clearControls() %>% 
            addLegend(position = 'bottomright',
                      pal = pal, values = filtered_geo()$Group)
    })
    
    # create DataTable output utilizing input filter function
    output$table <- renderDataTable(DT::datatable({
        
        filtered_geo() %>% 
            select(Name, Street, Assets, Income, Revenue, Group, Code)
        
    }))
    
}
)