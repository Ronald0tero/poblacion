library(shiny)
library(tidyverse)
library(shinythemes)
library(ggthemes)
library(plotly)
library(shinycssloaders)


countries_table <- read_csv("countries-table.csv")
pop_mundial2

#Poblacion2

poblacionx <- countries_table %>%
  rename("1980" = pop1980, "2000" = pop2000, "2010" = pop2010, "2022" = pop2022,
         "2023" = pop2023, "2030" = pop2030, "2050" = pop2050, paises = country ) %>% 
  select(paises, "1980", "2000", "2010", "2022", "2023", "2030", "2050") %>% 
  gather(año, pop, -paises) %>% mutate(pop = pop/1000000)

Areax <- countries_table %>% 
  select(country, area)
  #filter(rank < 11 )

poblacionactu <- pop_mundial2 %>% 
  select(-`Country Code`,-`Indicator Code`,-`Indicator Name`) %>%
  gather(año, poblacion, -nombre_pais) %>% 
  mutate(poblacion = poblacion/1000000) %>% 
  #filter(nombre_pais =="Colombia" | nombre_pais == "Venezuela" | nombre_pais == "Argentina") %>% 
  filter(año > 1997)
glimpse(countries_table)
glimpse(poblacionactu)

poblaciones2 <- pop_mundial2 %>% 
  select(-`Country Code`,-`Indicator Code`,-`Indicator Name`) %>%
  gather(año, poblacion, -nombre_pais) %>% 
  mutate(poblacion = poblacion/1000000)

ui<-navbarPage(title = " R Mundy " ,
               #themeSelector(),
               theme = shinytheme("darkly"),
               tabPanel("pop tiempo", selectInput(inputId = "selecctor_pais",
                                                            label = "Paises",
                                                            choices = sort(unique(unlist(countries_table[,1]))),
                                                            multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        withSpinner(plotOutput("pop_tiempo"))#,type = 7 ,color = "blue4" , size = 2)
                        ),
               tabPanel("pop area", selectInput(inputId = "selecctor_paisa",
                                                            label = "Paises",
                                                            choices = sort(unique(unlist(countries_table[,1]))),
                                                            multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        withSpinner(plotOutput("pop_area"))
                        ),
               tabPanel("pop tiempo2", selectInput(inputId = "selecctor_paisb",
                                                  label = "Paises",
                                                  choices = sort(unique(unlist(poblacionactu[,1]))),
                                                  multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        withSpinner(plotOutput("pop_tiempo2"))#,type = 7 ,color = "blue4" , size = 2)
                        ),
               tabPanel("pop tiempo3", selectInput(inputId = "selecctor_paisc",
                                                   label = "Paises",
                                                   choices = sort(unique(unlist(poblaciones2[,1]))),
                                                   multiple = TRUE),
                        submitButton("Filtrar",icon = icon("earth-americas"), width = '300px'),
                        withSpinner(plotlyOutput("pop_tiempo3"))#,type = 7 ,color = "blue4" , size = 2)
               )
               )
               
server <- function(input, output) {
  output$pop_tiempo <- renderPlot({
    seleccion_pais <- req(input$selecctor_pais)
    filter(poblacionx, paises %in% seleccion_pais) %>% 
      ggplot( aes(x=año, y=pop, group=paises, color=paises)) +
      geom_line(size=3) +
      theme_gdocs()+ #theme_bw()
      ggtitle("Poblacion de Paises desde 1980 a 2050") +
      theme(plot.title=element_text(family='', face='bold', colour='blue4', size=26))+
      ylab("Poblacion por millon") +
      xlab("Años")+
      geom_point(shape=21, color="black", fill="#69b3a2", size= 5)
    
    
  })
  
  output$pop_area <- renderPlot({
    seleccion_paisa <- req(input$selecctor_paisa)
    #ggluis <- Areax %>%
    filter( Areax, country %in% seleccion_paisa) %>% 
      ggplot( aes(x = country, y = area, fill=country))+ 
      geom_bar(stat = "identity", width=0.5)+
      scale_fill_discrete(name = "Paises")+
      theme_gdocs()+
      ggtitle("Area de los paises") +
      theme(plot.title=element_text(family='', face='bold', colour='blue4', size=26))+
      ylab( expression('Area por Km'^2))+
      xlab("Paises")
  })
  
  output$pop_tiempo2 <- renderPlot({
    seleccion_paisb <- req(input$selecctor_paisb)
    filter(poblacionactu, nombre_pais %in% seleccion_paisb) %>% 
     ggplot( aes(x=año, y=poblacion, group=nombre_pais, color=nombre_pais)) +
      scale_color_discrete(name = "Paises")+
      geom_line(size=1) +
      theme_gdocs()+ #theme_bw()
      ggtitle("Poblacion de Paises desde 1998 a 2022") +
      theme(plot.title=element_text(family='', face='bold', colour='blue4', size=26))+
      ylab("Poblacion por millon") +
      xlab("Años")+
      geom_point(shape=21, color="black", fill="#69b3a2", size= 3)+
      theme(axis.text.x = element_text(angle = 90, hjust = 1) )
    
    
  })
  
  output$pop_tiempo3 <- renderPlotly({
    seleccion_paisc <- req(input$selecctor_paisc)
    poblaciones2 <- filter(poblaciones2, nombre_pais %in% seleccion_paisc) 
    plot_ly(poblaciones2, x=~año, y=~poblacion, color =~nombre_pais ,type = "scatter", mode = "lines") %>% layout(
      title = "Poblacion Mundial",
      xaxis = list(title = "Años", rangeslider = list(type = "date")),
      yaxis = list(title = "Población(por millon)"))
    
    
  })
}

shinyApp(ui, server)
