# Loads tidyquant, tidyverse, lubridate, xts, quantmod, TTR 
library(tidyquant)  
library(dbplyr)

# Use FANG data set
data("FANG") 

# Get AAPL and AMZN Stock Prices
AAPL <- tq_get("AAPL", get = "stock.prices", from = "2015-01-04", to = "2018-01-4")
AMZN <- tq_get("AMZN", get = "stock.prices", from = "2015-01-04", to = "2018-01-4")
GOOG<- tq_get("GOOG", get = "stock.prices", from = "2015-01-04", to = "2018-01-4")
NFLX <- tq_get("NFLX", get = "stock.prices", from = "2015-01-04", to = "2018-01-4")

GSPC <- tq_get("^GSPC", get = "stock.prices", from = "2015-01-04", to = "2018-01-4")

FANG2 <- bind_cols(AAPL, AMZN, GOOG, NFLX)
FANG3 <- bind_rows(AAPL, AMZN, GOOG, NFLX)
FANG4 <- bind_rows(AAPL, AMZN, GOOG, NFLX, .id = "id")
FANG5 <- bind_rows(list(AAPL, AMZN, GOOG, NFLX), .id = "id")
#FANG6 <- bind_rows(list(AAPL, AMZN, GOOG, NFLX), .id = "groups")
FANG7 <- bind_rows(list(AAPL, AMZN, GOOG, NFLX), .id = "symbol")
FANG8 <- bind_rows(list(AAPL, AMZN, GOOG, NFLX, GSPC), .id = "symbol")


FANG7$symbol[FANG7$symbol == 1] <- 'AAPLE'
FANG7$symbol[FANG7$symbol == 2] <- 'AMAZON'
FANG7$symbol[FANG7$symbol == 3] <- 'GOOGLE'
FANG7$symbol[FANG7$symbol == 4] <- 'NETFLIX'



FANG8$symbol[FANG8$symbol == 1] <- 'AAPLE'
FANG8$symbol[FANG8$symbol == 2] <- 'AMAZON'
FANG8$symbol[FANG8$symbol == 3] <- 'GOOGLE'
FANG8$symbol[FANG8$symbol == 4] <- 'NETFLIX' 
FANG8$symbol[FANG8$symbol == 5] <- 'S&P 500' 
  
  
end <- as_date("2018-01-4")

start <- end - weeks(104)
FANG7 %>%
  filter(date >= start - days(2 * 15)) %>%
  ggplot(aes(x = date, y = close, group = symbol)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "Return for FANG Stocks ", 
       subtitle = "",
       y = "Stock Prices", x = "Two Year timeline") + 
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~ symbol, ncol = 2, scale = "free_y") + 
  theme_tq()

FANG8%>%
  filter(date >= start - days(2 * 15)) %>%
  ggplot(aes(x = date, y = close, group = symbol)) +
  geom_candlestick(aes(open = open, high = high, low = low, close = close)) +
  labs(title = "Return for FANG Stocks ", 
       subtitle = "",
       y = "Percent Gain", x = "Two Year timeline") + 
  coord_x_date(xlim = c(start, end)) +
  facet_wrap(~ symbol, ncol = 2, scale = "free_y") + 
  theme_tq()

