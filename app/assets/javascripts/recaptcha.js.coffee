jQuery ($) ->
  widget = $('#legitbs_recaptcha')
  return unless widget.length == 1

  window.RecaptchaOptions =
    theme: 'custom'
    custom_theme_widget: 'legitbs_recaptcha'

  loadChallenge = ->
    recaptchaLoader = document.createElement 'script'
    recaptchaLoader.src = "https://www.google.com/recaptcha/api/challenge?k=#{widget.data 'pubkey'}"
    document.body.appendChild recaptchaLoader
    enqueueLoadScript()

  loadScript = ->
    unless window.RecaptchaState?
      return enqueueLoadScript()
    s = window.RecaptchaState.server
    scriptLoader = document.createElement 'script'
    scriptLoader.src = "#{s}js/recaptcha.js"
    document.body.appendChild scriptLoader
    enqueueDecorateLinks()

  enqueueLoadScript = ->
    window.setTimeout loadScript, 500

  loadChallenge()

  decorateLinks = ->
    unless window.Recaptcha?
      return enqueueDecorateLinks()
    noBubbs = (f) ->
      ->
        f()
        false
    for link in widget.find('a.lbs_recap')
      l = $(link)
      if l.data('help')?
        l.on 'click', noBubbs Recaptcha.showhelp
      if l.data('reload')?
        l.on 'click', noBubbs Recaptcha.reload
      if l.data('become')?
        becoming = ->
          Recaptcha.switch_type $(this).data('become')
          false
        l.on 'click', becoming

  enqueueDecorateLinks = ->
    window.setTimeout decorateLinks, 500
