#' Says Aloha to a friend
#'
#' @param name a character
#' @param print
#'
#' @return (character) An aloha message
#' @export
#'
#' @examples say_aloha("Bob")
say_aloha <- function(name, print = TRUE) {

  message <- paste("Aloha,",
                   name,
                   emo::ji("palm_tree"),
                   emo::ji("sunny"),
                   emo::ji("ocean"))

  if (print) {
    cat(crayon::bgGreen(message))
  }

  invisible(message)
}
