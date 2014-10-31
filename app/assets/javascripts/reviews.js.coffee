$ ->
  $('body').on 'click', '.case-used .item', ->
    $(this).toggleClass('current')
    $(this).find('input[type=checkbox]').prop('checked', $(this).hasClass('current'))

  $('.js-reviews-more').on 'click', (event) ->
    event.preventDefault()
    $(this).closest('.case-cnt').find('li.item').removeClass('hidden')
    $(this).closest('.btn-wrap').hide()
    false