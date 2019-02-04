# load required libraries
library(shiny) ; library(data.table)

# define global variable
PENALTY  <- 0.4
MIN_FREQ <- 4

# load required elements (fixed text content, functions and model's data)
source('content.R')
source('functions.R')
source('load_data.R')

shinyServer(
	function(input, output) {
	    # display text for side panel
	    output$short_intro  <- renderText(intro)
	    output$model_loaded <- renderText("<span style='color:green'>OK</span>, you can start using the tool")
	    
	    # get predictions and fill results tab with it
	    output$predsText   <- renderText (  if (nchar(input$textbox) > 0) "The table below show all possible candidates")
	    output$predictions <- renderTable({ if (nchar(input$textbox) > 0)
	                                            getCandidates(translate2WOM(input$textbox))[,c(1,2,3,6)] }, digits=-3)
	                                            #getCandidates(translate2WOM(input$textbox)) }, digits=-3)
	   	output$prediction  <- renderText ({ if (nchar(input$textbox) > 0)
	   	                                        paste("<b>Best answer:</b> ", input$textbox,
		                                              "<strong style='color:blue'>", getCandidates(translate2WOM(input$textbox))[[1,3]],
		                                              "</strong>") })
	   	
	   	output$text2speech  <- renderText ({ if (nchar(input$textbox) > 0)
	   	    paste('<input onclick="responsiveVoice.speak(\'', 
	   	            input$textbox, getCandidates(translate2WOM(input$textbox))[[1,3]], 
	   	        '\');" type="button" value="🔊 listen answer" />', ' <i>(may not work depending on your browser)</i>')
	   	})

		# display text for explanation tab and footer
    	output$tab_explanation <- renderText(explanation)
    	output$footer          <- renderText(app_info)
})
