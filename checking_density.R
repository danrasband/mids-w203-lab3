install.packages("rvest")

library("rvest")

url <- "http://www.usa.com/rank/north-carolina-state--population-density--county-rank.htm"
density <- url %>%
  read_html() %>%
  html_nodes("table")  %>% 
  .[2] %>% 
  html_table(fill = TRUE)

density_df <- density[[1]][-1,]
colnames(density_df) <- c("Rank", "Density", "County/Pop")
density_df$Density_num <- as.numeric(sub(",","",sub("/sq mi","",density_df$Density)))

par(mfrow = c(1,2))
plot(crime[order(-crime$density),]$density, 
     xlim = c(0,100), ylim = c(0,18),
     xlab = "County Density Rank",
     ylab = "Density as Pop per 100 sq miles",
     main = "Lab dataset (1987)")
plot(density_df$Density_num/100, 
     xlim = c(0,100), ylim = c(0,18),
     xlab = "County Density Rank",
     ylab = "Density as Pop per 100 sq miles",
     main = "USA.com Web Page")