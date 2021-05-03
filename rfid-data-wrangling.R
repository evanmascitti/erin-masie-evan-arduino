library(magrittr)

# Read the csv file and specify column names since no header is present 

df <- readr::read_delim(file = here::here('test_data.csv'),
                 col_names = c("read_time", "message"),
                 delim = ",",
                 col_types = 'dc'
               )

# Some cleaning operations to parse and clean the data 
# backslashes up the wazoo

df %>% 
  dplyr::mutate(read_time = lubridate::as_datetime(read_time),
                message = stringr::str_remove_all(message, pattern = "b'|\\\\r|\\\\n'")) %>%
  dplyr::filter(stringr::str_detect(message, "\\w{4}\\s\\w{4}\\s\\w{4}\\s\\w{4}" )) %>% 
  dplyr::mutate(message = stringr::str_remove(message, "\\s*UID\\sValue:\\s")) %>% 
  dplyr::rename(card_id = message)


# Datetime objects represent the number of seconds since beginning of Unix epoch
# (Jan 1, 1970 at 00:00 UTC)
# Therefore they can be coerced to a double type:
head(as.double(df$read_time))
         
