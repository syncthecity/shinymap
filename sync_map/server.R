# data manipulation
library(tidyverse)
library(scales)
# web framework
library(shiny)
library(shinydashboard)
# map and table output
library(leaflet)
library(DT)

# load organizations csv  
geo_data <- read_csv("geo_all.csv") 

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

# add variable for code group
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
    rename(Name = NAME) %>% 
    rename(Street = STREET) %>% 
    rename(Assets = ASSET_AMT) %>% 
    rename(Income = INCOME_AMT) %>% 
    rename(Revenue = REVENUE_AMT) %>% 
    rename(Code = codes)
    #mutate(ASSET_AMT = dollar(ASSET_AMT)) %>% 
    #mutate(INCOME_AMT = dollar(INCOME_AMT)) %>%
    #mutate(REVENUE_AMT = dollar(REVENUE_AMT)) 


# begin shiny server function
shinyServer(function(input, output) {

    
    # create base for leaflet map output
    output$map <- renderLeaflet({
        
        leaflet() %>% 
            addProviderTiles(provider = providers$OpenStreetMap.BlackAndWhite) %>% 
            setView(lng = -76.62, lat = 39.29, zoom = 11) 
            
    })
    


    
    # create a data frame based on inputs
    filtered_geo <- reactive({ # if no groups are selected
        if (is.null(input$groupSelect)) {
            return(NULL)
        }    
        
        geo_data %>% 
            filter(Group %in% input$groupSelect) %>% 
            select(Name, Street, Assets, Income, Revenue, Group, Code)
        
    })
    
    
    output$table <- renderDataTable(DT::datatable({
        
        filtered_geo()
        
    }))
    
}
)

# create data table
#    output$table <- renderDataTable(DT::datatable({
#        geo_data %>% 
#            filter(group %in% input$groups) %>% 
#            select(NAME, STREET, ASSET_AMT, INCOME_AMT, REVENUE_AMT, group, codes)
#    
#    })
