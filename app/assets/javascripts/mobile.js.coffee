$ ->
  # Toggle items mobile menu
  if $('.case-sort').length

    toggleMobileMenu = ->
      $('.case-sort').toggleClass('case-sort_open') if $(window).width() < 960

    $('.case-sort .current a').click (e) ->
      e.preventDefault()
      toggleMobileMenu()
      false