argonSidebar <- argonDashSidebar(
  vertical = FALSE,
  skin = "light",
  background = "white",
  size = "md",
  #side = "left",
  id = "my_sidebar",
  brand_url = "http://www.google.com",
  brand_logo = "https://demos.creative-tim.com/argon-design-system/assets/img/brand/blue.png",
  
  # dropdownMenus = argonDropNav(
  #   title = "Dropdown Menu", 
  #   src = "https://demos.creative-tim.com/argon-dashboard/assets/img/theme/team-4-800x800.jpg", 
  #   orientation = "right",
  #   argonDropNavTitle(title = "Welcome!"),
  #   argonDropNavItem(
  #     title = "Item 1", 
  #     src = "https://www.google.com", 
  #     icon = argonIcon("single-02")
  #   ),
  #   argonDropNavItem(
  #     title = "Item 2", 
  #     src = NULL, 
  #     icon = argonIcon("settings-gear-65")
  #   ),
  #   argonDropNavDivider(),
  #   argonDropNavItem(
  #     title = "Item 3", 
  #     src = "#", 
  #     icon = argonIcon("calendar-grid-58")
  #   )
  # ),
  # 
  argonSidebarHeader(title = "Main Menu"),
  
  argonSidebarMenu(
    argonSidebarItem(
      tabName = "cards",
      icon = argonIcon(name = "tv-2", color = "info"),
      "Cards"
    ),
    
    argonSidebarItem(
      tabName = "landing_page",
      icon = argonIcon(name = "tv-1", color = "green"),
      "Landing Page"
    ),
    
    argonSidebarItem(
      tabName = "map_UI",
      icon = argonIcon(name = "planet", color = "warning"),
      "Map"
    ),
    
    argonSidebarItem(
      tabName = "network_UI",
      icon = argonIcon(name = "circle-08", color = "success"),
      "Network"
    )
  )
)