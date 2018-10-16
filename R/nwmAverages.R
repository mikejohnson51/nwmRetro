#' @title Long term NWM averages
#' @description Returns a dataset containing a 23-year run of of the National Water Model
#' version 1.0 provided by NCAR and OWP
#' @param include.averages A logical scalar. Should seasonal (fall, spring, summer, winter)
#' and annual averages be included?
#' @param include.timezones A logical scalar. Should timezone names (e.x. "America/New_York")
#' and hour offsets from UTC be included?
#' @param include.months A character vector.  Months to include (e.x.  \code{c("Jan", "Feb")}).
#' @return a \code{data.frame} object
#' @author Pat Johnson
#' @export
#'

nwmAverages <- function(include.averages = TRUE,
                        include.timezones = TRUE,
                        include.months = month.abb) {

  data <- nwm_averages %>%
    mutate_at(vars(one_of(month.abb)), funs(. / 10))

  # Define seasons
  seasons <- list(
    annual = month.abb,
    fall   = c("Sep", "Oct", "Nov"),
    spring = c("Mar", "Apr", "May"),
    summer = c("Jun", "Jul", "Aug"),
    winter = c("Dec", "Jan", "Feb")
  )

  # Add summary statistics
  if(include.averages) {
    for (season in names(seasons)) {
      months = eval(parse(text = paste0('seasons$', season)))
      data <- data %>%
        mutate(!!season := rowMeans(select(., one_of(months)), na.rm = TRUE)) %>%
        mutate_at(vars(season), round, 2)
    }
  }

  # Add timezone name and timezone offset
  if(include.timezones) {
    data <- data %>%
      mutate(timezone = timezones[tz_index, 1]) %>%
      mutate(offset = timezones[tz_index, 2])
  }

  # Remove tz_index
  data <- data %>%
    select(-tz_index)

  # Limit months to include.months
  remove = month.abb[month.abb != include.months]
  data <- data %>%
    select(-remove)

  return(data)
}
