jQuery ($)->
  config =
    google:
      families: [
        'Rambla:400,700,400italic,700italic:latin,latin-ext',
        'Michroma::latin'
        ]
  wf = document.createElement 'script'
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
  wf.type = 'text/javascript'
  wf.async = 'true'
  s = document.getElementsByTagName('script')[0]
  s.parentNode.insertBefore wf, s
