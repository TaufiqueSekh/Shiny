##Loading R packages
library(shiny)
library(tidyverse)
library(shinydashboard)
library(shinythemes)

## Define UI
ui<- fluidPage(theme = shinytheme("cerulean"),
        navbarPage("My First App",
          tabPanel("Name Print",
              sidebarPanel(
                          h3("Enter your Name"),
                          textInput("text1","First Name"," "),
                          textInput("text2","Middle Name"," "),
                          textInput("text3","Last Name"," "),
                          actionButton("action","Submit")
                          ),
              mainPanel(
                        h1("OUTPUT"),
                        h3("Your Full Name"),
                        verbatimTextOutput("text4"),
                        sliderInput("slider","Slider Input:",1,100,50)
                        ),
                   ),
          tabPanel("Histogram",
                   sidebarPanel(
                     sliderInput("bins",
                                 "Number of bins:",
                                 min = 1,
                                 max = 50,
                                 value = 30)
                   ),
                   
                   # Show a plot of the generated distribution
                   mainPanel(
                     h3("HISTOGRAM PLOT"),
                     plotOutput("distPlot")
                   ),
                   ),
          tabPanel("Navbar 3","Blank"),
            )
          )

## Define server

server <- function(input,output){
  output$text4<-renderText({
    paste(input$text1,input$text2,input$text3,sep=" ")
  })
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
}
## ShinyApp function
shinyApp(ui,server)

