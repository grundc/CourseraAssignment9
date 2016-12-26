#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Learning from an historical disaster!"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
          tags$u(tags$h4("Checkout the titanic data")),
          tags$br(),
          radioButtons("HistoBy", "Histogram by ...",
                       choices = c("Age" = "1","Sex" = "2" ,"Class" = "3"  ,"Fare" = "4" )),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$br(),
          tags$u(tags$h4("Make your prediction --->")),
          tags$br(),
          sliderInput("Age",
                      "What is your age?",
                      min = 1,
                      max = 100,
                      value = 30),
          radioButtons("Sex", "What is your sex?", choices = c('female'='female','male'='male')),
          selectInput("Class", "In which class do you want to travel?", choices = c('First class'='1','Second class'='2', 'Third class'='3'), multiple = F),
          uiOutput("FareSlider")
          
          
    ),

    # Show a plot of the generated distribution
    mainPanel(
          tabsetPanel(type="tabs",
                      tabPanel("Titanic stat",br(),
                               textOutput("labHisto"),
                               plotOutput("titanic"),
                               
                               textOutput("Survived"),
                               tags$div(
                                     tags$h3(textOutput("Result"))
                               ),
                               imageOutput("ResultImage")
                               
                              
                      ),
                      tabPanel("Documentation",br(),
                               includeHTML("Documentation.html")
                      )
            )
    )
  )
))
