if (!require("tidyverse")) install.packages('tidyverse')
library("tidyverse")

if (!require("shiny")) install.packages('shiny')
library("shiny")

if (!require("shinydashboard")) install.packages('shinydashboard')
library("shinydashboard")

if(!require("ggplot2")) install.packages('ggplot2')
library("ggplot2")

options(scipen=999)

UC_admit <- readr::read_csv("data/UC_admit.csv") %>% 
  mutate_at(vars(Ethnicity), as.factor) %>% 
  mutate_at(vars(Academic_Yr), as.factor)

ui <- dashboardPage(
  dashboardHeader(title = "Plot UC App"),
  dashboardSidebar(),
  dashboardBody(
    selectInput("x", "Select Fill", choices = c("Campus", "Ethnicity"), 
                selected = "Campus"),
    radioButtons("z", "Would you like a stacked bar graph or clustered bar graph?", choices = c("Stacked", "Clustered"), 
                 selected = "Stacked"),
    radioButtons("y", "What would group would you like to view?", choices = c("Applicants", "Admits", "Enrollees"), 
                 selected = "Admits"),
    helpText("Reference: University of California Information Center"),
    plotOutput("plot", width = "500px", height = "400px"))
)

server <- function(input, output, session) { 
  # the code to make the plot of UC data with fill as the choice.
  output$plot <- renderPlot({
    if(input$z == "Stacked"){
    if(input$y=="Applicants"){
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Applicants") %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+ theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                              element_text(size  = 10,
                                                                                                           angle = 45,
                                                                                                           hjust = 1,
                                                                                                           vjust = 1)) + geom_bar(stat = "identity") + labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
    
    else if(input$y == "Enrollees"){
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Enrollees") %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                             element_text(size  = 10,
                                                                                                          angle = 45,
                                                                                                          hjust = 1,
                                                                                                          vjust = 1)) + geom_bar(stat = "identity") +  labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
    
    else{
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Admits") %>%
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                             element_text(size  = 10,
                                                                                                          angle = 45,
                                                                                                          hjust = 1,
                                                                                                          vjust = 1)) + geom_bar(stat = "identity") +  labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
    }
  else{
    if(input$y=="Applicants"){
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Applicants") %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+ theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                              element_text(size  = 10,
                                                                                                           angle = 45,
                                                                                                           hjust = 1,
                                                                                                           vjust = 1)) + geom_bar(stat = "identity", position = "dodge") + labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
    
    else if(input$y == "Enrollees"){
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Enrollees") %>% 
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                             element_text(size  = 10,
                                                                                                          angle = 45,
                                                                                                          hjust = 1,
                                                                                                          vjust = 1)) + geom_bar(stat = "identity", position = "dodge") +  labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
    
    else{
      UC_admit %>% 
        filter(Ethnicity != "All") %>% 
        filter(Category == "Admits") %>%
        ggplot(aes_string(x = "Academic_Yr", y = "FilteredCountFR", fill = input$x))+theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                             element_text(size  = 10,
                                                                                                          angle = 45,
                                                                                                          hjust = 1,
                                                                                                          vjust = 1)) + geom_bar(stat = "identity", position = "dodge") +  labs(title = "Applicants by Academic Year", x = "Academic Year",
                                                                                                                                                            y = "Filtered Count FR") 
    }
  }
  })
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)