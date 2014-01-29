jQuery ($) ->
  canvas = $('canvas#ziggurat').get(0)
  return unless canvas

  drawZigguratLevel = (ctx, width) ->
    shadow = '#B0A389'
    base = '#C0B7A3'
    highlight = '#EBDBB5'

    c = (color) ->
      ctx.fillStyle = color

    c base
    ctx.fillRect 0, 1, width, 5
    c shadow
    ctx.fillRect 0, 6, width, 1
    ctx.fillRect width, 1, 1, 6
  drawZiggurat = ->
    context = canvas.getContext '2d'

    context.scale 4, 4
    
    context.translate 222, 108
    for width in [140..345] by 15
      context.translate (-width / 2), 6
      drawZigguratLevel context, width
      context.translate (width / 2), 0

    $('#layer-ziggurat').css('background-image', "url(" + canvas.toDataURL('image/png') + ")")

  drawZiggurat()
