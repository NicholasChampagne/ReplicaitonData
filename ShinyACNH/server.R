function(input, output) {
#Output Data specification ----
  #Linked to input$type, sets if you want bugs, fish, or both
  type <- reactive({
    switch (input$type,
      "Both" = c("Bug", "Fish"),
      "Bugs" = "Bug",
      "Fish" = "Fish" )
    
  })
  
 #Linked to input$month, sets the month value to determine availability
  month <- reactive({
    switch(input$month,
           "January" = 1,
           "Feburary"= 2,
           "March"= 3,
           "April" = 4,
           "May" = 5,
           "June" = 6,
           "July" = 7,
           "August" = 8,
           "September" = 9,
           "October" = 10,
           "November" = 11,
           "December" = 12 )
    })
  
  #Linked to input$sortby, sets sorting method
  sorloc <- reactive({
    switch (input$sortby,
      "Location" = "Location",
      "Value" = "Value")
  })
  
 #Subset the data based off of month availability
  filter1 <- reactive({
    #Loading in the data to subset later
    data <- animal
    #creating a vector that will be used to determine which rows to keep
    vmon <- rep(0, nrow(data))
    
    #If statements to decide which rows to keep
    for(i in 1:nrow(data)){
      if (!is.na(data[i,"Month3"])) {
        if (data[i,"Month1"] > data[i,"Month3"]) {
          if (data[i,"Month1"] > data[i,"Month2"]) {
            if (month() %in% data[i,"Month1"]:12 | month() %in% 1:data[i,"Month2"] | month() %in% data[i,"Month3"]:data[i,"Month4"]) { vmon[i] <- i } else { vmon[i] <- 0 }
          } else { if (month() %in% data[i,"Month1"]:data[i,"Month2"] | month() %in% data[i,"Month3"]:data[i,"Month4"] ) { vmon[i] <- i } else { vmon[i] <- 0 } }
        } else { if (month() %in% data[i,"Month1"]:data[i,"Month2"] | month() %in% data[i,"Month3"]:data[i,"Month4"] ) { vmon[i] <- i } else { vmon[i] <- 0 } }
      } else { if (data[i,"Month1"] > data[i,"Month2"]) {
        if (month() %in% data[i,"Month1"]:12 | month() %in% 1:data[i,"Month2"]) { vmon[i] <- i } else { vmon[i] <- 0 }
      } else { if (month() %in% data[i,"Month1"]:data[i,"Month2"]) { vmon[i] <- i } else { vmon[i] <- 0 } }
      }
    }
    
    #data subset on month
    data <- data[c(vmon),]
    
    #data subset on area
    data <- subset(data,Type %in% type())
    
    #Return data
    return(data)
    
  })
  
 #Linked to input$area
  output$area <- renderUI({
    data <- filter1()
    checkboxGroupInput(inputId = "area",
                       label = "Locations:",
                       choices = unique(data[,"Location"]),
                       selected = unlist(unique(data[,"Location"])))
    
  })
  
  
  #Final Subset based on location
  filterdata <- reactive({
    #Load Data
    data <- filter1()
    
    #Subset
    return(subset(data, Location %in% c(input$area)))
    
  })
  
# Plot Outputs ----
  #Linked to input$plot, creates time plot 
  output$plot <- renderPlot({
    
    #Changing reactive data into a data frame to allow for reference
    data <- filterdata()
    
    #Creating data frame skeleton to pass onto for loop
    data.graph <- data.frame("Name" = rep(data$Name, each = 5),
                             "Time" = rep(0,nrow(data)*5),
                             "Active" = rep(0,nrow(data)*5,
                             "Location" = rep(data$Location, each = 5))
    ) 
    #Logic to create data to pass onto graph, puts data into long format, with several other parameters
    for(i in 1:nrow(data)){
      #Gross Logic to determine bar plot stack length.
      #This creates the length for each bar in the bar stack which will represent hour blocs in the day.
      data.graph[5*(i-1)+1, "Time"] <- sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1]
      data.graph[5*(i-1)+2, "Time"] <- sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[2] - sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1]
      data.graph[5*(i-1)+3, "Time"] <- ifelse(is.na(data[i,"Time3"]),24 - sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[2],sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[3] - sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[2])
      data.graph[5*(i-1)+4, "Time"] <- ifelse(is.na(data[i,"Time3"]),0,sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[4] - sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[3])
      data.graph[5*(i-1)+5, "Time"] <- ifelse(is.na(data[i,"Time3"]),0,24 - sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[4])
      #Even more Gross logic to determine if the fish is catch-able for each stack of the bar plot. 
      data.graph[5*(i-1)+1, "Active"] <- ifelse(sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time1")]) | (sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time3")]) & !is.na(as.numeric(data[i,c("Time3")]))), F, T)
      data.graph[5*(i-1)+2, "Active"] <- ifelse(sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time1")]) | (sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time3")]) & !is.na(as.numeric(data[i,c("Time3")]))), T, F)
      data.graph[5*(i-1)+3, "Active"] <- ifelse(sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time1")]) | (sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time3")]) & !is.na(as.numeric(data[i,c("Time3")]))), F, T)
      data.graph[5*(i-1)+4, "Active"] <- ifelse(sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time1")]) | (sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time3")]) & !is.na(as.numeric(data[i,c("Time3")]))), T, F)
      data.graph[5*(i-1)+5, "Active"] <- ifelse(sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time1")]) | (sort(as.numeric(data[i,c("Time1", "Time2", "Time3", "Time4")]))[1] == as.numeric(data[i,c("Time3")]) & !is.na(as.numeric(data[i,c("Time3")]))), F, T)
    }
    #Pretty colors for vertical lines
    linecol <- rep(0,25)
    for(i in 0:24){
      v <- (12 - abs(12 - i))/(12)
      linecol[i] <- rgb(1*v, 1*v, 0, 1) }
      
    
    #Creating the Barplot
    bar <- ggplot(data.graph, aes(x = Name, y = Time)) + geom_bar(stat = "identity", fill = c(ifelse(data.graph$Active != 0, "steelblue", rgb(1,1,1,0)))) + coord_flip() + theme(
      panel.background = element_rect(fill = "white", color = "white"),
      panel.grid = element_blank(),
      axis.text.x = element_text(size = 15), 
      axis.text.y = element_text(size = 15),
      plot.title = element_text(size = 20)
    ) + labs(title = "Catchable Animals", y = "Hour", x = "Name") + geom_hline(yintercept = 0:24, linetype = "dashed", color = linecol, size = .5) + scale_y_continuous(limit = c(0,24), breaks = seq(0,24,1))
   #graph barplot
     return(bar)
  })
  
  
  #Table Output
  output$view <- renderTable({
    
    #Changing reactive data into a data frame to allow for reference
    data <- filterdata()
    
    #Generate Table to show fish output
    head(data[order(data[,sorloc()], decreasing = T),1:5], n = nrow(data))
  })
  
}
