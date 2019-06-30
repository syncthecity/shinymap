# # Define UI for application
# shinyUI(
#     
#     # include a fliudPage above the navbar to incorporate an icon in the header
#     fluidPage(
#         
#         list(tags$head(HTML('<link rel="icon", href="logo.png",
#                         type="image/png" />'
#                             )
#                        )
#              ),
#         div(style = 'padding: 1px 0px; width: 100%',
#             titlePanel(
#                 title = '', windowTitle = 'Window Tab title'
#             )
#         ),
#         
#     fluidPage(
#         navbarPage(title = div(img(src = 'sync_logo.png', style = 'width: 10%'), 'Sync the City', style = 'margin: auto'),
#                    theme = shinytheme('flatly'),
#                    
#                    # define landing page UI
#                    tabPanel('Home', icon = icon('home'),
#                             
#                             shinyLP::jumbotron(header = 'Coming Soon!', content = 'Please mind the mess in the meantime.', button = FALSE),
#                             
#                             fluidRow(
#                                 column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'Who?', 
#                                                              content = ' Baltimoreans who want to empower organizations to solve problems.'
#                                                              )
#                                        ),
#                                 column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'What?',
#                                                              content = 'A tool to link organizations and identify resources.'
#                                                              )
#                                        )
#                                 ),
#                             
#                             fluidRow(
#                                 column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'When?',
#                                                              content = 'SoonTM.')),
#                                 column(6, shinyLP::panel_div(class_type = 'primary', panel_title = 'Why?',
#                                                              content = 'Reduce duplication of effort to address Baltimore\'s challenges.'
#                                                              )
#                                        )
#                                 )
#                             ),
#                    
#                    # define tool UI 
#                    tabPanel('Map', icon = icon('map-marker-alt'),
#                             dashboardPage(
#                                 
#                                 dashboardHeader(disable = TRUE),
#                                 dashboardSidebar(disable = TRUE),
#                                 
#                                 dashboardBody(
#                                     shinyDashboardThemes(
#                                         theme = 'poor_mans_flatly'
#                                     ),
#                                     
#                                     fluidRow(
#                                         # define filter input UI
#                                         column(width = 3,
#                                                box(selectizeInput('groupSelect', 'Choose organizations by their group classification', 
#                                                                   choices = groups_codes,
#                                                                   multiple = TRUE,
#                                                                   options = list(
#                                                                       plugins = list('remove_button'))
#                                                                   ),
#                                                    selectize_css,
#                                                    title = 'Group Filter', height = NULL, width = NULL),
#                                                
#                                                box(selectizeInput('zipSelect', 'Choose organizations by their zip code',
#                                                                   choices = unique(geo_data$ZIP_FIVE),
#                                                                   multiple = TRUE,
#                                                                   options = list(
#                                                                       plugins = list('remove_button'))
#                                                                   ),
#                                                    title = 'Zip Code Filter', width = NULL
#                                                    )
#                                                ),
#                                         
#                                         # define map and table output UI
#                                         column(width = 9,
#                                                box(leafletOutput('map', height = 350),
#                                                    title = 'Map', width = NULL
#                                                    ),
#                                                box(DT::DTOutput('table'),
#                                                    title = 'Table', width = NULL
#                                                    )
#                                                )
#                                         )
#                                     )
#                                 )
#                             ),
#                    
#                    tabPanel('Network', icon = icon('project-diagram'),
#                             dashboardPage(
#                                 
#                                 dashboardHeader(disable = TRUE),
#                                 dashboardSidebar(disable = TRUE),
#                                 
#                                 dashboardBody(
#                                     shinyDashboardThemes(
#                                         theme = 'poor_mans_flatly'
#                                         ),
#                                     
#                                     fluidRow(
#                                         
#                                         column(width = 12,
#                                                box(visNetworkOutput('network'),
#                                                    title = 'Network', width = NULL
#                                                    )
#                                                )
#                                         )
#                                     )
#                                 )
#                             )
#                    )
#         )
#     )
#     )
# 
# shinyUI(
#     fluidPage(
#         argonDash::argonDashPage(title = 'Sync the City',
#                                  
#                                  description = 'testing...',
#                                  
#                                  navbar = argonDashNavbar(
#                                      argonDropNav(title = 'Sync the City',
#                                                   src = 'www/sync_logo_v2.png',
#                                                   orientation = 'right',
#                                                   argonDropNavTitle(title = 'dropdown title'),
#                                                   argonDropNavItem(title = 'item1')
#                                                   )
#                                      ),
#                                  
#                                  header = argonDashHeader(color = 'primary'),
#                                  
#                                  body = argonDashBody(
#                                      argonTabItems(
#                                          argonTabItem(tabName = 'Landing Page', 'LP content', 
#                                                       p('Hello World!'),
#                                                       h1('Desc 1')
#                                                       ),
#                                          argonTabItem(tabName = "Map", "Item 1 content",
#                                                       fluidRow(
#                                                           column(width = 3,
#                                                                  box(
#                                                                      selectizeInput('groupSelect',
#                                                                                     'Choose organizations by their group classification', 
#                                                                                     choices = groups_codes,
#                                                                                     multiple = TRUE,
#                                                                                     options = list(
#                                                                                         plugins = list('remove_button')
#                                                                                         )
#                                                                                     ),
#                                                                      selectize_css,
#                                                                      title = 'Group Filter', height = NULL, width = NULL
#                                                                      )
#                                                                  )
#                                                           )
#                                                       ),
#                                          argonTabItem(tabName = "Network", "Item 2 content")
#                                          )
#                                      ),
#                                  
#                                  sidebar = argonDashSidebar(id = 'sidebarnav',
#                                                             vertical = TRUE,
#                                                             side = 'left',
#                                                             size = 'md',
#                                                             background = 'white',
#                                                             
#                                                             argonSidebarHeader(title = 'menu title'),
#                                                             
#                                                             argonSidebarMenu(
#                                                                 argonSidebarItem('Landing Page',
#                                                                                  tabName = 'Landing Page',
#                                                                                  icon = icon('home')
#                                                                                  ),
#                                                                 
#                                                                 argonSidebarItem('Map',
#                                                                                  tabName = 'Map',
#                                                                                  icon = icon('map-marker-alt')
#                                                                                  ),
#                                                                 
#                                                                 argonSidebarItem('Network',
#                                                                                  tabName = 'Network',
#                                                                                  icon = icon('project-diagram')
#                                                                                  )
#                                                                 )
#                                                             )
#                                  )
#         )
# )

source("sidebar.R")
source("navbar.R")
source("header.R")

source('cards_tab.R')
source('landing_page.R')
source('map_UI.R')
source('network_UI.R')
#source("footer.R")


shinyUI(
    argonDashPage(title = 'Sync the City',
                  description = 'Testing',
                  navbar = argonNav,
                  header = argonHeader,
                  sidebar = argonSidebar,
                  body = argonDashBody(
                      argonTabItems(
                          cards_tab,
                          landing_page,
                          map_UI,
                          network_UI
                      )
                  ) 
    )
)