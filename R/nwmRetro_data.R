#' @title Avergage Flow Conditions
#' @description Dataset averaged Data from the NWM v1.2
#' @docType data
#' @format a data.frame with monthly average stream flow values and timezones
#' @examples
#' \dontrun{
#' nwmRetro::nwm_averages
#'}

"nwm_averages"

utils::globalVariables(c('.', 'COMID', 'gnis_name', 'id', 'key', 'nwm_averages', 'timezones', 'tz_index', 'value'))
