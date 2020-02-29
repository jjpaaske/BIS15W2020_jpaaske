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
  dashboardSidebar(radioButtons("x", "Select Campus", choices = c("Berkeley", "Merced", "Davis", "Irvine", "Los_Angeles", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"), 
                                selected = "Davis"),
                   radioButtons("z", "Select Year", choices = unique(UC_admit$Academic_Yr)),
                   radioButtons("y", "What would group would you like to view?", choices = c("Applicants", "Admits", "Enrollees"), 
                                selected = "Admits")),
  dashboardBody(
    helpText("Reference: University of California Information Center"),
    plotOutput("plot", width = "500px", height = "400px"))
)

server <- function(input, output, session) { 
  # the code to make the plot of UC data with fill as the choice.
  output$plot <- renderPlot({
      UC_admit %>% 
        filter(Campus == input$x) %>% 
        filter(Category == input$y) %>% 
        filter(Academic_Yr == input$z) %>% 
        filter(Ethnicity != "All") %>% 
        ggplot(aes_string(x = "Ethnicity", y = "FilteredCountFR"))+ theme(plot.title = element_text(size = rel(1.5), hjust = 0.5), axis.text.x =
                                                                                            element_text(size  = 10,
                                                                                                         angle = 45,
                                                                                                         hjust = 1,
                                                                                                         vjust = 1)) + geom_bar(stat = "identity", fill = "steelblue") + labs(title = "UC Admissions by Ethnicity", x = "Ethnicity",
                                                                                                                                                          y = "Filtered Count FR") 
 
  })
  
  
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)