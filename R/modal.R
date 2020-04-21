modalButton <- function(inputId, content = NULL, modalId = NULL, attributes = "") {
  actions <- list(
    click = glue::glue("toggleModal('{modalId}')")
  )

  button(inputId, content, actions, attributes)
}

modal <- function(inputId, content = NULL, open = FALSE, softClose = TRUE, closeButton = TRUE) {
  value <- restoreInput(id = inputId, default = NULL)

  classList <- ifelse (open, "modal open", "modal")

  if(softClose) {
    softClose <- glue::glue("
      $(window).on('click' , function(event) {
        if (event.target == modal_<<inputId>>) {
          closeModal('<<inputId>>')
        }
      })
    ", .open = "<<", .close = ">>")
  } else {
    softClose <- ""
  }

  html <- div(
    id = inputId,
    class = classList,

    tagList(
      tags$head(
        tags$script(glue::glue("
          var openModal = function(id) {
            eval(`modal_${id}.classList.add('open')`)
          }
          var closeModal = function(id) {
            eval(`modal_${id}.classList.remove('open')`)
          }
          var toggleModal = function(id) {
            eval(`modal_${id}.classList.toggle('open')`)
          }
        ", .open = "<<", .close = ">>"))
      ),
      div(
        class = "modal-content",
        if(closeButton) span(class = "close", HTML("&times;")),

        content
      )
    )
  )

  style <- glue::glue("
  #<<inputId>>.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 10000; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  }

  .modal.open {
    display: flex !important;
  }

  /* Modal Content/Box */
  #<<inputId>> .modal-content {
    background-color: #fefefe;
    margin: auto; /* 15% from the top and centered */
    padding: 20px;
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
  }

  /* The Close Button */
  #<<inputId>> .close {
    color: red;
    float: right;
    font-size: 28px;
    font-weight: bold;
  }

  #<<inputId>> .close:hover,
  #<<inputId>> .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
  }
  ", .open = "<<", .close = ">>")

  script <- glue::glue("
    var modal_<<inputId>> = document.getElementById('<<inputId>>');
    var close_<<inputId>> = $('#<<inputId>> .close');

    if(!!close_<<inputId>>) {
      close_<<inputId>>.on('click', function() {
        closeModal('<<inputId>>')
      })
    }
    <<softClose>>
  ", .open = "<<", .close = ">>")

  component(html = html, script = script, style = style)
}
