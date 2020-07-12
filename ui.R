library(shiny)
library(plotly)
shinyUI(fluidPage(
        titlePanel("Comparing the GDP growth rates of countries"),
        sidebarLayout(
                sidebarPanel(
                        # get the input for processing here
                        h2("Select the Countries"),
                        checkboxInput("chn", "China"),
                        checkboxInput("ind", "India"),
                        checkboxInput("usa", "USA"),
                        h2("Select the range of years"),
                        h3("Starting year"),
                        sliderInput("y1", "Year to start with", 1970, 2019, 1),
                        h3("End year"),
                        sliderInput("y2", "Year to end with", 1970, 2019, 1)
                ),
                mainPanel(
                        #Display the results here
                        textOutput("text"),
                        plotlyOutput("plot1"),
                        tableOutput("mean1")
                )
        )
)
        
)