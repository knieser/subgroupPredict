library(shiny)
source("scoring_algorithm.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Depressive Subgroup Prediction Calculator (proof-of-concept)"),
  p(strong("Note: "),"Parameters used by this prediction calculator 
  were estimated from a sample of
  postpartum women who had a history of major depressive disorder, 
  were actively seeking psychiatric care, 
  and predominately identified as White and non-Hispanic. 
  Before this tool could be recommended clinically, 
  parameter estimates should be obtained from a large, representative sample 
  of perinatal women.", style = "color:red"),
  
  mainPanel(           
    tabsetPanel(id = "survey",
      tabPanel("BDI", 
               radioButtons("bdi1", h4("1. Sadness"), choices = list("0" = 0,
                                                      "1" = 1,
                                                      "2" = 2,
                                                      "3" = 3), inline=T),
               radioButtons("bdi2", h4("2. Pessimisim"), choices = list("0" = 0,
                                                          "1" = 1,
                                                            "2" = 2,
                                                            "3" = 3), inline=T),
               radioButtons("bdi3", h4("3. Sense of failure"), choices = list("0" = 0,
                                                            "1" = 1,
                                                            "2" = 2,
                                                            "3" = 3), inline=T),
               radioButtons("bdi4", h4("4. Lack of satisfaction"), choices = list("0" = 0,
                                                            "1" = 1,
                                                            "2" = 2,
                                                            "3" = 3), inline=T),
               radioButtons("bdi5", h4("5. Guilty feeling"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi6", h4("6. Sense of punishment"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi7", h4("7. Self-hate"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi8", h4("8. Self-accusations"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi9", h4("9. Thoughts of self-harm"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi10", h4("10. Crying"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi11", h4("11. Irritability"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi12", h4("12. Social withdrawal"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi13", h4("13. Indecisiveness"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi14", h4("14. Body image"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi15", h4("15. Work inhibition"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi16", h4("16. Sleep disturbance"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi17", h4("17. Fatigue"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi18", h4("18. Loss of appetite"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi19", h4("19. Weight loss"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi20", h4("20. Somatic preoccupation"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
               radioButtons("bdi21", h4("21. Loss of libido"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T)
               ), #tab panel
      # tabPanel("EPDS",
      #          radioButtons("epds1", h4("1. Been able to laugh"), choices = list("0" = 0,
      #                                                              "1" = 1,
      #                                                              "2" = 2,
      #                                                              "3" = 3), inline=T),
      #          radioButtons("epds2", h4("2. Looked forward"), choices = list("0" = 0,
      #                                                        "1" = 1,
      #                                                        "2" = 2,
      #                                                        "3" = 3), inline=T),
      #          radioButtons("epds3", h4("3. Blamed myself"), choices = list("0" = 0,
      #                                                              "1" = 1,
      #                                                              "2" = 2,
      #                                                              "3" = 3), inline=T),
      #          radioButtons("epds4", h4("4. Anxious or worried"), choices = list("0" = 0,
      #                                                                  "1" = 1,
      #                                                                  "2" = 2,
      #                                                                  "3" = 3), inline=T),
      #          radioButtons("epds5", h4("5. Felt scared or panicky"), choices = list("0" = 0,
      #                                                            "1" = 1,
      #                                                            "2" = 2,
      #                                                            "3" = 3), inline=T),
      #          radioButtons("epds6", h4("6. Things on top of me"), choices = list("0" = 0,
      #                                                                 "1" = 1,
      #                                                                 "2" = 2,
      #                                                                 "3" = 3), inline=T),
      #          radioButtons("epds7", h4("7. Difficulty sleeping"), choices = list("0" = 0,
      #                                                       "1" = 1,
      #                                                       "2" = 2,
      #                                                       "3" = 3), inline=T),
      #          radioButtons("epds8", h4("8. Felt sad or miserable"), choices = list("0" = 0,
      #                                                              "1" = 1,
      #                                                              "2" = 2,
      #                                                              "3" = 3), inline=T),
      #          radioButtons("epds9", h4("9. Crying"), choices = list("0" = 0,
      #                                                                   "1" = 1,
      #                                                                   "2" = 2,
      #                                                                   "3" = 3), inline=T),
      #          radioButtons("epds10", h4("10. Thoughts of self-harm"), choices = list("0" = 0,
      #                                                      "1" = 1,
      #                                                      "2" = 2,
      #                                                      "3" = 3), inline=T)
      #          )
        ), #tabset panel
    hr(),
    h3(textOutput("total")),
    h3(textOutput("predictedSubgroup")),
    hr(),
    actionButton("submit", h4("Submit")),
    hr()
      ) # main panel
) # page

# Define server logic ----
server <- function(input, output) {
 
  dataInput <- eventReactive(input$submit,{
    if(input$survey=="EPDS"){
      as.numeric(c(input$epds1, input$epds2, input$epds3, 
                                  input$epds4, input$epds5, input$epds6,
                                  input$epds7, input$epds8, input$epds9,
                                  input$epds10)
                     )}
    else{ as.numeric(c(input$bdi1, input$bdi2, input$bdi3, 
                                        input$bdi4, input$bdi5, input$bdi6,
                                        input$bdi7, input$bdi8, input$bdi9,
                                        input$bdi10, input$bdi11, input$bdi12,
                                        input$bdi13, input$bdi14, input$bdi15,
                                        input$bdi16, input$bdi17, input$bdi18,
                                        input$bdi19, input$bdi20, input$bdi21)
                     )}
    })
  
  
  output$total <- renderText({paste("Total: ", sum(dataInput()))})
                                    
  output$predictedSubgroup <- renderText({
    paste("Predicted probability of being in self-judgement subgroup: ", 
          round(subgroupPredict(t(dataInput()), input$survey), 2))
      })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)