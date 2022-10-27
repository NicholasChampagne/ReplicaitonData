library(shiny)
rsconnect::setAccountInfo(name='2f64pb-william-kilcoyne',
                          token='1D5D88E9B88B016BD44DF262F6A91007',
                          secret='GVL9108MmYEozBV2N7PMy+5NKqM41ThOaToNz6Se')
pokemon <- read.csv("Data/pokemon.csv")
ui <- fluidPage(
  
  
  titlePanel("Pokemon Datasets"),
  
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    numericInput(inputId = "obs",
                 label = "Number of observations to view:",
                 min=0,
                 value = 10)
  ),
  
  mainPanel(
    
    plotOutput("distplot")
    
  )
)


server <- function(input, output) {
  bin <- reactive({
    return(input$bins)
  })
  
  output$distPlot <- renderPlot({
    
    x    <- pokemon[, 2]
    bins <- seq(min(x), max(x), length.out = bin() + 1)
    
    
    hist(x, breaks = bins, col = 'blue', border = 'white',
         xlab = 'Pokemon Stats',
         main = 'Histogram comparing Pokemon stats')
  })
}


shinyApp(ui = ui, server = server)