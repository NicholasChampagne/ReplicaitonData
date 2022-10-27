fluidPage(
  
  # App title ----
  titlePanel("Nicholas Champagne Datasets"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Text for providing a caption ----
      # Note: Changes made to the caption in the textInput control
      # are updated in the output area immediately as you type
      textInput(inputId = "caption",
                label = "Caption:",
                value = "Datasets"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("mtcars", "USArrests","uspop", "Fire Emblem")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   min=0,
                   value = 10),
      
      #Input: Sorting methods ----
      selectInput(inputId = "sort",
                  label = "Sort method",
                  choices = c("Low to High", "High to Low")),
      
      #Input: Variable to Sort by ----
      uiOutput("sortvar"),
      
      #Input: Checkbox entry to filter data ----
      uiOutput("checkbox")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption", container = span)),
      
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view"),
      
    )
  )
)