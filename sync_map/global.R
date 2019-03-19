# data manipulation
library(tidyverse)
library(scales)
library(here)
# web framework
library(shiny)
library(shinydashboard)
library(dashboardthemes)
# map and table output
library(leaflet)
library(leaflet.extras)
library(rgdal)
library(sf)
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

# create nested list for selectize filter 
groups_codes <- list(`Arts and Culture` = c(
                            `Animal-Related` = 'Animal-Related',
                            `Arts, Culture, and Humanities` = 'Arts, Culture and Humanities', 	
                            `Civil Rights, Social Action, Advocacy` = 'Civil Rights, Social Action, Advocacy',
                            `Mutual/Membership Benefit Organizations, Other` = 'Mutual/Membership Benefit Organizations, Other',
                            `Recreation, Sports, Leisure, Athletics` = 'Recreation, Sports, Leisure, Athletics',
                            `Religion-Related, Spiritual Development` = 'Religion-Related, Spiritual Development'),
                     
                     `Children and Family Health` = c(
                            `Diseases, Disorders, Medical Disciplines` = 'Diseases, Disorders, Medical Disciplines',
                            `Health - General and Rehabilitative` = 'Health - General and Rehabilitative',
                            `Human Services - Multipurpose and Other` = 'Human Services - Multipurpose and Other',
                            `Medical Research` = 'Medical Research',
                            `Mental Health, Crisis Intervention` = 'Mental Health, Crisis Intervention',
                            `Social Science Research Institutes, Services` = 'Social Science Research Institutes, Services'),
                     
                     `Crime and Safety` = c(
                            `Crime, Legal-Related` = 'Crime, Legal-Related',
                            `International, Foreign Affairs and National Security` = 'International, Foreign Affairs and National Security',
                            `Public Safety, Disaster Preparedness and Relief` = 'Public Safety, Disaster Preparedness and Relief'),
                     
                     `Education and Youth` = c(
                            `Educational Institutions and Related Activities` = 'Educational Institutions and Related Activities',
                            `Youth Development` = 'Youth Development'),
                     
                     `Housing and Community Development` = c(
                            `Community Improvement, Capacity Building` = 'Community Improvement, Capacity Building',
                            `Housing, Shelter` = 'Housing, Shelter',
                            `Public, Society Benefit - Multipurpose and Other` = 'Public, Society Benefit - Multipurpose and Other'),
                     
                     Sustainability = c(
                            `Environmental Quality, Protection and Beautification` = 'Environmental Quality, Protection and Beautification',
                            `Food, Agriculture and Nutrition` = 'Food, Agriculture and Nutrition',
                            `Science and Technology Research Institutes, Services` = 'Science and Technology Research Institutes, Services'),
                     
                     `Workforce and Economic Development` = c(
                            `Employment, Job-Related` = 'Employment, Job-Related',
                             `Philanthropy, Voluntarism and Grantmaking Foundations` = 'Philanthropy, Voluntarism and Grantmaking Foundations'),
                     
                     Unknown = 'Unknown'
                     
                     ) 

# define lists of rollup groups
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

# define CSS for selectize to be larger than a single line (temporary fix for box that won't auto-increase)
selectize_css <- tags$head(tags$style(HTML(".selectize-input {overflow: visible; display: inline-table; font-size: 10px;}")))

# read in shapefile for zip5 boundaries
zip_bounds <- readOGR(dsn = 'ZIP_files', layer = 'ZIP_Codes') %>% 
  st_as_sf() %>% 
  st_transform(4326) %>% 
  mutate(labs = paste0('<strong>Zip Code: </strong>', ZIPCODE1))

labs <- as.list(zip_bounds$labs)

# convert to sf and transform to web map projection  
#bike_network <- st_as_sf(bike_network)
#bike_network_trans <- st_transform(bike_network, 4326)

