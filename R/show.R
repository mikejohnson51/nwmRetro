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
#' @return a ggplot
#' @importFrom ggplot2 ggplot geom_line xlab ylab scale_colour_brewer
#' @importFrom stats reshape
#' @export



show <- function(obj = NULL, type = "annual", stream_name = NA) {

  # Define color pallete and columns based on type
  if(type == "annual") {
    cols <- c("annual", "q0001e")
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

  # Create data frame
  data <- as.data.frame(obj)

  # Limit data if stream_name specified
  if (!is.na(stream_name)) {

    if (!stream_name %in% data$gnis_name) {
      stop(paste(stream_name, "not found in object `obj`" ))
    }

    data <- data %>%
      filter(gnis_name == stream_name)
  }

  # Create graph
  graph <- data %>%
    select(cols) %>%
    reshape(direction="long",
            varying = cols,
            v.names="value",
            timevar="key",
            times=cols) %>%
    ggplot(aes(x=id, y=value, colour=key)) +
    geom_line() +
    xlab("COMID Index") +
    ylab("Flow (cfs)")

  graph <- graph + scale_colour_brewer(palette = pal)

  return(graph)

}
