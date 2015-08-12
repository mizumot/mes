library(shiny)
library(compute.es)


shinyServer(function(input, output) {
    
    options(warn=-1)
    
    sliderValues <- reactive ({
        n1 <- as.integer(input$nx)
        n2 <- as.integer(input$ny)
        
        data.frame(
            n = c(n1, n2),
            Mean = c(input$mx, input$my),
            SD = c(input$sdx, input$sdy),
            stringsAsFactors=FALSE)
    })
    
    difference <- reactive({
            nx <- input$nx
            mx <- input$mx
            sdx <- input$sdx
            ny <- input$ny
            my <- input$my
            sdy <- input$sdy
            
            if (input$varequal) {
                df <- nx+ny-2
                v <- ((nx-1)*sdx^2+(ny-1)*sdy^2)/df
                diff <- round((mx - my), 3)
                diff.std <- sqrt(v * (1/nx + 1/ny))
                diff.lower <- round(diff + diff.std * qt(0.05/2, df),3)
                diff.upper <- round(diff + diff.std * qt(0.05/2, df, lower.tail = FALSE),3)
            } else {
                stderrx <- sqrt(sdx^2/nx)
                stderry <- sqrt(sdy^2/ny)
                stderr <- sqrt(stderrx^2 + stderry^2)
                df <- round(stderr^4/(stderrx^4/(nx - 1) + stderry^4/(ny - 1)),3)
                tstat <- round(abs(mx - my)/stderr,3)
                diff <- round((mx - my), 3)
                cint <- qt(1 - 0.05/2, df)
                diff.lower <- round(((tstat - cint) * stderr),3)
                diff.upper <- round(((tstat + cint) * stderr),3)
            }
            
            cat("Mean of the differences [95% CI] =", diff, "[", diff.lower,",", diff.upper,"]", "\n")
    })


    es <- reactive({
        nx <- input$nx
        mx <- input$mx
        sdx <- input$sdx
        ny <- input$ny
        my <- input$my
        sdy <- input$sdy
    
        mes(mx, my, sdx, sdy, nx, ny)
    })
    
    
    ttest <- reactive({
        nx <- input$nx
        mx <- input$mx
        sdx <- input$sdx
        ny <- input$ny
        my <- input$my
        sdy <- input$sdy
        
     if (input$varequal) {
        df1 <- input$nx+input$ny-2
        v1 <- ((input$nx-1)*input$sdx^2+(input$ny-1)*input$sdy^2)/df1
        tstat1 <- round(abs(input$mx-input$my)/sqrt(v1*(1/input$nx+1/input$ny)),3)
        diff <- round((input$mx - input$my), 3)
        P1 <- 2 * pt(-abs(tstat1), df1)
        
        cat("Independent t-test (equal variances assumed)", "\n",
        " t =", tstat1, ",", "df =", df1, ",", "p-value =", P1, "\n")
        
     } else {

        stderrx <- sqrt(input$sdx^2/input$nx)
        stderry <- sqrt(input$sdy^2/input$ny)
        stderr <- sqrt(stderrx^2 + stderry^2)
        df2 <- round(stderr^4/(stderrx^4/(input$nx - 1) + stderry^4/(input$ny - 1)),3)
        tstat2 <- round(abs(input$mx - input$my)/stderr,3)
        P2 <- 2 * pt(-abs(tstat2), df2)
        
        cat("Welch's t-test (equal variances not assumed)", "\n",
            " t =", tstat2, ",", "df =", df2, ",", "p-value =", P2, "\n")
     }
     })
    

    vartest <- reactive({
        if (input$vartest) {
            nx <- input$nx
            sdx <- input$sdx
            vx <- sdx^2
            ny <- input$ny
            sdy <- input$sdy
            vy <- sdy^2
            
            if (vx > vy) {
                f <- vx/vy
                df1 <- nx-1
                df2 <- ny-1
            } else {
                f <- vy/vx
                df1 <- ny-1
                df2 <- nx-1
            }
            
            p <- 2*pf(f, df1, df2, lower.tail=FALSE)
            dfs <- c("num df"=df1, "denom df"=df2)
            
            cat(" Test for equality of variances", "\n",
                "  F =", f, ",", "num df =", df1, ",", "denom df =", df2, "\n",
                "  p-value = ", p, "\n"
                )
        
        } else {
            cat("Test for equality of variances will be displayed if the option is selected.")
        }
    })
    



    # Show the values using an HTML table
    output$values <- renderTable({
    sliderValues()
    })

    # Show the final calculated value
    
    output$difference.out <- renderPrint({
        difference()
    })
    
    output$es.out <- renderPrint({
        es()
    })
    
    output$ttest.out <- renderPrint({
        ttest()
    })

    output$vartest.out <- renderPrint({
        vartest()
    })

})