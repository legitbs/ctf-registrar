jQuery ($) ->
  data_elem = $('table#histogram')
  return unless data_elem.length == 1

  google.charts.load 'current',
    packages: ['corechart']

  google.charts.setOnLoadCallback ()->
    data = new google.visualization.DataTable()
    data.addColumn 'datetime', 'End Time'
    data.addColumn 'number', 'Solve Count'
    data.addColumn
      type: 'boolean'
      label: 'Complete'
      role: 'scope'

    rows = data_elem.find('tbody tr').map (el)->
      [[new Date(this.dataset['end']),
        parseInt(this.dataset['count']),
        (this.dataset['complete'] == "")
        ]]

    data.addRows rows.toArray()

    canvas = $('#histogram_canvas')

    chart = new google.visualization.ColumnChart canvas.get(0)

    body = $('body')

    chart.draw data,
      axisTitlesPosition: 'none'
      bar:
        groupWidth: '100%'
      backgroundColor: $.Color(body.css('background-color')).toHexString()
      chartArea:
        left: 0
        top: 0
        width: canvas.width()
        height: 180
      enableInteractivity: false
      fontName: 'Ubuntu'
      legend:
        position: 'none'
      vAxes:
        0:
          gridlines:
            count: 0
