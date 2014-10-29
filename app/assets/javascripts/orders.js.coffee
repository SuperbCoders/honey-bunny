$ ->
  # Callback on city select
  $('#order_city').on 'change', ->
    updateShippingMethodSubtitles()
    updateTotalPrice()

  # Callback on shipping method change
  $("input[name='order[shipping_method_id]']").on 'change', ->
    filterCitiesByShippingMethod()
    updateShippingMethodSubtitles()
    updateTotalPrice()

  $('.js-order-item a.plus').on 'click', (event) ->
    event.preventDefault()
    increment(this)
    false

  $('.js-order-item a.minus').on 'click', (event) ->
    event.preventDefault()
    decrement(this)
    false

  $('input.js-order-item-quantity').on 'focusout', (event) ->
    $(this).closest('form').submit()

  increment = (button) ->
    $form = $(button).closest('form')
    $input = $form.find('input.js-order-item-quantity')
    value = $input.val()
    if /^\d+$/.test(value)
      $input.val(parseInt(value) + 1)
      $form.submit()

  decrement = (button) ->
    $form = $(button).closest('form')
    $input = $form.find('input.js-order-item-quantity')
    value = $input.val()
    if /^\d+$/.test(value)
      value = parseInt(value) - 1
      if value >= 0
        $input.val(value)
        $form.submit()

  # Filters cities list by current shipping method
  filterCitiesByShippingMethod = ->
    options = $(cities).filter("option[data-shipping-method-#{currentShippingMethod().val()}]")
    $('#order_city').html(options).trigger("chosen:updated")

  # Updates shipping methods with subtitles for current city
  updateShippingMethodSubtitles = ->
    $("input[name='order[shipping_method_id]']").each (index, shippingMethod) ->
      price = shippingPriceFor(shippingMethod, currentCity())
      subtitle = if price is undefined then '-' else "#{price} руб."
      $(shippingMethod).closest('label').find('span.price').text(subtitle)

  # Updates order total price value as sum of items price and shipping price
  window.updateTotalPrice = ->
    itemsPrice = parseFloat($('#order-items-price').text().toString().replace(' ', ''))
    shippingPrice = parseFloat(currentShippingPrice().toString().replace(' ', ''))
    totalPrice = humanizedMoney(itemsPrice + shippingPrice)
    $('#order-total-price').text(totalPrice)

  currentCity = ->
    value = $('#order_city').val()
    $("#order_city option[value='#{value}']")

  currentShippingMethod = ->
    $("input:checked[name='order[shipping_method_id]']")

  currentShippingPrice = ->
    shippingPriceFor(currentShippingMethod(), currentCity())

  shippingPriceFor = (shippingMethod, city) ->
    $(city).data("shipping-method-#{$(shippingMethod).val()}")

  humanizedMoney = (money) ->
    str = money.toString().split('.')
    if str[0].length >= 4
        str[0] = str[0].replace(/(\d)(?=(\d{3})+$)/g, '$1 ')
    if str[1] && str[1].length >= 4
        str[1] = str[1].replace(/(\d{3})/g, '$1 ')
    str.join('.')

  # Full list of cities. It could be filtered by data-shipping-method-* attribute
  cities = $('#order_city').html()

  # Setup input masks
  $('#order_phone').mask('+7 (999) 999-99-99')

  filterCitiesByShippingMethod()
  updateShippingMethodSubtitles()
  updateTotalPrice()