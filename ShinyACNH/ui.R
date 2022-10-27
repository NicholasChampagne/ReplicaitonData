fluidPage(
  
  # App title ----
  titlePanel("Animal Crossing New Horizons Animal Catch Times"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #Input: Selector for choosing animal type ----
      selectInput(inputId = "type",
                  label = "Select Animal Type:",
                  choices = c("Both", "Bugs", "Fish"),
                  selected = "Fish" ),
      
      # Input: Selector for choosing Month ----
      selectInput(inputId = "month",
                  label = "Select Month:",
                  choices = c("January", "Feburary","March", "April", "May", "June", "July", "August", "September", "October", "November", "December"),
                  selected = "January"),
      
      #Input: Selector for sort method
      radioButtons(inputId = "sortby",
                   label = "Sort by:",
                   choices = c("Location", "Value"),
                   selected = "Value"),
      
      #Input: Check box for Locations
      uiOutput("area")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Plot of Time slots ----
      plotOutput("plot", height = 1200),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view"),
      
      
      tableOutput("diag")
    )
  )
)