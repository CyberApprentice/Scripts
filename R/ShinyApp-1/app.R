library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)
library(plotly)
library(DT)
library(rlang)

# Load relevant dataset
load(url("https://github.com/trepersec/Scripts/raw/master/R/ShinyApp-1/literacy-data.RData"))


ui <- dashboardPage(
    # Header ----
    dashboardHeader(title = "Global Literacy Data"),
    
    # Sidebar ----
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"), selected = TRUE),
            menuItem("Dataset", tabName = "dataset", icon = icon("glyphicon glyphicon-th-list", lib = "glyphicon")),
            menuItem("About", icon= icon("glyphicon glyphicon-info-sign", lib = "glyphicon"), tabName = "about",
                     menuSubItem("R Code (GitHub)", icon = icon("send",lib='glyphicon'), newtab = TRUE,
                                 href = "https://github.com/trepersec/Scripts/tree/master/R/ShinyApp-1"),
                     menuSubItem("About the Data", icon = icon("glyphicon glyphicon-edit", lib = "glyphicon"), tabName = "references"))
            # icons = https://getbootstrap.com/docs/3.4/components/#glyphicons
        )
    ),
    # Body ----
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "dashboard", 
                h3("Dashboard"),
                fluidRow(
                    valueBoxOutput("records", width = 3),
                    valueBoxOutput("differenceOverTime", width = 3),
                    valueBoxOutput("averageLitRate", width = 3),
                    verbatimTextOutput("summary")
                ),
                fluidRow(
                    column(width = 4,
                           box(
                               title = "User Input",
                               width = NULL,
                               selectInput(inputId = "indicator", 
                                           label = "Dataset:",
                                           choices = sort(unique(literacyData$Indicator.Name)), 
                                           selected = "Literacy rate, adult total (% of people ages 15 and above)"), # this value is selected becuase it will showcase the most datapoints to plot - 49
                               selectInput(inputId = "countryName", 
                                           label = "Country/Region/Provice/etc. Name:",
                                           choices = sort(unique(literacyData$Country.Name)), 
                                           selected = "Middle East & North Africa (IDA & IBRD countries)"), # this value is selected becuase it will showcase the most datapoints to plot - 49
                               selectInput(inputId = "x_axis_min", 
                                           label = "Choose x-axis (Year) min:", 
                                           choices = c(1960:2018),
                                           selected= 1960),
                               
                               selectInput(inputId = "x_axis_max",
                                           label = "Choose x-axis (Year) max:", 
                                           choices = c(1961:2020),
                                           selected= 2020),
                               
                               selectInput(inputId = "x_axis_int",
                                           label = "Choose the x-axis (Year) interval:", 
                                           choices = c(1:100),
                                           selected= 10),
                               
                               selectInput(inputId = "y_axis_int",
                                           label = "Choose the y-axis (Value) interval:", 
                                           choices = c(1:50),
                                           selected= 25),
                               
                               selectInput(inputId = "y_axis_min",
                                           label = "Choose the y-axis (Value) min:", 
                                           choices = c(0:99),
                                           selected= 0),
                               
                               selectInput(inputId = "y_axis_max",
                                           label = "Choose the y-axis (Value) max:", 
                                           choices = c(1:100),
                                           selected= 100),
                               
                               checkboxInput(inputId ='connect_dots',
                                             label = 'Convert scatter plot into line plot',
                                             value = FALSE),
                               
                               checkboxInput(inputId ='trend_line',
                                             label = 'Plot linear regression line',
                                             value = FALSE),
                               
                               checkboxInput(inputId ='horizontalMean',
                                             label = 'Plot horizontal mean line',
                                             value = FALSE)
                           )
                           
                    ),
                    
                    column(width = 8,
                           box(
                               title = "Literacy Plot",
                               width = NULL,
                               plotlyOutput("literacyPlot"),
                               downloadButton("downloadPlot", "Download Plot")
                           ),
                           box(
                               title = "Frequency counter based on applied filters (excluding country)",
                               width = NULL,
                               dataTableOutput("freqDT")
                           )
                    )
                )
            ),
            tabItem(
                tabName = "references",
                box(width = NULL,
                    tags$h3("Data description"),
                        tags$p("The data represents", nrow(literacyData), "records of different age groups who can both read and write with understanding a short simple statement about their everyday life released between 1960 to 2019 from countries the world."),
                    tags$hr(),
                    tags$h3("References"),
                        tags$p("The data was obtained from the following sources:",
                            tags$br(), tags$br(),
                            tags$a("The World Bank - Literacy rate, youth total (% of people ages 15-24)", href = "https://data.worldbank.org/indicator/SE.ADT.1524.LT.ZS"), 
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, youth female (% of females ages 15-24)", href = "https://data.worldbank.org/indicator/SE.ADT.1524.LT.MA.ZS"), 
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, youth male (% of males ages 15-24)", href = "https://data.worldbank.org/indicator/SE.ADT.1524.LT.MA.ZS"),
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, youth (ages 15-24), gender parity index (GPI)", href = "https://data.worldbank.org/indicator/SE.ADT.1524.LT.FM.ZS"),
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, adult female (% of females ages 15 and above)", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.FE.ZS"), 
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, adult male (% of males ages 15 and above)", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.MA.ZS"),
                            tags$br(),
                            tags$a("The World Bank - Literacy rate, adult total (% of people ages 15 and above)", href = "https://data.worldbank.org/indicator/SE.ADT.LITR.ZS")),
                    tags$hr(),
                    tags$h3("Author"),
                        tags$p("This project was created by Trevon Perry for a school project. Thank you for viewing and best wishes to you!")
                    )
            ),
            tabItem(
                tabName = "dataset", 
                dataTableOutput("completeDT"),
                downloadButton("downloadDT", "Download Dataset")
            )
        )
    )
)

