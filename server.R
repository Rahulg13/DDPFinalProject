library(shiny)
library(dplyr)
library(plotly)
shinyServer(function(input, output){
        #background data processing
        gdp <- read.csv("GDPdata.csv")
        x1 <- which(gdp$Country.Code == "IND")
        x2 <- which(gdp$Country.Code == "CHN")
        x3 <- which(gdp$Country.Code == "USA")
        country <- c(x1, x2, x3)
        gdp <- gdp %>% select(-c(1, 3:14)) %>% filter(Country.Code %in% c("IND", "CHN", "USA"))
        col2 <- unlist(t(gdp[, -1]))
        col2 <- as.data.frame(col2)
        colnames(col2) <- c("CHN","IND", "USA")
        ts <- 1:50
        gdp <- cbind(col2, ts)
        
        mean_index <- numeric(0)
        mean_names <- c("CHN","IND", "USA")
        
        output$text <- renderText(
                if ((input$y2 > input$y1)) { "mean found out"}
                else {
                "Please try again with correct output"
                }
        )
        
        output$plot1 <- renderPlotly({
                if ((input$y2 > input$y1)) { 
                        t1 <- input$y1 - 1969
                        t2 <- input$y2 - 1969
                        gdp <- gdp[t1:t2, ]
                        #p <- plot_ly(gdp, x = ~ts, type = "scatter", mode = "Lines")
                        p <- plot_ly()
                        if (input$chn) {
                                p <- p %>% 
                                add_trace(x = ~gdp$ts, y = ~gdp[,1], type = "scatter", mode = "Lines", name = "China")
                        }
                        if (input$ind) {
                                p <- p %>% 
                                add_trace(x = ~gdp$ts, y = ~gdp[,2], type = "scatter", mode = "Lines", name = "India")
                        }
                        if (input$usa) {
                                p <- p %>% 
                                add_trace(x = ~gdp$ts, y = ~gdp[,3],  type = "scatter", mode = "Lines", name = "USA")
                        }
                        p
                        }
                else {
                        p <- plot_ly(gdp, x = ~ts, type = "scatter", mode = "Lines")
                        p
                }
        })
        
        
        output$mean1 <- renderTable({
                if ((input$y2 > input$y1)) { 
                        t1 <- input$y1 - 1969
                        t2 <- input$y2 - 1969
                        gdp <- gdp[t1:t2, ]
                        
                meanx <- as.data.frame(cbind(c("China", "India", "USA"),c(0,0,0)))
                meanx[,2] <- as.numeric(as.character(meanx[,2]))
                if (input$chn) {meanx[1,2] <- mean(gdp[,1])}
                if (input$ind) {meanx[2,2] <- mean(gdp[,2])}
                if (input$usa) {meanx[3,2] <- mean(gdp[,3])}
                
                meanx
                }
                
        })
                
        
})