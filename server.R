library(UsingR)
#Replace this later with some code to pull in the XML
DF<-read.table(file="data/DATA.txt",header=TRUE,sep="|")

# Subset the data to include just USA and Finland and just the variables of interest
DF<-DF[DF$Cou %in% c("FIN","USA", "DEU") & DF$Var %in% c("VALU", "EMPN", "GFCF"),]


#function runs a simple linear autoregressive time series prediction model.  Value in time t is predicted using the previous two periods and a time variable as regressors.
genPredict<-function(countryName, STANVar, STANInd, STANYear){
                #Capture previous 12 years of data for the user-entered independent variable 
                tempDF<-DF[DF$Cou==countryName & DF$Var==STANVar & DF$year<=STANYear & DF$year>=(STANYear-12) & DF$ind==STANInd,]
                
                #Append to the database the the autoregressive lagged regressor variables by lagging the value variable by one and two years.                 
                lag1<-append(0,tempDF[tempDF$year<STANYear,5])
                lag2<-append(c(0,0),tempDF[tempDF$year<(STANYear-1),5])
                predDF<-cbind(tempDF,lag1,lag2)
                #trim off the two "ragged" years created by the lagging process
                predDF<-predDF[c(-1,-2),]
                
                #This is the true value that the prediction will be measured against. 
                trueVal<-predDF[,5]
                
                #Model is a linear autoregressive (AR-2) model with a year trend incorporated
                modFit<-lm(value~lag1+lag2+year, data=predDF[-11,])
                
                

                #Capture the predictions including the final year of data. 
                predictions<-predict(modFit, newdata=predDF)        
                modErr<-100*(predictions/trueVal-1)
                results<-list(round(as.numeric(predictions[11]),0), round(as.numeric(trueVal[11]),0), round(as.numeric(modErr[11]),2),toString(summary(modFit)$call),toString(summary(modFit)$adj.r.squared))
                
                return(results)
                #return(paste("Country:", countryName, "   Variable: ", STANVar, "    Idustry: ", STANInd, "    Value is: ", DF[DF$Cou==countryName & DF$Var==STANVar & DF$year==STANYear & DF$ind==STANInd,5]))                
        }

library(shiny)



shinyServer(
        function(input, output) {
                output$modErr<-reactive({genPredict(input$id1, input$id2, input$id3, as.numeric(input$id4))[[3]]})
                output$pred<-reactive({genPredict(input$id1, input$id2, input$id3, as.numeric(input$id4))[[1]]})
                output$trueVal<-reactive({genPredict(input$id1, input$id2, input$id3, as.numeric(input$id4))[[2]]})
                output$call<-reactive({genPredict(input$id1, input$id2, input$id3, as.numeric(input$id4))[[4]]})
                output$modString1<-renderPrint(paste("Predicting ", input$id2, "for industry ", input$id3, " in ", input$id1, ", using 10 years of previous data"))
                output$modString2<-renderPrint(paste("Predicting using AR-2 model of form ", input$id2, " = intercept + year + lag1(", input$id2, ") + lag2(", input$id2, ") + resid"))
                output$oid2<-renderPrint(input$id2)
                output$oid3<-renderPrint(input$id3)
                
                
})
