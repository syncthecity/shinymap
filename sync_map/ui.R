# Define UI for application
shinyUI(
    
    # include a fliudPage above the navbar to incorporate an icon in the header
    fluidPage(
        
        list(tags$head(HTML('<link rel="icon", href="logo.png",
                        type="image/png" />'
                            )
                       )
             ),
        div(style = 'padding: 1px 0px; width: 100%',
            titlePanel(
                title = '', windowTitle = 'Window Tab title'
            )
        ),
        
    fluidPage(
        navbarPage(title = div(img(src = 'sync_logo.png', style = 'width: 10%'), 'Sync the City', style = 'margin: auto'),
                   theme = shinytheme('flatly'),
                   
                   # define landing page UI
                   tabPanel('Home', icon = icon('home'),
                            
                            shinyLP::jumbotron(header = 'Coming Soon!', content = 'Please mind the mess in the meantime.', button = FALSE),
                            
                            fluidRow(
                                column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'Who?', 
                                                             content = ' Baltimoreans who want to empower organizations to solve problems.'
                                                             )
                                       ),
                                column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'What?',
                                                             content = 'A tool to connect organizations and help them identify resources.'
                                                             )
                                       )
                                ),
                            
                            fluidRow(
                                column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'When?',
                                                             content = 'SoonTM.')),
                                column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'Why?',
                                                             content = 'Reduce duplication of effort to address Baltimore\'s challenges.'
                                                             )
                                       )
                                )
                            ),
                   
                   # define tool UI 
                   tabPanel('Explore', icon = icon('map-marker-alt'),
                            dashboardPage(
                                
                                dashboardHeader(disable = TRUE),
                                dashboardSidebar(disable = TRUE),
                                
                                dashboardBody(
                                    shinyDashboardThemes(
                                        theme = 'poor_mans_flatly'
                                    ),
                                    
                                    fluidRow(
                                        # define filter input UI
                                        column(width = 3,
                                               box(selectizeInput('groupSelect', 'Choose organizations by their group classification', 
                                                                  choices = groups_codes,
                                                                  multiple = TRUE,
                                                                  options = list(
                                                                      plugins = list('remove_button'))
                                                                  ),
                                                   selectize_css,
                                                   title = 'Group Filter', height = NULL, width = NULL),
                                               
                                               box(selectizeInput('zipSelect', 'Choose organizations by their zip code',
                                                                  choices = unique(geo_data$ZIP_FIVE),
                                                                  multiple = TRUE,
                                                                  options = list(
                                                                      plugins = list('remove_button'))
                                                                  ),
                                                   title = 'Zip Code Filter', width = NULL
                                                   )
                                               ),
                                        
                                        # define map and table output UI
                                        column(width = 9,
                                               box(leafletOutput('map', height = 350),
                                                   title = 'Map', width = NULL
                                                   ),
                                               box(DT::DTOutput('table'),
                                                   title = 'Table', width = NULL
                                                   )
                                               )
                                        )
                                    )
                                )
                            )
                   )
        )
    )
    )