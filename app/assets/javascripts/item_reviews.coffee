$ ->
  feedbacksContainer = $('#feedbacksContainer')
  btnMore = $('#btnMore')

  $('.open-feedback-popup').magnificPopup
    type: 'inline'
    midClick: true

  $('#rating').rateYo
    rating: 0
    fullStar: true
    starWidth: '32px'
    spacing: '10px'
    onSet: (rating, rateYoInstance) ->
      $('.js-review-rating').val rating
      return

  feedbacksCount = feedbacksContainer.find('.item').length
  if feedbacksCount > 3
    btnMore.css 'display', 'inline-block'
    btnMore.find('.feedbacks-left').text feedbacksCount - 3

  btnMore.click ->
    feedbacksContainer.find('.item').show()
    $(this).hide()
    return

  return
