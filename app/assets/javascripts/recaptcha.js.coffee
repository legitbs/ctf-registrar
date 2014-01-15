jQuery ($) ->
  return unless $('#legitbs_recaptcha').length == 1

  window.RecaptchaOptions =
    theme: 'custom'
    custom_theme_widget: 'legitbs_recaptcha'
