jQuery ($) ->
  display = $('#tweet_length')
  return unless display.length == 1

  area = $('textarea#notice_body')
  tweet_checkbox = $('#notice_tweet')

  area.bind 'input propertychange', (event) ->
    l = area.val().length
    display.text l
    if l > 140
      tweet_checkbox.prop 'disabled', true
      tweet_checkbox.prop 'checked', false
      display.addClass 'too_long'
    else
      tweet_checkbox.prop 'disabled', false
      tweet_checkbox.prop 'checked', true
      display.removeClass 'too_long'

jQuery ($) ->
  picker = $('#category_picker')
  return unless picker.length == 1

  template = '{{#challenges}}' + picker.find('tbody').html() + '{{/challenges}}'
  picker.find('tbody').empty()

  select = picker.find('select')

  uri = (id) ->
    picker.data('path').replace('_', id)
  
  render = (data) ->
    picker.find('table').show()
    b = picker.find('tbody')
    b.html Mustache.render(template, data)

  update = ->
    $.ajax
      url: uri(select.val())
      success: render

  select.change update

  update()
