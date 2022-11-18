fluidPage(
  # Navbar allows for the ui to slit into multiple different pages with different layout parameters
  navbarPage(
    
    # Navbar project name that appears in the top left corner
    "Project",
    
    # First Tab Panel that servers as a landing page to describe the basics of the data before
    # Anything else is said about the data and model ----
    tabPanel("About",
             sidebarLayout(
               sidebarPanel(p("This is the about page to learn about the model!")),
               mainPanel(p("im just useless text"))
             )
    ),
    
    # Page dedicated to the Descriptive statistics of the model ----
    tabPanel("Desc",
             
             # Sidebar-mainpanel layout for Descriptive Statistics
             sidebarLayout(
               
               #Input Parameters for Descriptive Statistics
               sidebarPanel(
                 
                 # Input: Radio Buttons for variable selection
                 radioButtons("DescRadio",
                              label = "Select Varaible:",
                              choices = colnames(crash),
                              selected = "Crash.Severity")
                 
               ),
               mainPanel(
                 
                 # Output: Dynamic plot for Viewing Data
                 plotOutput("DescPlot")
                 
               )
            )
    ),
    
    # Page dedicated to the Inferential statistics of the model ----
    tabPanel("Inf",
             
             # Sidebar-mainpanel layout for Descriptive Statistics
             sidebarLayout(
               
               # Input Parameters for Inferential Statistics
               sidebarPanel(
                 
                 #Input: Check boxes for Models to Display
                 checkboxGroupInput("InfCheck",
                                    label = "Select Models:",
                                    choices = c("Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5"),
                                    selected = c("Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5")
                 )
                 
               ),
               mainPanel(
                 
                 #Output: Plot for viewing results
                 textOutput("InfPlot")
               )
            )
    ),
    
    # Page dedicated to anything else ----
    tabPanel("Other",
             sidebarLayout(
               sidebarPanel(p("text")),
               mainPanel(p("main"))
            )
    )
  )
)