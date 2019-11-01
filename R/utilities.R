#' re-export magrittr pipe operator
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export

NULL

#' @title Check an objects class
#' @description A function to check the class of an object, will return TRUE if `x`` is of class `type``
#' @param x an object
#' @param type a \code{character} class to check against
#' @return logical
#' @keywords internal
#' @export
#' @examples
#' \dontrun{
#' sf = getAOI(state = "CA", sf = TRUE)
#' checkClass(sf, "sf")
#' }

checkClass = function(x, type) {
  log = any(grepl(
    pattern = type,
    class(x),
    ignore.case = TRUE,
    fixed = FALSE
  ))

  return(log)
}

#' @title Parse Files Extension
#' @description Get a file extension from Path
#' @param path a path to a file
#' @return a character string of the associated file extension
#' @export

getExtension <- function (path) {
  splitted    <- strsplit(x=path, split='/')[[1]]
  path        <- splitted [length(splitted)]
  ext         <- NULL
  splitted    <- strsplit(x=path, split='\\.')[[1]]
  l           <-length (splitted)
  if (l > 1 && sum(splitted[1:(l-1)] != ''))  ext <-splitted [l]

  return(ext)
}

#' @title Choose what to return for HydroData Calls
#' @description  A function defining what should be returned in a HydroData object
#' @param report character sting to append values to
#' @return a list of HydroData components
#' @export
#' @importFrom crayon white

return.what = function(report) {
  `%+%` = crayon::`%+%`
  cat(crayon::white("Returned object contains: ") %+% crayon::green(paste(report, collapse = ", "), "\n"))
}



