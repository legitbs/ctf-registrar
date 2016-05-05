jQuery ($)->
  window.WebFontConfig =
    google:
      families: [
        'Open+Sans:300,400,400italic,700,800,800italic:greek,greek-ext,latin,vietnamese,cyrillic-ext,latin-ext,cyrillic',
        'Oxygen+Mono::latin'
        ]
  wf = document.createElement 'script'
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
  wf.type = 'text/javascript'
  wf.async = 'true'
  s = document.getElementsByTagName('script')[0]
  s.parentNode.insertBefore wf, s
