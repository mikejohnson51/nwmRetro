#' @title Graph joined spatial and NWM data
#' @description Returns a visualization of the resulting object from \code{nwmRetro::join()}
#' @param obj A spatial object from \code{nwmRetro::join()}
#' @param type A character string that determines the type of data to plot. Valid options include:
#' \itemize{
#'   \item annual
#'   \item seasonal
#'   \item monthly
#' }
#' @return a ggplot graph
#' @export
#' @author Pat Johnson


show <- function(obj = NULL, type = "annual") {

  data <- as.data.frame(obj)
  data$idu <- as.numeric(row.names(obj))

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

  test <- data %>%
    select(idu, cols) %>%
    tidyr::gather(key, value, cols) %>%
    ggplot(aes(x=idu, y=value, colour=key)) +
    geom_line() +
    xlab("COMID Index") +
    ylab("Flow (cfs)")

  graph <- test + scale_colour_brewer(palette = pal)

  return(graph)

}
