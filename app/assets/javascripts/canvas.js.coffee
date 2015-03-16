jQuery ($)->
  class Canvasdown
    constructor: ->
      @loadRemainder()
      @pickCanvas()
      @establishContext()
      @grabImage()
    pickCanvas: ->
      @canvas = $('#countdown')[0]
    establishContext: ->
      @context = @canvas.getContext '2d'
      @context.fillStyle = '#f5b34a'
      @context.textAlign = 'center'
      @context.textBaseline = 'middle'
      @context.font = '72px Michroma'
    loadRemainder: ->
      @remain = $('#timer').data 'remain'
      @remainPeg = new Date()
    grabImage: ->
      @imageJq = $ '#canvas-template'
      @image = @imageJq[0]
    poll: ->
      f = ->
        @clear()
        @context.drawImage @image, 0, 0
        @context.fillText @remaining(), @canvas.width / 2, 360
        window.setTimeout @poll(), 500
      f.bind(this)
    startTimer: ->
      window.setTimeout(@poll(), 0)
    clear: ->
      @context.clearRect 0, 0, @canvas.width, @canvas.height
    remaining: ->
      now = new Date()
      diff = (now - @remainPeg) / 1000
      if diff > @remain
        return 'Game Over'
      seconds = @remain - diff
      minutes = seconds / 60
      hours = minutes / 60

      display_hours = ~~hours
      display_minutes = @pad(~~(minutes % 60))
      display_seconds = @pad(~~(seconds % 60))

      "#{display_hours}:#{display_minutes}:#{display_seconds}"
    pad: (n) ->
      return "0#{n}" if n < 10 && n >= 0
      n

  window.canvas_down = new Canvasdown
  window.canvas_down.startTimer()
