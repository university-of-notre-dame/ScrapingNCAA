install.packages(c("dplyr", "readr", "rvest", "tidyr", "xml2"))




x<-1:10
masseyComparison <- readr::read_csv("https://www.masseyratings.com/cb/compare.csv")
rmarkdown::paged_table(masseyComparison)
masseyComparison <- readr::read_csv("https://www.masseyratings.com/cb/compare.csv", 
                                    skip = 71)
rmarkdown::paged_table(masseyComparison)
nittyGrittyLink <- "https://www.warrennolan.com/basketball/2018/nitty-live"
library(dplyr)

library(rvest)

library(tidyr)
nittyGrittyData <- read_html(nittyGrittyLink) %>% 
  html_table() %>% 
  `[[`(3)

sportsRefLink <- "https://www.sports-reference.com/cbb/"

natstatLink <- "https://www.natstat.com"

coachesDBLink <- "https://www.coachesdatabase.com/college-basketball-programs/"

kenpomLink <- "https://kenpom.com/"

ncaaLink <- "https://www.ncaa.com/rankings/basketball-men/d1/ncaa-mens-basketball-net-rankings"

kaggleLink <- "https://www.kaggle.com/ncaa/ncaa-basketball"

googlePublicLink <- "console.cloud.google.com/marketplace/details/ncaa-bb-public/ncaa-basketball"

nittyGrittyLink <- "https://www.warrennolan.com/basketball/2018/nitty-live"

hoopMathLink <- "https://www.hoop-math.com"

haslamLink <- "https://www.haslametrics.com"

oneManLink <- "https://www.onemancommittee.com/s-curve-rankings/"

nittyGrittyData$dataSource <- "nittyGritty"

rmarkdown::paged_table(nittyGrittyData)


kenPomData <- read_html(kenpomLink) %>% 
  html_table() %>% 
  `[[`(1)

rmarkdown::paged_table(kenPomData)


oneManData <- read_html(oneManLink) %>% 
  html_nodes("table tr td") %>% 
  html_text()

oneManData

ncaaData <- read_html(ncaaLink) %>% 
  html_table() %>% 
  `[[`(1)

rmarkdown::paged_table(ncaaData)
  

  hoopMathData <- read_html("https://www.hoop-math.com/leader_d2019.php") %>% 
  html_table() %>% 
  `[[`(1)

hoopMathData

hoopMathDataNames <- names(hoopMathData)
hoopMathData <- read_html("https://www.hoop-math.com/leader_d2019.php") %>% 
  html_nodes("#container #bodytext table tbody")

hoopMathData

hoopMathData <- read_html("https://www.hoop-math.com/leader_d2019.php") %>% 
  html_nodes("#container #bodytext table tbody")%>% 
  html_text()

hoopMathSplitRows <- data.frame(strsplit(hoopMathData, "(\n\n)"), 
                                stringsAsFactors = FALSE)
names(hoopMathSplitRows) <- "totalMess"

hoopMathData <- separate(hoopMathSplitRows, col = totalMess, 
                         into = hoopMathDataNames, sep = "\n")

rmarkdown::paged_table(hoopMathData)

haslamData <- read_html("http://haslametrics.com/ratings.xml")

haslamNodes <- xml_find_all(haslamData, "//mr") %>% 
  xml_attrs()

str(haslamNodes[[1]])

haslamNames <- attr(haslamNodes[[1]], "names")

haslamData <- lapply(1:length(haslamNodes), function(x) {
  
  dataRow = unname(haslamNodes[[x]])
  
  dimensionNames = list(x, haslamNames)
  
  result = matrix(dataRow, byrow = TRUE,
                  nrow = 1, ncol = length(haslamNames), 
                  dimnames = dimensionNames)
  
  result = as.data.frame(result)
})

haslamData <- bind_rows(haslamData)
save(haslamData, kenPomData, masseyComparison, ncaaData, 
     file = "C:/Users/amit_/Desktop/MarketAnalytics/Scraping Madness/basketballData.RData")
