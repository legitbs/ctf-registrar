jQuery ($) ->
  $('a[data-action=close]').click (event) ->
    $(event.currentTarget.parentElement).hide()
