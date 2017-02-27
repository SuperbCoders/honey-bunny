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
  # dataLayer.push({
  #     "ecommerce": {
  #         "purchase": {
  #             "actionField": {
  #                 "id" : "<%= @order.id %>",
  #                 "affiliation": "Яндекс.Маркет"
  #             },
  #             "products": <%= items.to_json.html_safe %>
  #         }
  #     }
  # });
  window.location.replace(redirect_path);
<% else %>
  form = $("<%=j render 'orders/form' %>").find('.forms')
  $('section.page-body .case-cart-address .forms').replaceWith(form)
  $('.chosen-select').chosen()
  $('html, body').animate({
      scrollTop: $(".case-cart-address").offset().top
  }, 2000);
<% end %>
