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
                # box(checkboxGroupInput('groupSelect', 'Organization Groups', 
                #                        choiceNames = groups,
                #                        choiceValues = groups), title = 'Filter', width = NULL),
                
                box(selectizeInput('groupSelect', 'Organization Groups', 
                                   choices = groups_codes, multiple = TRUE), selectize_css,
                    title = 'Filter', height = NULL, width = NULL)),
                # 
                # box(textInput('textFilter', 'Text Filter',
                #               value = 'Filter by name...'),
                #     title = 'Text', width = NULL)),
            
            column(width = 9,
                   box(leafletOutput('map', height = 350),
                       title = 'Map', width = NULL),
                   box(DT::DTOutput('table'),
                       title = 'Table', width = NULL))
            )
        )
        
        ))