################################################################################
########### SMART DIABETES RISK PREDICTOR WEB-APP : DIAWELLNESS ################
################################################################################

library(shiny)
library(caret)
library(keras)
library(dplyr)
library(tidyr)
library(readr)
library(e1071)
library(kernlab)
library(pROC)
library(MLmetrics)
library(shinythemes)
library(ggplot2)
library(gridExtra)
library(patchwork)
library(scales)
        
donut_metrics <- readRDS(file.path("Functions", "donut_chart.rds"))

# Define UI
ui <- fluidPage(
  theme = shinytheme("superhero"),
  titlePanel("DiaWellness"),
  # HTML used for background image
  tags$head(
    tags$style(HTML("
      body {
        background-image: url('www/diabetes_banner.png');  
        background-size: cover;
        background-repeat: no-repeat;
        background-attachment: fixed;
        color: white;
      }
      .result-text { color: red; font-size: 20px; font-weight: bold; }
      .recommendation-text { color: lightgreen; font-size: 16px; font-style: italic; }
    "))
  ),
  
  sidebarLayout(
    sidebarPanel(
      tags$h3("Let's Check Your Diabetes"),
      numericInput("Pregnancies", "Pregnancies:", value = 0, min = 0, max = 15),
      numericInput("Glucose", "Glucose Level:", value = 0, min = 44, max = 200),
      numericInput("Skin_Thickness", "Skin_Thickness:", value = 0, min = 8, max = 99),
      numericInput("BMI", "BMI:", value = 0, min = 18, max = 68),
      numericInput("Age", "Age:", value = 0, min = 21, max = 72),
      actionButton("Outcome", "Test", class = "btn btn-primary btn-lg")
    ),
    
    mainPanel(
      tags$h3("Prediction", style = "color: white; font-size: 24px;"),
      uiOutput("image"),
      tags$br(),
      textOutput("probability"),
      h4("Recommendation"),
      uiOutput("recommendation"),  
      tags$br(),
      h4("Model Performance"),
      tags$br(),
      # Displaying donut plots 
      fluidRow(
        column(3, plotOutput("donut_1", height = "300px")),
        column(3, plotOutput("donut_2", height = "300px")),
        column(3, plotOutput("donut_3", height = "300px")),
        column(3, plotOutput("donut_4", height = "300px"))
      )
    )
  ),
  
  tags$footer(
    tags$div(
      style = "border-radius: 8px; background-color: rgba(0, 188, 212, 0.2); padding: 15px; margin: 20px; text-align: center;",
      tags$p(
        style = "font-size: 12px; color: white; margin: 0;",
        "Disclaimer: This application was created solely for educational and project purposes and is not intended to provide real medical or clinical advice. The predictions and recommendations displayed are based on publicly available information and should not be used as a substitute for professional medical evaluation. Always consult a qualified healthcare provider for medical advice, diagnosis, or treatment."
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Load pre-trained model 
  svm_model_pp <- readRDS(file.path("Model", "svm_model.rds"))
  scaler <- readRDS(file.path("Functions", "scaler.rds"))
  
  # Function for transparent donut plot rendering
  render_donut <- function(metric_value, metric_label) {
    renderPlot({
      donut_metrics(metric_value, metric_label)
    }, bg = "transparent")
  }
  
  observeEvent(input$Outcome, {
    # Ensure inputs are available before processing
    req(input$Pregnancies, input$Glucose, input$Skin_Thickness, input$BMI, input$Age)
    
    # Create a new data frame for prediction
    new_data <- data.frame(
      Pregnancies = input$Pregnancies,
      Glucose = input$Glucose,
      Skin_Thickness = input$Skin_Thickness,
      BMI = input$BMI,
      Age = input$Age
    )

    # Scaling new data
    new_data_scaled <- predict(scaler, new_data)
    
    # Prediction based on real time data
    prediction <- predict(svm_model_pp$model, new_data_scaled, probability = T)
    
    # Get prediction probabilities for the positive class
    prediction_prob <- predict(svm_model_pp$model, newdata = new_data_scaled, type = "prob")[, 2]
    
    # Convert the probability to percentage
    prob_percentage <- round(prediction_prob * 100, 2)
    
    # Predicted class (if needed)
    pred_class <- ifelse(prediction_prob > 0.5, 1, 0)
    
    
    # Performance metrics
    key_metrics <- readRDS(file.path("Functions", "calculation_metrics.rds"))
    
    # Display donut charts as output
    output$donut_1 <- render_donut(key_metrics$Precision, "Precision")
    output$donut_2 <- render_donut(key_metrics$Recall, "Recall")
    output$donut_3 <- render_donut(key_metrics$F1_Score, "F1 Score")
    output$donut_4 <- render_donut(key_metrics$Accuracy, "Accuracy")

    # Display image based on prediction
    output$image <- renderUI({
      if (prediction == 1){
        tags$img(src = "www/warning.png", height = "400px")
      } else {
        tags$img(src = "www/healthy.png", height = "400px")
      }
    })
    
    # Display the probability based on prediction
    output$probability <- renderText({
      paste("Diabetes Probability: ", prob_percentage, "%", sep = "")
    })
    
    # Display recommendation based on prediction
    output$recommendation <- renderUI({
      if (prediction == 1) {
        HTML("<ul class='recommendation-text'>
            <li>Consult a doctor and monitor blood sugar regularly.</li>
            <li>Follow a diabetes-friendly diet.</li>
            <li>Stay active & exercise regularly.</li>
            <li>Prioritize heart & kidney health.</li>
            <li>Stress-reduction techniques help in diabetes management.</li>
            <li>Diabetes is manageable with the right lifestyle changes and medical care.</li>
          </ul>")
      } else {
        HTML("<ul class='recommendation-text'>
            <li>Get regular health check-ups.</li>
            <li>Aim for at least 150 minutes of moderate activity per week.</li>
            <li>Eat a balanced, low-sugar diet.</li>
            <li>Prioritize sleep and stress management.</li>
            <li>Great job! A healthy lifestyle is your best defense.</li>
          </ul>")
      }
    })
    
  })
}


# Run the application
shinyApp(ui = ui, server = server)
