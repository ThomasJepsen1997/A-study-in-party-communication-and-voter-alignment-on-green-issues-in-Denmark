rm(list = ls())

setwd("C:/Users/Bruger/Desktop/Political Data Science/Final project")

library(rvest)
library(dplyr)
library(tidyverse)

#Set user agent 
httr::set_config(httr::user_agent("201808827@post.au.dk; Student at Aarhus University"))

if(!dir.exists("press_archive")) dir.create("press_archive")


# base url & security signatures
url <- "https://enhedslisten.dk/nyheder/page/"

# create empty data set with titles
cols <- c("titles", "links", "date", "text")
dat_Ø <- cols %>% t %>% as_tibble(.name_repair = "unique") %>% `[`(0, ) %>% rename_all(~cols)

# page number to add to url
pages <- 24

# Starting my while loop

# pull out and trim the exerpt names

text_blog = function(link) {
  press_page = read_html(link)
  blog_text = press_page %>% html_nodes('.c-article div p') %>%
    html_text() %>% paste(collapse = ",")  
  return(blog_text) }



while (T) {
  
  # report progress to console
  print(paste("Pulling pages", pages, "through", (pages + 1)))
  
  # fixes the problem with differnt url on first page 
  final.url <- str_c(url, pages)
  
  
  
  
  # check if file already exists -- if so, open it -- if not, download it
  file.name <- str_c("./press_archive/", "2021-09-19", " -- Enhedslisten ", pages, "-", (pages + 1), ".html")
  
  
  ###########################################
  # check if file already downloaded
  if (file.exists(file.name)) { # if already downloaded, do this
    page <- read_html(file.name)
    
  } else {# if NOT already downloaded, do this
    
    # don't forget to delay, we're pulling more than one page
    Sys.sleep(5 + runif(1)*10)
    
    # download page
    page <- read_html(final.url)
    
    # extract raw html text
    to.archive <- as.character(page)
    
    # archive page for later
    write(to.archive, file.name)
  }
  ###########################################
  
  
  # pull out and trim post titles
  titles <- page %>% html_nodes('.f-black') %>% html_text(trim = T)
  
  
  
  # pull out links to posts
  links <- page %>% html_nodes('.f-black') %>% html_attr("href")
  
  # pull out and trim the date of the blogs
  date <- page %>%
    html_nodes('time') %>%
    html_text(trim = T)
  
  text <- sapply(links, FUN = text_blog, USE.NAMES = F)
  # build data frame from data
  dat_Ø <- dat_Ø %>% add_row(
    titles = titles,
    links = links,
    text = text,
    date = date)
  
  # iterate page count
  pages <- pages + 1
  
  # break out of loop when new titles can't be found
  if (pages == 42) break
  
}

## output full search results data
save(dat_Ø, file = "Enhedslisten_press.rda")
#########################