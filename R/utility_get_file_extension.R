#' @title Parse Files Extension
#' @description Get a file extension from Path
#' @param path a path to a file
#' @return a character string of the associated file extension
#' @export
#' @author Mike Johnson


getExtension <- function (path) {
  splitted    <- strsplit(x=path, split='/')[[1]]
  path        <- splitted [length(splitted)]
  ext         <- NULL
  splitted    <- strsplit(x=path, split='\\.')[[1]]
  l           <-length (splitted)
  if (l > 1 && sum(splitted[1:(l-1)] != ''))  ext <-splitted [l]

  return(ext)
}

