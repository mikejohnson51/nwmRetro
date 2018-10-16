#' @title Write Spatial Object
#' @description Save a spatial file to disk in a varitey of formats, a simplfied wrapper around \code{st_write}
#' @param obj a spatial or simple features object
#' @param file a path to the file name to be created. Must include an extension. Valid options include:
#' \itemize{
#'   \item shp
#'   \item csv
#'   \item gpkg
#'   \item geojson
#'   \item sqlite
#'   \item xlsx
#'   \item rda
#' }
#' @param layer layer name (varies by driver); if layer is missing, the basename of file is taken without the extension.
#' @return a file saved to the path given
#' @export
#' @author Mike Johnson


write = function(obj, file = stop("'file' must be specified"), layer = NULL){

  if(any(grep("Spatial", class(obj)))) { obj = sf::st_as_sf(obj)}

  good.ext = c('shp', 'csv', 'gpkg', 'geojson', 'sqlite', 'xlsx', 'rda')

  ext = getExtension(file)

  if(is.null(ext)){ stop("'file' must include an file name with extension") }

  if(!(ext %in% good.ext)) { stop(paste0("file must be one of: '.",  paste(good.ext, collapse = "', '."), "'")) }

  if(is.null(layer)){ layer = gsub(paste0(".", ext), "", basename(file)) }

  if(ext == 'rda'){
    save(obj, file = file, compress = 'xz')
  }else{

  suppressWarnings( sf::st_write(obj,
                                 dsn = file,
                                 layer = layer,
                                 delete_dsn = TRUE,
                                 quiet = TRUE) )
  }



  `%+%` = crayon::`%+%`

  cat(crayon::yellow(ext, 'file successfully written!'))

  return(obj)

  }

