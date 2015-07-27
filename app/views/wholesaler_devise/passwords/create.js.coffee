<% if resource.persisted? %>
  magnificPopup = $.magnificPopup.instance
  magnificPopup.close()
  $('#popupRestore #user-email').text('<%= resource.try(:email) %>')
  $.magnificPopup.open
    items:
      src: '#popupRestore'
    type: 'inline'
<% else %>
  magnificPopup = $.magnificPopup.instance
  magnificPopup.close()
  $('.forgot').html("<%=j render partial: 'wholesalers/popups/forgot' %>")

  $("#popupForgot .forgot").validate(
    rules: rules
    messages: messages
  )

  $.magnificPopup.open
    items:
      src: '#popupForgot'
    type: 'inline'
<% end %>
