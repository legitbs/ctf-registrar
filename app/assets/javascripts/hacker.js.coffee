jQuery ($) ->
  zone = $('#hacker_zone')
  return unless zone.size() == 1

  skinColor = ->
    # random brightness
    brightness = 0.25 + (0.75 * Math.random())

    hue = (0.2833 * brightness * brightness) +
          (0.0179 * brightness) +
          (0.0932)

    saturation = (-0.1294 * brightness * brightness * brightness) +
                 (-1.2511 * brightness * brightness) +
                 ( 1.4062 * brightness) +
                  0.225

    arr = hsvToRgb(hue, saturation, brightness)

    "rgb(#{arr[0]}, #{arr[1]}, #{arr[2]})"

  jeansColor = ->
    # random brightness
    brightness = (0.75 * Math.random())

    hue = (0.50 + (0.10 * Math.random())) * 3.6

    saturation = (-2.8683 * brightness * brightness * brightness) +
                 ( -.5202 * brightness * brightness) +
                 ( 1.4118 * brightness) +
                   0.0032

    arr = hsvToRgb(hue, saturation, brightness)

    c = "rgb(#{arr[0]}, #{arr[1]}, #{arr[2]})"
    jeans =
      thigh: c
      calf: c

  randomPants = ->
    if Math.random() > 0.5
      return jeansColor()
    else
      return {thigh: shirtColor()}

  randomComputer = ->
    r = Math.random()
    if r > 0.5
      return macbook
    else if r > 0.25
      return thinkpad
    else
      return dell

  shirtColor = ->
    brightness = Math.random()
    hue = Math.random()
    saturation = 0.5 + (0.5 * Math.random())

    arr = hsvToRgb(hue, saturation, brightness)

    "rgb(#{arr[0]}, #{arr[1]}, #{arr[2]})"

  macbook =
    base: '#898989'
    logo: '#FFFFFF'

  thinkpad =
    base: '#444444'
    logo: '#f04444'

  dell =
    base: '#888888'
    logo: '#aaaaaa'

  vito = ->
    skin: skinColor()
    shirt: shirtColor()
    pants: randomPants()
    computer: randomComputer()
    shoes: shirtColor()

  drawHacker = (ctx, hackerColors) ->
    c = (color) ->
      ctx.fillStyle = color
    h = (color) ->
      c hackerColors[color]
    j = (color) ->
      c hackerColors.pants[color] || hackerColors.skin
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

  drawHackers = ->
    canvas = zone.children('canvas').get(0)
    context = canvas.getContext '2d'
    context.scale 16, 16
    drawHacker context, vito()
  
    context.translate 10, 0
    drawHacker context, vito()
  
    context.translate 10, 0
    drawHacker context, vito()


  drawHackers()
