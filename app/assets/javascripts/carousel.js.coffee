$ ->
  $('ul.carousel').each (index, element) ->
    id = $(element).data('id')
    $("#carousel-#{id}").carouFredSel
      auto: false
      responsive: true
      scroll: 1
      prev: "#carousel-prev-#{id}"
      next: "#carousel-next-#{id}"
      pagination: "#carousel-pag-#{id}"
      items:
        visible: 1
        width: 740
        height: '60%'
      swipe:
        onMouse: true
        onTouch: true