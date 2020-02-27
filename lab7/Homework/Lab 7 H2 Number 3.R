if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")

if (!require("shiny")) install.packages('shiny')
library("shiny")

if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")

options(scipen=999)

UC_admit <- readr::read_csv("data/UC_admit.csv") %>% 
  mutate_at(vars(Ethnicity), as.factor) %>% 
  mutate_at(vars(Academic_Yr), as.factor)

ui <- dashboardPage(
  dashboardHeader(title = "Plot UC Admissions App"),
  dashboardSidebar(),
  dashboardBody(
    selectInput("x", "Select Fill", choices = c("Campus", "Ethnicity", "Category"), 
                selected = "Campus"),
    radioButtons("y", "Would you like a stacked or clustered bar graph?", choices = c("Stacked", "Clustered"), 
                 selected = "Stacked"),
    plotOutput("plot", width = "500px", height = "400px"))
)


server <- function(input, output, session) { 
  # the code to make the plot of UC data with fill as the choice.
  output$plot <- renderPlot({
    if(input$y=="Stacked"){
      UC_admit %>% 
        group_by(Ethnicity, Academic_Yr, Campus, Category) %>% 
        filter(Ethnicity != "All") %>% 
        summarise(sum = sum(FilteredCountFR)) %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "sum", fill = input$x))+ theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                  element_text(size  = 10,
                                                                                               angle = 45,
                                                                                               hjust = 1,
                                                                                               vjust = 1)) + geom_bar(stat = "identity") + labs(title = "Admissions by Academic Year", x = "Academic Year",
                                                                                                                                                y = "Filtered Count FR") 
    }
    
    else{
      UC_admit %>% 
        group_by(Ethnicity, Academic_Yr, Campus, Category) %>% 
        filter(Ethnicity != "All") %>% 
        summarise(sum = sum(FilteredCountFR)) %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "sum", fill = input$x))+ theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                  element_text(size  = 10,
                                                                                               angle = 45,
                                                                                               hjust = 1,
                                                                                               vjust = 1)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Admissions by Academic Year", x = "Academic Year",
                                                                                                                                                                    y = "Filtered Count FR") 
    }
  })
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)