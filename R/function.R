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
                   emo::ji("tropical"),
                   emo::ji("tropical"),
                   emo::ji("tropical"))

  if (print) {
    cat(crayon::bgCyan(message))
  }
  beepr::beep(3)
  invisible(message)
}

