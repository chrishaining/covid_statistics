#
# This is a Shiny web application. 

# imports and global variables
library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
data <- read_csv('../covid_19_deaths.csv')

ukDailyDeaths <- data %>% mutate(`New Deaths`=c(`UK Deaths`[1], diff(`UK Deaths`)))
ukDailyDeaths <- ukDailyDeaths %>% select(-`Global Deaths`)
ukDailyDeaths

#link <- https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("UK Daily Number of Deaths from Covid-19"),

 
        mainPanel(
           plotOutput("chart")
        )
    )


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$chart <- renderPlot({
        
        ggplot(ukDailyDeaths, aes(x=`Date`, y=`New Deaths`)) + geom_col(fill='steelblue') + geom_text(aes(label=`New Deaths`), vjust=1.6, color="black", size=4.5, fontface = "bold") + theme_minimal()
    }, height = 800, width = 1500)
    
}

# Run the application 
shinyApp(ui = ui, server = server)
