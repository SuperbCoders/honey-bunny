<% if @review.persisted? %>
  magnificPopup = $.magnificPopup.instance
  magnificPopup.close()
  $('#popupPop #review_message').val('')
  $("#rating").rateYo("rating", 0)
  $.magnificPopup.open
    items:
      src: '#popupDone'
    type: 'inline'
<% else %>
  <% if user_signed_in?%>
    $('#popupPop .errors').html("Заполните все поля")
  <% else %>
    $('#popupPop').find('.step1').hide();
    $('#popupPop').find('.step2').show();
  <% end %>
<% end %>
