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
                box(selectizeInput('groupSelect', 'Choose organizations by their group classification', 
                                   choices = groups_codes, multiple = TRUE, options = list(
                                       plugins = list('remove_button'))), selectize_css,
                    title = 'Group Filter', height = NULL, width = NULL),
            
                box(selectizeInput('zipSelect', 'Choose organizations by their zip code',
                                   choices = unique(geo_data$ZIP_FIVE), multiple = TRUE, options = list(
                                       plugins = list('remove_button'))),
                    title = 'Zip Code Filter', width = NULL)),
           
            column(width = 9,
                   box(leafletOutput('map', height = 350),
                       title = 'Map', width = NULL),
                   box(DT::DTOutput('table'),
                       title = 'Table', width = NULL))
            )
        )
        
        ))