server <- function(input, output, session) {
    
    reactDT <- reactive({
        
        react = subset(literacyData, literacyData$Indicator.Name==input$indicator &
                           literacyData$Country.Name ==input$countryName &
                           literacyData$Year >= as.numeric(input$x_axis_min) &
                           literacyData$Year <= as.numeric(input$x_axis_max) &
                           literacyData$Value >= as.numeric(input$y_axis_min) &
                           literacyData$Value <= as.numeric(input$y_axis_max))
        return(react)
    })
    # this is separated to make it easier to download
    plotlyPlot = function() {
        ggplot(data = reactDT(), aes(x = reactDT()$Year , y = reactDT()$Value)) + geom_point() +
        theme_classic() + 
        xlab("Year")  + ylab("Literacy Percentage Rate (%)") + 
        scale_x_continuous(breaks=(seq(input$x_axis_min, input$x_axis_max, as.numeric(input$x_axis_int))), limits = c(as.numeric(input$x_axis_min), as.numeric(input$x_axis_max))) +
        scale_y_continuous(breaks=(seq(input$y_axis_min, input$y_axis_max, as.numeric(input$y_axis_int))), limits = c(as.numeric(input$y_axis_min), as.numeric(input$y_axis_max))) +
        {if(input$connect_dots == TRUE) stat_summary(geom="line", colour="green") } + 
        {if(input$horizontalMean == TRUE) geom_hline(yintercept=round(mean(reactDT()$Value), 2), linetype="dashed", color = "royalblue") } + 
        {if(input$trend_line == TRUE) stat_smooth(method="lm", se=FALSE, color = "#FC4E07", fill = "#FC4E07") }
    }
    output$literacyPlot<-renderPlotly({
       plotlyPlot()
    })
    
    output$records = renderValueBox ({
        dataset = subset(literacyData$Value, literacyData$Indicator.Name == input$indicator &
                             literacyData$Country.Name == input$countryName &
                             literacyData$Year >= as.numeric(input$x_axis_min) &
                             literacyData$Year <= as.numeric(input$x_axis_max) &
                             literacyData$Value >= as.numeric(input$y_axis_min) &
                             literacyData$Value <= as.numeric(input$y_axis_max))
        math = sum(!is.na(dataset))
        if (math == 0)
        {
            valueBox(math, "Number of plotted data points with current inputs", color = "black") 
        }
        else
        {
            valueBox(math, "Number of plotted data points with current inputs")
        }
        
    })
    output$differenceOverTime = renderValueBox ({
        dataset = subset(literacyData$Value, literacyData$Indicator.Name == input$indicator &
                             literacyData$Country.Name == input$countryName &
                             literacyData$Year >= as.numeric(input$x_axis_min) &
                             literacyData$Year <= as.numeric(input$x_axis_max) &
                             literacyData$Value >= as.numeric(input$y_axis_min) &
                             literacyData$Value <= as.numeric(input$y_axis_max))
        if(is_empty(dataset)) # check if there are data points within the given values
        {
            valueBox(NA, "Average of the total gain/loss (%)", color = "black") 
        }
        else
        {
            math = mean(diff(dataset)/dataset[-length(dataset)])
            math = scales::percent(math, accuracy = .01) # convert to percent
            if(math < 0) # if it is negative, make the box red
            {
                valueBox(math, "Average of the total gain/loss (%)", color = "red")
            }
            else if (math == 0) # if it equal 0, make it yellow1
            {
                valueBox(math, "Average of the total gain/loss (%)", color = "yellow") 
            }
            else # if it is positive, make the box green
            {
                valueBox(math, "Average of the total gain/loss (%)", color = "green") 
            }
        }
        
    })
    output$averageLitRate = renderValueBox ({
        dataset = subset(literacyData$Value, literacyData$Indicator.Name == input$indicator &
                             literacyData$Country.Name == input$countryName &
                             literacyData$Year >= as.numeric(input$x_axis_min) &
                             literacyData$Year <= as.numeric(input$x_axis_max) &
                             literacyData$Value >= as.numeric(input$y_axis_min) &
                             literacyData$Value <= as.numeric(input$y_axis_max))
        math = paste0(round(mean(dataset), 2), "%")
        
        if (math == "NaN%")
        {
            valueBox(NA, "Average Literacy Rate (%)", color = "black") 
        }
        else
        {
            valueBox(math, "Average Literacy Rate (%)")
        }
    })
    output$freqDT = renderDataTable ({
        dataset = subset(literacyData, 
                         literacyData$Indicator.Name == input$indicator &
                             literacyData$Year >= as.numeric(input$x_axis_min) &
                             literacyData$Year <= as.numeric(input$x_axis_max) &
                             literacyData$Value >= as.numeric(input$y_axis_min) &
                             literacyData$Value <= as.numeric(input$y_axis_max))
        as.data.frame(table(Country = dataset$Country.Name))
    })
    output$completeDT = renderDataTable ({
        literacyData
    })
    output$downloadPlot <- downloadHandler(
        filename = function() { paste0('Plot.png') },
        content = function(file) {
            ggsave(file, plot = plotlyPlot(), device = "png")
        }
    )
    output$downloadDT <- downloadHandler(
        filename = function() {
            paste("LiteracyDataset.csv")
        },
        content = function(file) {
            write.csv(literacyData, file, row.names = FALSE)
        }
    )
    output$summary <- renderPrint({
        width = 3
        dataset = subset(literacyData$Value, literacyData$Indicator.Name == input$indicator &
                             literacyData$Country.Name == input$countryName &
                             literacyData$Year >= as.numeric(input$x_axis_min) &
                             literacyData$Year <= as.numeric(input$x_axis_max) &
                             literacyData$Value >= as.numeric(input$y_axis_min) &
                             literacyData$Value <= as.numeric(input$y_axis_max))
        cat(paste0('\nSummary Data:\n'))
        summary(dataset)
    })
}


shinyApp(ui, server)

# Deploy to shinyapps.io
#library(rsconnect)
#setwd('C:/') # location of app.R and .data
#deployApp(appName = "literacyData")
