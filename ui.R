library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(

  # Application title
 headerPanel("Effect Size Calculator 1"),


  # Sidebar
 sidebarPanel(

  p(strong("Group 1:")),

    numericInput("nx", " Sample size (n)", 21),

    numericInput("mx", " Mean", 61.33),

    numericInput("sdx", " SD", 16.43),

  p(br()),

  p(strong("Group 2:")),

    numericInput("ny", " Sample size (n)", 24),

    numericInput("my", " Mean", 59.79),

    numericInput("sdy", " SD", 18.50),

  p(br()),

  strong('Option:'),


  checkboxInput("varequal", "t-test with equal variances assumed", FALSE),


  checkboxInput("vartest", "Show test for equality of variances", FALSE)

    ),



mainPanel(
    tabsetPanel(

    tabPanel("Main",
        h3("Checking the input data"),
        tableOutput("values"),

        br(),

        h3("Mean of the differences and 95% CI"),
        verbatimTextOutput("difference.out"),

        br(),

        h3("t-test"),
        verbatimTextOutput("ttest.out"),
        h3(""),
        verbatimTextOutput("vartest.out"),

        br(),

        h3("Effect size indices"),
        verbatimTextOutput("es.out"),

        br()

        ),

    tabPanel("About",

    strong('Note'),
    p('This web application is developed with',
    a("Shiny.", href="http://www.rstudio.com/shiny/", target="_blank"),
    ''),

    br(),


    strong('Code'),
    p('Source code for this application is based on',
    a('"The handbook of Research in Foreign Language Learning and Teaching" (Takeuchi & Mizumoto, 2012).', href='http://mizumot.com/handbook/', target="_blank")),

    p('The code for this web application is available at',
    a('GitHub.', href='https://github.com/mizumot/mes', target="_blank")),

    p('If you want to run this code on your computer (in a local R session), run the code below:',
    br(),
    code('library(shiny)'),br(),
    code('runGitHub("mes","mizumot")')
    ),

    br(),

    strong('Citation in Publications'),
    p('Mizumoto, A. (2015). Langtest (Version 1.0) [Web application]. Retrieved from http://langtest.jp'),

    br(),

    strong('Article'),
    p('Mizumoto, A., & Plonsky, L. (2015).', a("R as a lingua franca: Advantages of using R for quantitative research in applied linguistics.", href='http://applij.oxfordjournals.org/content/early/2015/06/24/applin.amv025.abstract', target="_blank"), em('Applied Linguistics,'), 'Advance online publication. doi:10.1093/applin/amv025'),

    br(),

    strong('Recommended'),
    p('To learn more about R, I suggest this excellent and free e-book (pdf),',
    a("A Guide to Doing Statistics in Second Language Research Using R,", href="http://cw.routledge.com/textbooks/9780805861853/guide-to-R.asp", target="_blank"),
    'written by Dr. Jenifer Larson-Hall.'),

    p('Also, if you are a cool Mac user and want to use R with GUI,',
    a("MacR", href="http://www.urano-ken.com/blog/2013/02/25/installing-and-using-macr/", target="_blank"),
    'is defenitely the way to go!'),

    br(),

    strong('Author'),
    p(a("Atsushi MIZUMOTO,", href="http://mizumot.com", target="_blank"),' Ph.D.',br(),
    'Associate Professor of Applied Linguistics',br(),
    'Faculty of Foreign Language Studies /',br(),
    'Graduate School of Foreign Language Education and Research,',br(),
    'Kansai University, Osaka, Japan'),

    br(),

    a(img(src="http://i.creativecommons.org/p/mark/1.0/80x15.png"), target="_blank", href="http://creativecommons.org/publicdomain/mark/1.0/")
)
)
)
))