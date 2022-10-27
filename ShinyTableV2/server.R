function(input, output) {
  
  # Return the requested dataset ----
  # By declaring datasetInput as a reactive expression we ensure
  # that:
  #
  # 1. It is only called when the inputs it depends on changes
  # 2. The computation and result are shared by all the callers,
  #    i.e. it only executes a single time
  datasetInput <- reactive({
    switch(input$dataset,
           "mtcars" = mtcars,
           "USArrests"=USArrests,
           "uspop"=uspop,
           "Fire Emblem" = feadt)
  })
  
  datasetSort <- reactive({
    switch(input$sort,
           "Low to High" = F,
           "High to Low" = T
           )
  })
  
  #Render dynamic checkbox to filter data
  #Checkbox list needs to be read with input${NAME} to pass unto other functions
  output$checkbox <- renderUI({
    choice <- colnames(datasetInput())
    checkboxGroupInput("checkbox", "Select Variables", choices = choice, selected = unlist(choice))
  })
  
  #Render Dynamic Radio Button to sort data
  output$sortvar <- renderUI({
    choice <- colnames(datasetInput())
    radioButtons("sortvar", "Variable to sort by:", choices = choice)
  })
  
  # Create caption ----
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  # 1. This function is automatically called to recompute the output
  # 2. New caption is pushed back to the browser for re-display
  #
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$caption, those expressions are
  # NOT called when input$caption changes
  output$caption <- renderText({
    input$caption
  })
  
  # Generate a summary of the dataset ----
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated, i.e. whenever the input$dataset changes
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset[,c(input$checkbox), drop = F])
  })
  
  # Show the first "n" observations ----
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so it will be re-executed whenever
  # input$dataset or input$obs is changed
  output$view <- renderTable({
    dataset <- datasetInput()
    head(dataset[order(dataset[,input$sortvar], decreasing = datasetSort()),c(input$checkbox), drop = F], n = input$obs)
  })
}