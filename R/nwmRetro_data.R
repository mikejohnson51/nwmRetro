#' @title Avergage Flow Conditions
#' @description Dataset averaged Data from the NWM v1.2
#' @docType data
#' @format a data.frame with monthly average stream flow values and timezones
#' @examples
#' \dontrun{
#' nwmRetro::nwm_averages
#'}

"nwm_averages"

#' @title Timezones
#' @description Dataset of timezones
#' @docType data
#' @format a data.frame with timezones and offsets
#' @examples
#' \dontrun{
#' nwmRetro::nwm_averages
#'}

"timezones"

utils::globalVariables(c('.', 'COMID', 'gnis_name', 'id', 'key', 'nwm_averages', 'timezones', 'tz_index', 'value'))
