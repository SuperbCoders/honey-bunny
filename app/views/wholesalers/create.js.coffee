<% if @wholesaler.persisted? %>
  magnificPopup = $.magnificPopup.instance
  magnificPopup.close()

  $.magnificPopup.open
    items:
      src: '#popupSuccess'
    type: 'inline'
<% else %>
  magnificPopup = $.magnificPopup.instance
  magnificPopup.close()
  $('.register').html("<%=j render partial: 'wholesalers/popups/register' %>")

  $("#new_wholesaler.register").validate(
    rules: rules
    messages: messages
  )
  
  $.magnificPopup.open
    items:
      src: '#popupNew'
    type: 'inline'
<% end %>
