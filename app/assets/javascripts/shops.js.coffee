$ ->
  $('.js-shops-more').on 'click', (event) ->
    event.preventDefault()
    $(this).closest('.case-cnt').find('tr').removeClass('hidden')
    $(this).hide()
    false