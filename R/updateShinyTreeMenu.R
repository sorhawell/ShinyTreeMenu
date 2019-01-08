#' Update the ShinyTreeMenu
#'
#' updateShinyTreeMenu() updates the tree menu, when a new level is selected
#'
#' @param treedata data.table; treedata - see details for more
#' @param treemenu_open reactive expression; Id belonging to the branch you want to open.
#' @param level_icons character; Names of fa-icons to use for the tree - see [ShinyTreeMenuHTML()] for more details.
#' @param reactive_level_icons bool treat level_icons as unevaluated ractivem similar to treedata
#'
#' @return A HTML class character containing the tree menu
#'
#' @seealso \code{\link{ShinyTreeMenuOutput}}, \code{\link{renderShinyTreeMenu}} and \code{\link{ShinyTreeMenuHTML}}
#'
#' @inherit renderShinyTreeMenu examples
#'
#' @export
updateShinyTreeMenu <- function(treedata, treemenu_open, level_icons,
                                reactive_level_icons=FALSE){


  shiny::observeEvent(treemenu_open(), {
    if(reactive_level_icons) level_icons = level_icons()
    shinyjs::html(id = paste0("treemenu_open_", treemenu_open()$openid),
                  html =
                    ShinyTreeMenu::ShinyTreeMenuHTML(
                      treedata = treedata(),
                      select_id = treemenu_open()$openid,
                      level_icons = level_icons))
  })
}
