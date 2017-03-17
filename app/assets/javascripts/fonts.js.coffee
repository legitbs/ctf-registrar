jQuery ($)->
  window.WebFontConfig =
    google:
      families: [
        'Ubuntu:400,400italic,700,700italic',
        'Ubuntu+Mono:400',
        'Permanent+Marker'
        ]
  wf = document.createElement 'script'
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
  wf.type = 'text/javascript'
  wf.async = 'true'
  s = document.getElementsByTagName('script')[0]
  s.parentNode.insertBefore wf, s
