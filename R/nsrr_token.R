#' NSRR Token
#'
#' @param token Token for NSRR resources.  Found at
#' \url{https://sleepdata.org/token}
#'
#' @return A character vector or NULL
#' @export
#'
#' @examples
#' is.null(nsrr_token())
#' if (!is.null(nsrr_token())) {
#'    res = nsrr_auth()
#'    res$authenticated
#' }
#' bad_res = nsrr_auth("")
#' bad_res$authenticated
#' nsrr_have_token()
#' nsrr_authenticated()
nsrr_token = function(token = NULL) {
  if (is.null(token)) {
    token = Sys.getenv("NSRR_TOKEN")
  }
  if (length(token) > 0) {
    if (token == "") {
      token = NULL
    }
  }
  token = trimws(token)
  if (length(token) == 0) {
    token = NULL
  }
  token
}

#' @export
#' @rdname nsrr_token
nsrr_have_token = function(token = NULL) {
  !is.null(nsrr_token(token = token))
}

#' @export
#' @rdname nsrr_token
nsrr_auth = function(token = NULL) {
  token = nsrr_token(token = token)

  url = paste0(nsrr_api_url(), "/account/profile.json")

  query = list()
  query$auth_token = token
  res = httr::GET(url, query = query)
  result = httr::content(res)
  result
}

#' @export
#' @rdname nsrr_token
nsrr_authenticated = function(token = NULL) {
  auth = nsrr_auth(token = token)
  auth$authenticated
}

