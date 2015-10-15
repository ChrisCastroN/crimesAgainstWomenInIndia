library(shinyjs)
# Define UI for application that draws a histogram
shinyUI(navbarPage(useShinyjs(),
                   "Crimes against women in India",
                   tabPanel("Crime Map of India",
                            # Application title
                            titlePanel("Crime Map of India"),
                            
                            # Sidebar with a slider input for the number of bins
                            fluidRow(
                                column(4,
                                       code(id = "inputBox", "Please wait, loading ..."),
                                       hidden(selectizeInput(
                                           'id', label = "Year", choices = NULL,multiple=FALSE,selected="X2015",
                                           options = list(create = TRUE,placeholder = 'Choose the year'))
                                           
                                       ),
                                       radioButtons("radio", label = h3("Radio buttons"),
                                                    choices = list("RAPE" = "RAPE",
                                                                   "DOWRY DEATH" = "DOWRY DEATH", 
                                                                   "ASSAULT ON WOMEN" = "ASSAULT ON WOMEN WITH INTENT TO OUTRAGE HER MODESTY",
                                                                   "CRUELTY BY HUSBAND OR RELATIVES" = "CRUELTY BY HUSBAND OR RELATIVES",
                                                                   #"IMMORAL TRAFFIC" = "IMMORAL TRAFFIC(PREVENTION)ACT",
                                                                   #"INDECENT REPRESENTATION OF WOMEN" = 'INDECENT REPRESENTATION OF WOMEN(PREVENTION)ACT',
                                                                   "INSULT TO THE MODESTY OF WOMEN"="INSULT TO THE MODESTY OF WOMEN",
                                                                   "KIDNAPPING & ABDUCTION" = "KIDNAPPING & ABDUCTION",
                                                                   "TOTAL CRIMES AGAINST WOMEN" = 'TOTAL CRIMES AGAINST WOMEN'), 
                                                    selected = "RAPE")
                                ),
                                
                                # Show a plot of the generated distribution
                                
                                column(4,
                                       plotOutput("distPlot")
                                ),
                                column(7, offset=4,
                                       tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                       tags$h5((tags$i("Oct 14,2015")))
                                )
                                
                                
                            )      
                            
                            
                            
                   ),
                   tabPanel("Statewise crimes",
                            
                            tabPanel("Statewise crimes",
                                     # Application title
                                     titlePanel("Crimes in each state"),
                                     
                                     # Sidebar with a slider input for the number of bins
                                     fluidRow(
                                         column(4, offset=5,
                                                tags$h5(("Data source:https://data.gov.in"))
                                                
                                         ),
                                         column(4,
                                                code(id = "inputBox1", "Please wait, loading ..."),
                                                
                                                hidden(selectizeInput(
                                                    'state', label = "State", choices = NULL,multiple=FALSE,selected="Andhra Pradesh",
                                                    options = list(create = TRUE,placeholder = 'Choose the state'))
                                                    
                                                ),
                                                radioButtons("radio1", label = h3("Radio buttons"),
                                                             choices = list("RAPE" = "RAPE",
                                                                            "DOWRY DEATH" = "DOWRY DEATH", 
                                                                            "ASSAULT ON WOMEN" = "ASSAULT ON WOMEN WITH INTENT TO OUTRAGE HER MODESTY",
                                                                            "CRUELTY BY HUSBAND OR RELATIVES" = "CRUELTY BY HUSBAND OR RELATIVES",
                                                                            "IMMORAL TRAFFIC" = "IMMORAL TRAFFIC(PREVENTION)ACT",
                                                                            "INDECENT REPRESENTATION OF WOMEN" = 'INDECENT REPRESENTATION OF WOMEN(PREVENTION)ACT',
                                                                            "INSULT TO THE MODESTY OF WOMEN"="INSULT TO THE MODESTY OF WOMEN",
                                                                            "KIDNAPPING & ABDUCTION" = "KIDNAPPING & ABDUCTION",
                                                                            "TOTAL CRIMES AGAINST WOMEN" = 'TOTAL CRIMES AGAINST WOMEN'), 
                                                             selected = "RAPE")
                                         ),
                                         
                                         # Show a plot of the generated distribution
                                         
                                         column(6,
                                                plotOutput("statePlot")
                                         ),
                                         
                                         column(7, offset=4,
                                                tags$h5((tags$i("Designed and developed by Tinniam V Ganesh"))),
                                                tags$h5((tags$i("Oct 14,2015")))
                                         )
                                         
                                     )       
                                     
                            )
                            
                   ),
                   tabPanel('About',
                            h2("Crimes against women in India"),
                            p("This Shiny app displays the  map of crimes against women in India. There are
                               2 tabs. The  1st tab plots a choropleth map for crimes agianst women in India
                                in each year. The 2nd tab plots for each selected state the  crime rate across
                                 the years. The data was available for different crimes against women from the years 2001-2013.
                                Linear regression was used to project the crime rate for the next 5 years
                               till 2018,"),
                               p("The data for this Shiny app has been taken from https://data.gov.in/catalog/crime-against-women"),
                               p("More details about this app and for other posts, see my blog
                               http://gigadom.wordpress.com/")
                   )
                   
                   
))

