jQuery ($)->
  return unless $('.con-scoreboard, .con-picker').length == 1

  $('#gameboard .tooltip').tooltipster
    delay: 50
    speed: 250

  blink = (el)->
    el.animate
      'background-color': $.Color 'red'
    el.animate
      'background-color': $.Color 'transparent'

  pad = (n) ->
    return "0#{n}" if n < 10 && n >= 0
    n

  class Countdown
    constructor: ->
      @timer = $('#timer')
      @timerTemplate = $('#timer .template').html()
      @timer.html('')
      @update(@timer.data 'remain')
      @startPoll()
      @timer.show()
    startPoll: ->
      window.setTimeout(@poll(), 0)
    update: (@remain)->
      @remainPeg = new Date()
    poll: ->
      f = ->
        now = new Date()
        diff = (now - @remainPeg) / 1000
        if diff > @remain
          @timer.html "Game Over"
          return
        seconds = @remain - diff
        minutes = seconds / 60
        hours = minutes / 60
        cd =
          hours: ~~hours
          minutes: pad(~~(minutes % 60))
          seconds: pad(~~(seconds % 60))
        @timer.html(Mustache.render(@timerTemplate, cd))
        window.setTimeout(@poll(), 500)
      f.bind(this)

  Scoreboard = (->
    sbt = $('#scoreboard_template')
    template = sbt.html()
    sbt.remove()

    list = $('#scorelist table')

    return (scoreboard)->
      for t in scoreboard
        t['classname'] = 'current' if t['current']

      team_html = Mustache.render(template, {teams: scoreboard})

      list.html(team_html)
  )()


  class Poller
    constructor: ->
      @messages = $('#messages')
      return unless @messages.length > 0
      @messagePath = @messages.data('message-path')
      @interval = Number @messages.data('message-interval')
      @since = 0
      @startPoll()
    startPoll: ->
      window.setTimeout(@poll(), 0)
    requeue: ->
      finish = new Date().getTime()
      lag = finish - @start
      window.setTimeout(@poll(), @interval - lag)
    poll: ->
      f = ->
        @start = new Date().getTime()
        $.ajax
          url: @messagePath
          dataType: 'json'
          method: 'get'
          data:
            since: @since
          success: @receive()
          error: @error()
      f.bind(this)
    error: ->
      f = (jqx, textStatus, errorThrown)->
        @requeue()
      f.bind(this)
    receive: ->
      f = (data, textStatus, jqx)->
        for notice in data['notices']
          timestamp = new Date(notice['created_at'])

          if Number(timestamp) > @since
            @since = Number(timestamp) / 1000

            sender = if notice['team_id']
              '>private<'
            else
              '<global>'

          Log.log.append
            message: notice['body']
            timestamp: timestamp.toLocaleString()
            sender: sender
        Countdown.countdown.update data['remain']
        Scoreboard data['scoreboard']
        @requeue()
      f.bind(this)

  class Log
    constructor: ->
      @messageList = $('#messages ol')
      @messageTemplate = @messageList.html()
      @messageList.html('')
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
  Poller.poller = new Poller
  Countdown.countdown = new Countdown

  if document.location.hash == "#!solved"
    Log.log.appendLocal "You got it!"
  document.location.hash = ""
