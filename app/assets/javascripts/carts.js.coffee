$ ->
  # Show "Thank you!" text on all .js-thanks buttons
  $('body').on 'click', '.js-thanks', (event) ->
    originalText = $(this).text()
    thanksText = 'Спасибо'
    $(this)
    .animate {opacity:0}, 1000, ->
      $(this).html(thanksText)
    .animate {opacity: 1}, 1000, ->
      $(this)
      .animate {opacity:0}, 1000, ->
        $(this).html(originalText)
      .animate {opacity: 1}, 1000