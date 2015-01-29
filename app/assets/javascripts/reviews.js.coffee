$ ->
  $('body').on 'click', '.case-used .item', ->
    $(this).toggleClass('current')
    $(this).find('input[type=checkbox]').prop('checked', $(this).hasClass('current'))

  $('.js-reviews-more').on 'click', (event) ->
    event.preventDefault()
    $(this).closest('.case-cnt').find('li.item').removeClass('hidden')
    $(this).closest('.btn-wrap').hide()
    false

  #
  # Stars
  #
  $('body').on 'click', '.stars .star', ->
    resetStars()
    selectedValue = $(this).find('input').val()
    $(this).find('span').text(selectedValue)
    $(this).find('input').prop('checked', true)
    $('.stars .star').each (index, star) ->
      value = index + 1
      $star = $(star)
      if value <= selectedValue
        $star.addClass('star-fill')

  resetStars = ->
    $('.stars .star').removeClass('star-fill')
    $('.stars .star span').text('')
    $('.stars .star input').prop('checked', false)