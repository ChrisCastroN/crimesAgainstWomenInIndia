#####################################################################################
#
# Crimes against women in India : A shiny app with choropleth and chart visualizations
# Designed and developed by : Tinniam V Ganesh
# Date : 15 Oct 2015
# File : server.R
#
#####################################################################################
library(shiny)
library(rgeos)
library(maptools)
library(ggplot2)
library(dplyr)
library(stringr)
# Load the India shape files
load(file="./IND_adm/IND_adm1.RData")
ind <- fortify(ind, region = "NAME_1")

# Load the crime data
load(file="./data/crimes.RData")
names(b)

# Set the year
year <- c("2001","2002","2003","2004","2005","2006","2007","2008",
          "2009","2010","2011","2012","2013","2014","2015","2016",
          "2017","2018")
source("./stateCrime.R", local=TRUE)
states = b$state

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    
    # Update the drop down box with the year. Make the drop down visible after it loads
    updateSelectizeInput(session, 'id', choices = year, server = TRUE,selected="2001")
    toggle("inputBox")
    toggle("id")
    
    #Update the drop down in state wise tab with states
    updateSelectizeInput(session, 'state', choices = states, server = TRUE,selected="Assam")
    toggle("inputBox1")
    toggle("state")
    
    # Display the choropleth map
    output$distPlot <- renderPlot({  
        plotMap(b,input$radio,input$id)
    })
    
    # Display the state wise crime plot
    output$statePlot <- renderPlot({  
        print(input$radio1)
        print(input$state)
        if(input$state==""){
            theState <-"Assam"
        }
        plotCrime(b,input$state,input$radio1)
    })
    
})
