#' @title Graph joined spatial and NWM data
#' @description Returns a visualization of the resulting object from \code{nwmRetro::join()}
#' @param obj A spatial object from \code{nwmRetro::join()}
#' @param type A character string that determines the type of data to plot. Valid options include:
#' \itemize{
#'   \item annual
#'   \item seasonal
#'   \item monthly
#' }
#' @param stream_name A character string specifing what stream to graph (should match a
#' valid `gnis_name` in `obj`). \code{NA} (default) will plot all reaches.
#' @return a ggplot graph
#' @examples show(obj = obj)
#' @examples show(obj = obj, stream_name = "Fountain Creek", type = "seasonal")
#' @export
#' @author Pat Johnson


show <- function(obj = NULL, type = "annual", stream_name = NA) {

  data <- as.data.frame(obj)

  if(type == "annual") {
    cols <- c("annual", "q0001a")
    pal = "Set1"
  }
  else if (type == "seasonal") {
    cols <- c("fall", "winter", "spring", "summer")
    pal = "Set2"
  }
  else if (type == "monthly") {
    cols <- month.abb
    pal = "Set3"
  }

  if (!is.na(stream_name)) {

    if (!stream_name %in% data$gnis_name) {
      stop(paste(stream_name, "not found in object `obj`" ))
    }

    data <- data %>%
      filter(gnis_name == stream_name)
  }

  data$idu <- as.numeric(row.names(data))

  graph <- data %>%
    select(idu, cols) %>%
    tidyr::gather(key, value, cols) %>%
    ggplot(aes(x=idu, y=value, colour=key)) +
    geom_line() +
    xlab("COMID Index") +
    ylab("Flow (cfs)")

  graph <- graph + scale_colour_brewer(palette = pal)

  return(graph)

}
