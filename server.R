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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

      titanicdata <- read.csv(url("https://dl.dropboxusercontent.com/u/36380459/titanic_survival_data.csv"), stringsAsFactors=TRUE)
      # load randomForest model "rf"
      load(url("https://dl.dropboxusercontent.com/u/36380459/titanicRFmodel.RData"))
      
      output$labHisto <- renderText({"My label"})
      
      output$titanic <- renderPlot({

            
            if (input$HistoBy == "1")
            {

                  g <- ggplot(data=titanicdata, aes(x=Age, fill=as.factor(Survived))) + geom_histogram(col="black", alpha=.5)
                  g
                  # hist(titanicdata$Age,  col = 'darkgray', border = 'white')
            }
            else if (input$HistoBy == "2")
            {

                  g <- ggplot(data=titanicdata, aes(x=Sex, fill=as.factor(Survived))) + geom_histogram(col="black", alpha=.5, stat = "count")
                  g
            }
            else if (input$HistoBy == "3")
            {

                  g <- ggplot(data=titanicdata, aes(x=as.factor(Pclass), fill=as.factor(Survived))) + geom_histogram(col="black", alpha=.5, , stat = "count")
                  g
            }
            else if (input$HistoBy == "4")
            {

                  g <- ggplot(data=titanicdata, aes(x=Fare, fill=as.factor(Survived))) + geom_histogram(col="black", alpha=.5)
                  g
            }


      })
      
      output$Survived <- renderText({
            varAge <- input$Age
            varClass <- input$Class
            varFare <- input$Fare
            varSex <- input$Sex
            
            paste("Did you survive? Your selection: ", varAge, varClass, varFare, varSex)
            })
      
      output$Result <- renderText ({
            
            varAge <- input$Age
            varClass <- as.numeric(input$Class)
            varFare <- as.numeric(input$Fare)
            varSex <- input$Sex
            
            newData <- data.frame(Age=varAge, Pclass=varClass, Fare=varFare, Sex = varSex)
            result <- predict(rf, newData)
            if (result == "1") {"Yes"}  else {"No "}
            
            
      })
      
      output$ResultImage <- renderImage({
            varAge <- input$Age
            varClass <- as.numeric(input$Class)
            varFare <- as.numeric(input$Fare)
            varSex <- input$Sex
            
            newData <- data.frame(Age=varAge, Pclass=varClass, Fare=varFare, Sex = varSex)
            result <- predict(rf, newData)
            if (result == "1") { 
                  return(list(
                  src = "checked.png",
                  contentType = "image/png",
                  alt = "Checked"))
                  }  
            else { 
                  return(list(
                  src = "cancle.png",
                  contentType = "image/png",
                  alt = "Cancel"))
                  }
       
      })
      
      output$FareSlider <- renderUI({
            
            valMin <- 1
            valMx <- 1000
            valMean <- 500
            
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
