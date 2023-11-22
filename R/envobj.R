#' Print information about the objects in the current environment
#'
#' @param sort logical, if printing results in a formatted table should it be sorted by object type (default: TRUE)
#' @param colour logical, should the results be printed as a colour coded table based on object type (default: TRUE)
#'
#' @return details of each object in the environment including name, type/class and dimensions will be printed to the screen
#' @import {emphatic}
#' @export
#'
#' @examples envobj()
envobj <- function(sort = TRUE, colour = TRUE){
  # List all objects in the environment
  objects <- ls(envir=parent.frame())
  # TODO: add option to include a search pattern to only look at specific objects
  if (length(objects)<1) {
    cat("no objects")
  } else {
      # Assign columns & datatype to empty DataFrame
    object_info <- data.frame(Object=character(0),Class=character(0),Dimensions=character(0))
    for (obj in objects) {

      # Name
      obj_name <- obj

      # Type / Class
      obj_type <- class(get(obj))

      if(length(grep("matrix", obj_type))>0 | length(grep("data.frame", obj_type))>0){
        obj_class <- paste(obj_type, collapse = " ")
      } else if ((obj_type[1] == "list")) {
        obj_class <- obj_type
      } else if (obj_type[1] == "Date") {
        if (length(get(obj))>1) {
          obj_class <- paste(obj_type, "Vector")
        } else{
          obj_class <- obj_type
        }
      } else if (is.vector(get(obj)) | is.double(get(obj)) | typeof(get(obj))=="integer") {
        obj_class <- paste(obj_type, "Vector")
      } else {
        obj_class <- paste(obj_type, collapse = " ")
      }

      # Dimensions
      if (is.data.frame(get(obj))) {
        obj_dim <- paste(nrow(get(obj)), "obs. of", ncol(get(obj)), "variables")
      } else if(is.matrix(get(obj))) {
        obj_dim <- paste(nrow(get(obj)), "rows by", ncol(get(obj)), "cols")
      } else if(is.list(get(obj))) {
        obj_dim <- paste("list of", length(get(obj)))
      } else if(is.vector(get(obj)) | is.double(get(obj)) | typeof(get(obj))=="integer") {
        obj_dim <- paste0("[1:", length(get(obj)), "]")
      } else {
        obj_dim <- paste0(length(get(obj)))
      }

      object_info[nrow(object_info)+1,] <- c(obj_name, obj_class, obj_dim)
    }

    if (sort == TRUE ) { # Sort table by type before printing to the screen
      # put tibbles, data.frames and matrixes up the top
      # followed by lists

      object_info <- object_info[order(object_info$Class),]

      idx <- rep(10, nrow(object_info))
      idx[grep("data.frame", object_info$Class)] <- 2 # non tibble data.frame second
      idx[grep("tbl", object_info$Class)] <- 1 # tibble first
      idx[grep("matrix", object_info$Class)] <- 3 # matrix third
      idx[grep("list", object_info$Class)] <- 4 # list fourth

      object_info <- object_info[order(idx),]

    }

    if(colour == TRUE){
      object_info <- object_info |>
        emphatic::hl('#FFFFFF')

      if(length(grep("matrix", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#E69F00', rows = grep("matrix", Class))
      }

      if(length(grep("data.frame", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#56B4E9', rows = grep("data.frame", Class))
      }

      if(length(grep("Vector", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#009E73', rows = grep("Vector", Class))
      }

      if(length(grep("factor", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#0072B2', rows = grep("factor", Class))
      }

      if(length(grep("Date", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#F0E442', rows = grep("Date", Class))
      }

      if(length(grep("function", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#D55E00', rows = grep("function", Class))
      }

      if(length(grep("list", object_info$Class))>0){
        object_info <- object_info |>
          emphatic::hl('#CC79A7', rows = grep("list", Class))
      }

    }

      object_info


  }

}

