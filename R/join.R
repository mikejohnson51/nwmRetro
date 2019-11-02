#' @title Join nwmRetro data to NHD object
#' @description Joins the retrospective averages to an input NHD object and computes the seasoal, annual and monthly averages.
#' @param obj a NHD object with a COMID attribute
#' @param comid a NHD COMID
#' @return a simple features (sf) object
#' @export
#' @importFrom dplyr mutate_at filter mutate select
#' @importFrom crayon cyan


add_retro = function(obj = NULL, comid = NULL){

  if(is.null(comid)){

    sp = any(grep("Spatial", class(obj)))

  if(sp) { obj = sf::st_as_sf(obj)}
  names(obj) = tolower(names(obj))
  ids = obj$comid
  } else { ids = comid }

  if(is.null(ids)){stop("Input object doesn't contain COMID values")}

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
    retro[[season]] =  rowMeans(retro[,names(retro) %in% months])
  }

  # Add timezone name and timezone offset
  retro <- retro %>%
    mutate(timezone = timezones[tz_index, 1]) %>%
    mutate(offset = timezones[tz_index, 2]) %>%
    select(-tz_index)

  if(!is.null(comid)){
   return(retro)
  } else {

  obj.new  = merge(obj, retro, by.x = "comid", by.y = 'COMID', all.x = TRUE)

  cat(crayon::cyan("NWM retro and NHD merged successful!\n"))

  return(obj.new)
  }

Ò}


