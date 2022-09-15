library(shiny)
source("scoring_algorithm.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Beck Depression Inventory"),
  
  mainPanel(
    radioButtons("q1", h3("1. Sadness"), choices = list("0" = 0,
                                                  "1" = 1,
                                                  "2" = 2,
                                                  "3" = 3), inline=T),
    
    radioButtons("q2", h3("2. Pessimisim"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q3", h3("3. Sense of failure"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q4", h3("4. Lack of satisfaction"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q5", h3("5. Guilty feeling"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q6", h3("6. Sense of punishment"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q7", h3("7. Self-hate"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q8", h3("8. Self-accusations"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q9", h3("9. Thoughts of self-harm"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q10", h3("10. Crying"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q11", h3("11. Irritability"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q12", h3("12. Social withdrawal"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q13", h3("13. Indecisiveness"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q14", h3("14. Body image"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q15", h3("15. Work inhibition"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q16", h3("16. Sleep disturbance"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q17", h3("17. Fatigue"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q18", h3("18. Loss of appetite"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q19", h3("19. Weight loss"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q20", h3("20. Somatic preoccupation"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    radioButtons("q21", h3("21. Loss of libido"), choices = list("0" = 0,
                                                        "1" = 1,
                                                        "2" = 2,
                                                        "3" = 3), inline=T),
    
    hr(),
    
    h3(textOutput("total")),
    
    h3(textOutput("predictedSubgroup")),
    
    hr(), 
    
    actionButton("submit", h3("Submit"))
    )
)

# Define server logic ----
server <- function(input, output) {
  
  dataInput <- reactive({
    as.numeric(c(input$q1, input$q2, input$q3, input$q4, input$q5, input$q6, input$q7, 
                 input$q8, input$q9, input$q10, input$q11, input$q12, input$q13, input$q14, 
                 input$q15, input$q16, input$q17, input$q18, input$q19, input$q20, input$q21 
                 ))
    })
  
  observeEvent(input$submit, {
    output$total = renderText({paste("Total: ", sum(dataInput()))})
  
    output$predictedSubgroup = renderText({paste("Predicted probability of being in self-judgement subgroup: ", 
                                               round(subgroupPredict(t(dataInput())),3)
                                               )})
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)