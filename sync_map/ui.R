# Define UI for application 
shinyUI(dashboardPage(
    
    dashboardHeader(title = 'Sync the City'),
    dashboardSidebar(disable = TRUE),
    
    dashboardBody(
        shinyDashboardThemes(
            theme = 'poor_mans_flatly'
        ),
        
        fluidRow(
            column(width = 3,
                box(checkboxGroupInput('groupSelect', 'Organization Groups', 
                                       choiceNames = groups,
                                       choiceValues = groups), title = 'Filter', width = NULL)),
            
            column(width = 9,
                   box(leafletOutput('map', height = 350), title = 'Map', width = NULL),
                   box(DT::DTOutput('table'), title = 'Table', width = NULL))
            )
        )
        
        ))