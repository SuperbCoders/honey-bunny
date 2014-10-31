<% if @review.persisted? %>
magnificPopup = $.magnificPopup.instance
magnificPopup.close()
$('#popup-comment #review_text').val('')
$.magnificPopup.open
  items:
    src: '#popup-review-thanks'
  type: 'inline'
<% else %>
$('#popup-comment #popup-form').html('<%=j render partial: 'reviews/form', locals: { review: @review } %>')
<% end %>