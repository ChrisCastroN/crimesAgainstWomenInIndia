library(shiny)
library(rgeos)
library(maptools)
library(ggplot2)
library(dplyr)
library(stringr)
#ind <- readShapeSpatial("./IND_adm/IND_adm1.shp")
#save(ind,file="./IND_adm/IND_adm1.RData")
load(file="./IND_adm/IND_adm1.RData")
ind <- fortify(ind, region = "NAME_1")

#b <- read.csv("./data/crimes.csv",stringsAsFactors=FALSE) 
#save(b,file="./data/crimes.RData")
load(file="./data/crimes.RData")
names(b)
#year <- c("X2001","X2002","X2003","X2004","X2005","X2006","X2007","X2008",
#          "X2009","X2010","X2011","X2012","X2013","X2014","X2015","X2016",
#          "X2017","X2018")

year <- c("2001","2002","2003","2004","2005","2006","2007","2008",
          "2009","2010","2011","2012","2013","2014","2015","2016",
          "2017","2018")
source("./stateCrime.R", local=TRUE)
states = b$state

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should re-execute automatically
    #     when inputs change
    #  2) Its output type is a plot
    updateSelectizeInput(session, 'id', choices = year, server = TRUE,selected="2001")
    toggle("inputBox")
    toggle("id")
    updateSelectizeInput(session, 'state', choices = states, server = TRUE,selected="Assam")
    toggle("inputBox1")
    toggle("state")
    output$distPlot <- renderPlot({  
        plotMap(b,input$radio,input$id)
    })
    output$statePlot <- renderPlot({  
        print(input$radio1)
        print(input$state)
        if(input$state==""){
            theState <-"Assam"
        }
        plotCrime(b,input$state,input$radio1)
    })
    
})
