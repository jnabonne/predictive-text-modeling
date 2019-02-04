# load required libraries
library(shiny) ; library(data.table)

shinyUI(fluidPage(
    tags$head(HTML("<script src='https://code.responsivevoice.org/responsivevoice.js'></script>")),
    titlePanel("Word-O-Matic 3000"),

	sidebarLayout(
		sidebarPanel(
			#htmlOutput("short_intro"),
			"This Shiny app is a demo of a predictive model designed to help you write text faster by guessing the nexts words in fonction of what you already have typed in.",
			br(), hr(),
			"Please wait while the Model is loaded...",
			htmlOutput("model_loaded"),
			hr(), br(),
			textInput('textbox', "Enter the beginning of your phrase below:") #, value="<start your phrase here>")
		),
		mainPanel(
			tabsetPanel(type='tabs',
						tabPanel("Results", br(), htmlOutput("prediction"), 
						                    br(), htmlOutput("text2speech"),
						                    br(), hr(), textOutput("predsText"), tableOutput("predictions")),
						tabPanel("Explanations", br(), htmlOutput("tab_explanation"))
			)
		)
	),
	
	hr(), htmlOutput("footer")
))
