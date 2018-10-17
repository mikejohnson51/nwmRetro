# NWM Averages -------------------------

library(dplyr, warn.conflicts = FALSE)
library(fst)

fileList = list.files(path = "./data-raw", pattern = '^n.*fst$')


# Initial data frame with comids, lat, lon, and tz
nwm_retro <- fst::read.fst('./data-raw/comids_w_tz.fst')

# Add monthly averages
for (file in fileList) {
  nwm_retro <- nwm_retro %>%
    inner_join(fst::read.fst(paste0("./data-raw/",file)), by = "COMID")
}

<<<<<<< HEAD
# Define timezones
timezones <- sort(unique(nwm_retro$tz))

=======
>>>>>>> cabb7542fda948e253be880263e733cc398e4e85
# Get offset for a specific timezone region
t_offset <- function(tz) {
  res = c()
  for (i in 1:length(tz)) {
    res[i] <- as.POSIXct("2018-01-01 01", "%Y-%m-%d %H", tz = "GMT") -
      as.POSIXct("2018-01-01 01", "%Y-%m-%d %H", tz = tz[i])
  }
  return(as.numeric(res))
}

<<<<<<< HEAD
nwm_averages <- nwm_retro %>%
  mutate_at(vars(one_of(month.abb)), round, 1) %>%
  mutate_at(vars(one_of(month.abb)), funs(. * 10)) %>%
  mutate(tz_index = match(tz,timezones)) %>%
=======
# Define timezones
timezone_names <- sort(unique(nwm_retro$tz))
tz_index <- t_offset(timezone_names)

timezones <- data.frame(timezones = timezone_names, tz_index)
devtools::use_data(timezones)

nwm_averages <- nwm_retro %>%
  mutate_at(vars(one_of(month.abb)), funs(round(.,1) * 10)) %>%
  mutate(tz_index = match(tz,timezone_names)) %>%
>>>>>>> cabb7542fda948e253be880263e733cc398e4e85
  select(-lat, -long, -tz) %>%
  mutate_all(funs(as.integer(.)))



<<<<<<< HEAD
devtools::use_data(nwm_averages, compress = "xz")
=======
devtools::use_data(nwm_averages, compress = "xz", internal = TRUE)
>>>>>>> cabb7542fda948e253be880263e733cc398e4e85
