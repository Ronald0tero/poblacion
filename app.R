library(shiny)
library(tidyverse)
library(shinythemes)
library(ggthemes)
library(plotly)
library(shinycssloaders)
library(janitor)
library(plotly)


countries_table <- read_csv("countries-table.csv")
pop_mundial2 <- read_excel("API_SP.POP.TOTL_DS2_es_excel_v2_5607332.xls", 
                           sheet = "Data", range = "A4:BO270") %>% rename(nombre_pais = "Country Name") %>% drop_na()


Areax <- countries_table %>% 
  select(country, area)

poblaciones2 <- pop_mundial2 %>% 
  select(-`Country Code`,-`Indicator Code`,-`Indicator Name`) %>%
  gather(aC1o, poblacion, -nombre_pais) %>% 
  mutate(poblacion = poblacion/1000000)

ui<-navbarPage(title = " R Mundy " ,
               theme = shinytheme("flatly"),
               tabPanel("Poblacion Area", selectInput(inputId = "selecctor_paisa",
                                                            label = "Paises",
                                                            choices = sort(unique(unlist(countries_table[,1]))),
                                                            multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        br(),
                        withSpinner(plotOutput("pop_area"))
                        ),
               tabPanel("Poblacion Tiempo", selectInput(inputId = "selecctor_paisc",
                                                   label = "Paises",
                                                   choices = sort(unique(unlist(poblaciones2[,1]))),
                                                   multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        br(),
                        withSpinner(plotlyOutput("pop_tiempo3"))#,type = 7 ,color = "blue4" , size = 2)
               )
               )
               
server <- function(input, output) {
  
  output$pop_area <- renderPlot({
    seleccion_paisa <- req(input$selecctor_paisa)
    filter( Areax, country %in% seleccion_paisa) %>% 
      ggplot( aes(x = country, y = area, fill=country))+ 
      geom_bar(stat = "identity", width=0.5)+
      scale_fill_discrete(name = "Paises")+
      theme_gdocs()+
      ggtitle("Area de los paises") +
      ylab( expression('Area por Km'^2))+
      xlab("Paises")
  })
  
  output$pop_tiempo3 <- renderPlotly({
    seleccion_paisc <- req(input$selecctor_paisc)
    poblaciones2 <- filter(poblaciones2, nombre_pais %in% seleccion_paisc) 
    plot_ly(poblaciones2, x=~aC1o, y=~poblacion, color =~nombre_pais ,type = "scatter", mode = "lines") %>% layout(
      title = "Poblacion Mundial",
      xaxis = list(title = "Años", rangeslider = list(type = "date")),
      yaxis = list(title = "Poblacion(por millon)"))
    
    
  })
}

shinyApp(ui, server)
