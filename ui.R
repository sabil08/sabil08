library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title=h4("Project Swan Data Input 1",align="center")),
  sidebarLayout(
    sidebarPanel(
      fileInput(inputId="file",label="upload the file"),
      helpText("default is max file is 5 MB"),
      tags$hr(),
      h5(helpText("select the read.table parameter below")),
      checkboxInput(inputId="header",label="Header",value=FALSE),
      checkboxInput(inputId="strAsFactor",label="strAsFactor",value=FALSE),
      radioButtons(inputId = "sep",label="separator",choices = c(Comma=",",Semicolon=";",Tab="\t",Space=""),selected=","),
      br(),
      helpText("select the following variabel from the Data"),
      br(),
      uiOutput("vy"),
      br(),
      uiOutput("vx")
      
      ),
    mainPanel(
      uiOutput("tb")
    )
  )
))