# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($)->
  return unless $('.con-tokens').length == 1

  firstCode = $('input#first-code')

  firstCode.attr('disabled', true)

  promiseBox = $('input#i-promise')

  promiseBox.change ->
    isChecked = promiseBox.is(':checked')
    firstCode.attr('disabled', not isChecked)

    firstCode.attr('placeholder', '') if isChecked
