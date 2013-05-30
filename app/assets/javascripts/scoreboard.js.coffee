# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($)->
  return unless $('.content#scoreboard').length == 1

  challengeWindow = $('#challenge')
  challengeLinks = $('a.live_challenge')

  loadChallenge = (challengeId, url)->
    $.ajax url: url, dataType: 'json', success: (data)->
      new_data = Mustache.render(template, data)
      challengeWindow.html(new_data)
      $('#challenge_form').attr('action', url)

  challengeLinks.click (e) ->
    e.preventDefault()
    id = this.dataset['challengeId']
    url = this.href
    loadChallenge(id, url)
    challengeWindow.show()
    
  challengeWindow.on 'click', 'a#close_button', (e)->
    challengeWindow.hide()
    e.preventDefault()

  template = challengeWindow.html()
