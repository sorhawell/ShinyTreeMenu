#' renderShinyTreeMenu renders the initial treemenu as a reactive
#' Shiny UI Output and this treemenu can then be updated using
#' \code{\link{updateShinyTreeMenu}}.
#'
#' \strong{shinyjs}
#' To use ShinyTreeMenu in SHiny, you need to load shinyjs::useShinyjs() in your UI.
#'
#'
#' @param treedata data.table; treedata - see \code{\link{ShinyTreeMenuHTML}} for more details.
#' @param level_icons character; Names of fa-icons to use for the tree - see \code{\link{ShinyTreeMenuHTML}} for more details.
#' @param input shiny modelue
#' @param output shiny modelue
#' @param session  shiny modelue
#' @param reactive_level_icons bool, are level_icons be reactive as treedata?
#'
#' @seealso \code{\link{ShinyTreeMenuOutput}}, \code{\link{updateShinyTreeMenu}} and \code{\link{ShinyTreeMenuHTML}}
#'
#' @examples "blop" #none so far
#'
#'
#' if (interactive()) {
#'
#'   shinyApp(
#'
#'     ui = fluidPage(
#'
#'       # ShinyTreeMenu uses shinyjs - so remember to include shinyjs in your UI
#'       shinyjs::useShinyjs(),
#'
#'       ShinyTreeMenuOutput("treemenu")
#'     ),
#'
#'     server = function(input, output, session) {
#'
#'       # Treedata has to be in the form of a reactive expression
#'       treedata <- reactive({
#'         ShinyTreeMenu::treetestdata
#'       })
#'
#'       # Use the shiny callModule to render the ShinyTreeMenu
#'       # Note that you should not include () when adding your reactive treedata
#'       shiny::callModule(ShinyTreeMenu::renderShinyTreeMenu,
#'                         id = "treemenu",
#'                         treedata = treedata,
#'                         level_icons = "tree")
#'
#'       # Here you will update the ShinyTreeMenu
#'       # As with the render function, you should not include () when adding your reactive treedata
#'       ShinyTreeMenu::updateShinyTreeMenu(
#'         treedata = treedata,
#'         treemenu_open = reactive({input$treemenu_open}),
#'         level_icons = "tree")
#'
#'
#'       # For the purpose of displaying the selection functionality
#'       observeEvent(input$treemenu, {
#'         showModal(
#'           modalDialog(
#'             paste("Selected id:", input$treemenu$val,
#'                   "| Selected level:", input$treemenu$level,
#'                   "| Selected row:", input$treemenu$row)
#'           )
#'         )
#'       })
#'
#'
#'     }
#'
#'   )
#'
#' }
#'
#'
#' @export
renderShinyTreeMenu <- function(input, output, session, treedata, level_icons,reactive_level_icons=FALSE){

  if(!shiny::is.reactive(treedata)) stop("treedata has to be a reactive expression")

  output$treemenu <- shiny::renderUI({

if(reactive_level_icons) level_icons = level_icons()

    treemenuout <-
      ShinyTreeMenu::ShinyTreeMenuHTML(
        treedata = treedata(),
        level_icons = level_icons)

  })

}
