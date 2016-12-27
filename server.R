#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(caret)
library(randomForest)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

      titanicdata <- read.csv(url("https://dl.dropboxusercontent.com/u/36380459/titanic_survival_data.csv"), stringsAsFactors=TRUE)
      titanicdata$Survived <- as.factor(titanicdata$Survived)
      titanicdata$Pclass <- as.factor(titanicdata$Pclass)
      # load randomForest model "rf"
      load(url("https://dl.dropboxusercontent.com/u/36380459/titanicRFmodel.RData"))
      
      output$labHisto <- renderText({"Distribution of surviving passengers"})
      
      output$titanic <- renderPlot({

            
            if (input$HistoBy == "1")
            {

                  g <- ggplot(data=titanicdata, aes(x=Age, fill=Survived)) + geom_histogram(col="black", alpha=.5)
                  g
                  # hist(titanicdata$Age,  col = 'darkgray', border = 'white')
            }
            else if (input$HistoBy == "2")
            {

                  g <- ggplot(data=titanicdata, aes(x=Sex, fill=Survived)) + geom_histogram(col="black", alpha=.5, stat = "count")
                  g
            }
            else if (input$HistoBy == "3")
            {

                  g <- ggplot(data=titanicdata, aes(x=Pclass, fill=Survived)) + geom_histogram(col="black", alpha=.5, , stat = "count")
                  g
            }
            else if (input$HistoBy == "4")
            {

                  g <- ggplot(data=titanicdata, aes(x=Fare, fill=Survived)) + geom_histogram(col="black", alpha=.5)
                  g
            }


      })
      
      output$Survived <- renderText({
            varAge <- input$Age
            varClass <- input$Class
            varFare <- input$Fare
            varSex <- input$Sex
            
            "Your prediction:"
            })
      
      output$Selection <-  renderText({
        varAge <- input$Age
        varClass <- input$Class
        varFare <- input$Fare
        varSex <- input$Sex
        
        paste("Your selection: Age = ", varAge, " Passenger class = ", varClass, " Far = " , varFare, " Gender = ",varSex)
      })
      

      
      output$ResultImage <- renderImage({
            varAge <- input$Age
            varClass <- as.numeric(input$Class)
            varFare <- as.numeric(input$Fare)
            varSex <- input$Sex
            
            newData <- data.frame(Age=varAge, Pclass=varClass, Fare=varFare, Sex = varSex)
            result <- predict(rf, newData)
            if (result == "1") { 
                  list(
                  src = "checked.png",
                  contentType = "image/png"
                 )
                  }  
            else { 
                  list(
                  src = "cancel.png",
                  contentType = "image/png"
                  
                 )
                  }
       
      }, deleteFile = FALSE)
      
      output$FareSlider <- renderUI({
            
            
            inputClass <- input$Class
            
            valMin <- as.integer(min(select(filter(titanicdata,Pclass==inputClass, Fare >0), Fare)))
            valMax <- as.integer(max(select(filter(titanicdata,Pclass==inputClass, Fare >0), Fare)))
            valMean <- as.integer(mean(select(filter(titanicdata,Pclass==inputClass, Fare >0), Fare)))
            
            sliderInput("Fare",
                        "What did you pay?",
                        min = valMin,
                        max = valMax,
                        value = valMean)
            
      })
      
     

})
