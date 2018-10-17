#' @title Join nwmRetro data to NHD object
#' @description Joins the retrospective averages to an input NHD object and computes the seasoal, annual and monthly averages.
#' @param obj a NHD object with a COMID attribute
#' @return a simple features (sf) object
#' @export
<<<<<<< HEAD
#' @author Mike Johnson
=======
#' @author Mike Johnson and Pat Johnson
>>>>>>> cabb7542fda948e253be880263e733cc398e4e85

join = function(obj = NULL){

  sp = any(grep("Spatial", class(obj)))

  if(sp) { obj = sf::st_as_sf(obj)}

  ids = obj$comid

  if(is.null(ids)){stop("Input object doesn't contain COMID values")}

<<<<<<< HEAD
  retro = nwmRetro::nwm_averages

  retro = retro[retro$COMID %in% ids,]

  retro$annual = rowMeans(retro[,c(2:12)])
  retro$fall   = rowMeans(retro[,c(10,11,12)])
  retro$spring = rowMeans(retro[,c(4,5,6)])
  retro$summer = rowMeans(retro[,c(7,8,9)])
  retro$winter = rowMeans(retro[,c(13,2,3)])
=======
  # Define seasons
  seasons <- list(
    annual = month.abb,
    fall   = c("Sep", "Oct", "Nov"),
    spring = c("Mar", "Apr", "May"),
    summer = c("Jun", "Jul", "Aug"),
    winter = c("Dec", "Jan", "Feb")
  )

  # Scale and filter data
  retro <- nwm_averages %>%
    mutate_at(vars(one_of(month.abb)), funs(. / 10)) %>%
    filter(COMID %in% ids)

  # Add summary statistics
  for (season in names(seasons)) {
    months = eval(parse(text = paste0('seasons$', season)))
    retro <- retro %>%
      mutate(!!season := rowMeans(select(., one_of(months)), na.rm = TRUE)) %>%
      mutate_at(vars(season), round, 2)
  }

  # Add timezone name and timezone offset
  retro <- retro %>%
    mutate(timezone = timezones[tz_index, 1]) %>%
    mutate(offset = timezones[tz_index, 2]) %>%
    select(-tz_index)
>>>>>>> cabb7542fda948e253be880263e733cc398e4e85

  obj.new  = merge(obj, retro, by.x = "comid", by.y = 'COMID', all.x = TRUE)

  cat(crayon::cyan("NWM retro and NHD merged successful!\n"))

  if(sp){ obj.new = sf::as_Spatial(obj.new)}

  return(obj.new)

}


