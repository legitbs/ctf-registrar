jQuery ($) ->
  zone = $('#hacker_zone')
  return unless zone.size() == 1

  canvas = zone.children('canvas').get(0)
  context = canvas.getContext '2d'

  macbook =
    base: '#898989'
    logo: '#FFFFFF'

  jeans =
    thigh: '#163685'
    calf: '#163685'

  dadjeans =
    thigh: '#3646aa'
    calf: '#3646aa'

  vito =
    skin: '#FFE8BA'
    shirt: '#384945'
    pants: jeans
    computer: macbook
    shoes: '#E28C05'

  sc =
    skin: '#784835'
    shirt: '#880088'
    pants: jeans
    computer: macbook
    shoes: '#2B2D41'

  da =
    skin: '#2F1D17'
    shirt: '#2B2D41'
    pants: dadjeans
    computer: macbook
    shoes: '#A2826E'
    
  drawHacker = (ctx, hackerColors) ->
    c = (color) ->
      ctx.fillStyle = color
    h = (color) ->
      c hackerColors[color]
    j = (color) ->
      c hackerColors.pants[color]
    n = (color) ->
      c hackerColors.computer[color]

    f = (x, y, w, h) ->
      ctx.fillRect x, y, w, h

    h 'shirt'
    f 4, 2, 3, 5

    h 'skin'
    f 5, 0, 2, 2
    f 5, 4, 1, 1
    f 4, 5, 1, 1

    j 'thigh'
    f 1, 7, 6, 1
    f 1, 8, 1, 1
    f 4, 8, 1, 1

    j 'calf'
    f 1, 9, 1, 4
    f 4, 9, 1, 4

    h 'shoes'
    f 0, 12, 2, 1
    f 3, 12, 2, 1

    n 'base'
    f 0, 4, 3, 2
    f 0, 6, 5, 1

    n 'logo'
    f 1, 5, 1, 1

  context.scale 16, 16
  drawHacker context, vito

  context.translate 10, 0
  drawHacker context, sc

  context.translate 10, 0
  drawHacker context, da