#' @title Find Spatial NHD or WBD data
#' @description returns a spatail sub set of the NHD of WBD for an input spatial object using the CIDA Web Coverage Services
#' @param AOI a Spatial Object
#' @param type the WBD or nhdplus object to return. Options include:
#' \itemize{
#' \item HUC08
#' \item HUC12
#' \item flowlines
#' \item catchments
#' \item waterbodies
#' }
#' @param spatial return `sp` (default) if \code{FALSE} return `sf`
#' @return a \code{Spatial} object
#' @author Mike Johnson
#' @export


find = function(AOI, type = "flowlines", spatial = TRUE){

df = data.frame(server = c(rep("WBD", 2),
                           rep("nhdplus", 3)),

                call   = c("huc08",
                           "huc12",
                           "nhdflowline_network",
                           "catchmentsp",
                           "nhdwaterbody"),

                type   = c("HUC8",
                           "HUC12",
                           "flowlines",
                           "catchments",
                           "waterbodys"),

                stringsAsFactors = F)

bb = AOI@bbox

if(!(type %in% df$type)){stop("Type not found.")}

server = df$server[which(df$type == type)]
call   = df$call[which(df$type == type)]

url_base <- paste0("https://cida.usgs.gov/nwc/geoserver/",
                   server,
                   "/ows",
                   "?service=WFS",
                   "&version=1.0.0",
                   "&request=GetFeature",
                   "&typeName=",
                   server, ":", call,
                   "&outputFormat=application%2Fjson",
                   "&srsName=EPSG:4269",
                   "&bbox=",
                    paste(bb[2,1], bb[1,1],
                    bb[2,2], bb[1,2],
                    "urn:ogc:def:crs:EPSG:4269", sep = ","))

sl = tryCatch({sf::st_zm(sf::read_sf(url_base))},
              error = function(e){
                return(NULL)
              }, warning = function(w){
                return(NULL)
              }
)

if(any(is.null(sl), nrow(sl) ==0)) {
  sl = NULL
  warning("O features found in this AOI.")} else {
  if(spatial) {sl = sf::as_Spatial(sl)}
  }


`%+%` = crayon::`%+%`

cat(crayon::white("Returned object contains: ") %+% crayon::green(paste(length(sl), server,  type, '\n')))

return(sl)

}

