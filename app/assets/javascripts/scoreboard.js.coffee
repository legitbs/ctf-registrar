# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($)->
  return unless $('.content#scoreboard').length == 1

  blink = (el)->
    el.animate
      'background-color': $.Color 'red'
    el.animate
      'background-color': $.Color 'transparent'

  class Log
    constructor: ->
      @messageList = $('#messages ol')
      @messageTemplate = @messageList.html()
      @messageList.html('')
      @appendLocal("Welcome to the 2013 DEF CON CTF Qualifications!")
      this
    appendLocal: (message) ->
      now = new Date
      @append
        message: message
        timestamp: now.toLocaleString()
        sender: ">local<"
    append: (message) ->
      new_entry = Mustache.render @messageTemplate, message
      @messageList.prepend new_entry
      @massage
      blink @messageList.children(':first-child')
    massage: ->
      if @messageList.find('li').length > 20
        @messageList('li:nth-child(20)').remove()
  Log.log = new Log

  challengeWindow = $('#challenge')
  challengeLinks = $('a.live_challenge')

  loadChallenge = (challengeId, url)->
    $.ajax 
      url: url
      dataType: 'json'
      method: 'get'
      success: (data)->
        new_data = Mustache.render(template, data)
        challengeWindow.html(new_data)
        $('#challenge_form').attr('action', url)
        challengeWindow.show()

  submitChallenge = (formData, url)->
    $.ajax 
      url: url
      data: formData
      dataType: 'json'
      method: 'post'
      success: (data, textStatus, jqx)->
        alert data
        document.location.href = "/scoreboard/choice"
      statusCode: 
        500: (data, textStatus, jqx)->
          Log.log.appendLocal "you broke it :("
        400: (data, textStatus, jqx)->
          response = $.parseJSON(data.responseText)
          if response['weird']
            return document.location.reload()
          else
            Log.log.appendLocal "Wrong answer :("
            el = challengeWindow.find('input#answer')
            blink el
            el.val('')



  challengeLinks.click (e) ->
    e.preventDefault()
    id = this.dataset['challengeId']
    url = this.href
    loadChallenge(id, url)

  challengeWindow.on 'click', 'a#close_button', (e)->
    challengeWindow.hide()
    e.preventDefault()

  challengeWindow.on 'submit', 'form', (e)->
    e.preventDefault()
    formData = $(this).serializeArray()
    submitChallenge(formData, this.action)
    false

  template = challengeWindow.html()
