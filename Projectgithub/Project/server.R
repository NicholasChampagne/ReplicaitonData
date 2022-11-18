function(input, output){
  # Input parameters ----
  InfModel <- reactive({
    as.numeric(gsub("Stage ", "", input$InfCheck))
  })
  
  
  # Output functions ----
  output$DescPlot <- renderPlot({
    plot <- plot(x = 1:10, y = 1:10,
                 main = input$DescRadio)
    
  })
  
  output$InfPlot <- renderText({
    c(InfModel())
  })
  
}