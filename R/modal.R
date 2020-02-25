modal <- function(inputId, content = NULL) {
  value <- restoreInput(id = inputId, default = NULL)

  html <- div(
    id = inputId,
    class = "modal",

    div(
      class = "modal-content",
      span(class = "close", HTML("&times;")),

      content
    )
  )

  style <- glue::glue("
  #<<inputId>>.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
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
    var close_<<inputId>> = document.getElementsByClassName('close')[0];

    close_<<inputId>>.onclick = function() {
      modal_<<inputId>>.style.display = 'none';
    }

    window.onclick = function(event) {
      if (event.target == modal) {
        modal_<<inputId>>.style.display = 'none';
      }
    }
  ", .open = "<<", .close = ">>")

  component(html = html, script = script, style = style)
}
