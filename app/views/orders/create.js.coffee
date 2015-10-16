<% if @order.persisted? %>
  redirect_path = "<%= @order.payment_method.name == 'w1' ? payment_order_url(@order) : success_order_url(@order) %>"
  <% items = @order.order_items.map do |order_item|
      {
        id: order_item.id,
        quantity: order_item.quantity,
        name: order_item.item.title,
        price: order_item.item.price_cents
      }
    end
  %>
  window.yaParams = {
    order_id: "<%= @order.id %>"
    order_price: "<%= @order.items_price %>"
    currency: "RUB"
    goods: <%= items.to_json.html_safe %>
  }

  yaCounter30951776.reachGoal('ORDER', window.yaParams);
  window.location.replace(redirect_path)
<% else %>
  form = $("<%=j render file: 'orders/new' %>").find('.forms')
  $('section.page-body .case-cart-address .forms').replaceWith(form)
  $('.chosen-select').chosen()
<% end %>
