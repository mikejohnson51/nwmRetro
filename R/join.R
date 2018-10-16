#' @title Join nwmRetro data to NHD object
#' @description Joins the retrospective averages to an input NHD object and computes the seasoal, annual and monthly averages.
#' @param obj a NHD object with a COMID attribute
#' @return a simple features (sf) object
#' @export
#' @author Mike Johnson

join = function(obj = NULL){

  sp = any(grep("Spatial", class(obj)))

  if(sp) { obj = sf::st_as_sf(obj)}

  ids = obj$comid

  if(is.null(ids)){stop("Input object doesn't contain COMID values")}

  retro = nwmRetro::nwm_averages

  retro = retro[retro$COMID %in% ids,]

  retro$annual = rowMeans(retro[,c(2:12)])
  retro$fall   = rowMeans(retro[,c(10,11,12)])
  retro$spring = rowMeans(retro[,c(4,5,6)])
  retro$summer = rowMeans(retro[,c(7,8,9)])
  retro$winter = rowMeans(retro[,c(13,2,3)])

  obj.new  = merge(obj, retro, by.x = "comid", by.y = 'COMID', all.x = TRUE)

  cat(crayon::cyan("NWM retro and NHD merged successful!\n"))

  if(sp){ obj.new = sf::as_Spatial(obj.new)}

  return(obj.new)

}


