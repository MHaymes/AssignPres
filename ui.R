library(shiny)
shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Predicting Economic Activity Using the OECD STAN ISIC REV. 4 Database"),
                
                sidebarPanel(
                        radioButtons('id1','Choose a country to analyze',c("Germany" = "DEU", "USA" = "USA", "Finland" = "FIN")),
                        radioButtons('id2','Choose a variable to predict',c("Value Added - Current Prices (VALU)" = "VALU", "Employment (EMPN)" = "EMPN", "Gross Fixed Capital Formation - Current Prices (GFCF)" = "GFCF")),
                        radioButtons('id3','Choose an industry to analyze',c("Total Business Sector (id=0199)" = "0199", "Manufacturing (id=1033)" = "1033")),
                        radioButtons('id4','Choose a year to predict', c("2005" = 2005, "2000 (unavailable for Germany"=2000, "1995 (unavailable for Germany)"=1995))
                        ),                
                mainPanel(
                        h5('NOTE: Database may take a minute or so to load...'),
                        h5('ABOUT'),
                        p('This application makes a simple prediction of an economic variable using the OECD ISIC Rev. 4. Structural Analysis Database (STAN).  The model employs a simple autoregressive linear model to predict the value of a variable in year t, using previous out of sample data from years t-1 to t-10.'),                        
                        p('At this time, this represents a simple prediction model on a small data sammple, for only three countries.  Note that data for Germany is incomplete for the 2000 and 1995 prediction periods'),


                        verbatimTextOutput("modString1"),
                        verbatimTextOutput("modString2"),
                        
                        h5('Prediction Result:'),
                        verbatimTextOutput("pred"),
                        h5('Actual Value'),
                        verbatimTextOutput("trueVal"),
                        h5('Prediction Error (%)'),
                        verbatimTextOutput("modErr")
                        
                )
        )
)