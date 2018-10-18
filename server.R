library(shiny)

shinyServer(function(input,output){
  
  data<-reactive({
    
    file1<-input$file
    if(is.null(file1)){return()}
    read.table(file=file1$datapath,sep=input$sep,header=input$header,stringsAsFactors = input$strAsFactor)
  })
  

  output$vy<-renderUI({
    
    selectInput("variabely","select the first (y) variabel",choices=names(data()))
  })
  
  output$vx<-renderUI({
    selectInput("variabelx","select the second (x) variabel",choices=names(data()),multiple = TRUE)
  })
  
  output$filedf<-renderTable({
    if(is.null(data())){return()}
    input$file
  })  
  output$sum<-renderPrint({
    if(is.null(data())){return()}
    summary(data())
  }) 
  
  output$table<-renderTable({
    if(is.null(data())){return()}
    data()
  }) 
  
  output$plot<-renderPlot({
    a=input$variabely
    b=input$variabelx
    par(pch=22, col="blue")
    par(mfrow=c(2,4))
    mydf<-data()
    kk=mydf[,c(b)]
    dtt<-mydf[,c(a)]
    for(i in 1:length(b)) {
      heading = paste("graph of",b[i])
      plot(kk[,i],dtt,ylab=a, xlab=b[i],main=heading)
    }
    
  })
  
  
  output$tb<-renderUI({
    if(is.null(data()))
      h5("powered by",tags$img(src='swan.png',heigth=500,width=500))
    else
      tabsetPanel(tabPanel("about file",tableOutput("filedf")),tabPanel("data",tableOutput("table")),tabPanel("summary",verbatimTextOutput("sum")),tabPanel("plot",plotOutput("plot")))
  })
})