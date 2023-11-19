#' Print information about the objects in the current environment
#'
#' @param table logical, whether to print the object details formatted as a table or as a list to the screen (default: FALSE).
#' @param sort logical, if printing results in a formatted table should it be sorted by object type (default: FALSE)
#' @param colour logical, should the results be printed as a colour coded table based on object type (default: TRUE)
#'
#' @return details of each object in the environment including name, type/class and dimensions will be printed to the screen
#' @import {emphatic}
#' @export
#'
#' @examples envobj()
envobj <- function(table = FALSE, sort = FALSE, colour = TRUE){
  # List all objects in the environment
  objects <- ls(envir=parent.frame())
  # TODO: add option to include a search pattern to only look at specific objects
  if (length(objects)<1) {
    cat("no objects")
  } else {
    if(table == FALSE & colour == FALSE){ # Print info to the screen
      # Loop through each object and print its name, type, and dimensions if applicable
      for (obj in objects) {
        # Name
        cat("Object Name:", obj, "\n")

        # Type / Class
        obj_type <- class(get(obj))

        if ((obj_type[1] == "list")) {
          cat("Class:", obj_type, "\n")
        } else if (obj_type[1] == "Date") {
          if (length(get(obj))>1) {
            cat("Class:", obj_type, "Vector \n")
          } else{
            cat("Class:", obj_type, "\n")
          }
        } else if (is.vector(get(obj))) {
          cat("Class:", obj_type, "Vector\n")
        } else if (obj_type[1] %in% c("character", "numeric", "logical", "factor")) {
          cat("Class:", obj_type, "Value \n")
        } else {
          cat("Class:", obj_type, "\n")
        }

        # Dimensions
        if (is.data.frame(get(obj))) {
          cat("Dimensions:", nrow(get(obj)), "obs. of", ncol(get(obj)), "variables\n")
        } else if(is.matrix(get(obj))) {
          cat("Dimensions:", nrow(get(obj)), "rows by", ncol(get(obj)), "cols\n")
        } else if(is.list(get(obj))) {
          cat("Dimensions:", "list of", length(get(obj)), "\n")
        } else if(is.vector(get(obj))) {
          cat("Dimensions:", " [1:", length(get(obj)), "]\n", sep = "")
        }else {
          cat("Dimensions:", length(get(obj)), "\n")
        }

        cat("\n")
      }
    } else { # Display info in a table
      # Assign columns & datatype to empty DataFrame
      object_info <- data.frame(Object=character(0),Class=character(0),Dimensions=character(0))
      for (obj in objects) {

        # Name
        obj_name <- obj

        # Type / Class
        obj_type <- class(get(obj))

        if ((obj_type[1] == "list")) {
          obj_class <- obj_type
        } else if (obj_type[1] == "Date") {
          if (length(get(obj))>1) {
            obj_class <- paste(obj_type, "Vector")
          } else{
            obj_class <- obj_type
          }
        } else if (is.vector(get(obj))) {
          obj_class <- paste(obj_type, "Vector")
        } else if (obj_type[1] %in% c("character", "numeric", "logical", "factor")) {
          obj_class <- paste(obj_type, "Value")
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
        } else if(is.vector(get(obj))) {
          obj_dim <- paste0("[1:", length(get(obj)), "]")
        } else {
          obj_dim <- paste0(length(get(obj)))
        }

        object_info[nrow(object_info)+1,] <- c(obj_name, obj_class, obj_dim)
      }

      if (sort == TRUE ) { # Sort table by type before printing to the screen
        object_info <- object_info[order(object_info$Class),]
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

        if(length(grep("Date", object_info$Class))>0){
          object_info <- object_info |>
            emphatic::hl('#F0E442', rows = grep("Date", Class))
        }

        if(length(grep("Value", object_info$Class))>0){
          object_info <- object_info |>
            emphatic::hl('#0072B2', rows = grep("Value", Class))
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

}

