library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(leaflet)
library(DT)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(
    dashboardHeader(title = 'Sync the City'),
    dashboardSidebar(), 
    dashboardBody(
        shinyDashboardThemes(
            theme = 'poor_mans_flatly'
        ),
        fluidRow(
            box(
                leafletOutput('map', height = 350), width = 12),
            
        fluidRow(
            box(
                DT::DTOutput('table'), width = 12)
            )
        )
    )))
