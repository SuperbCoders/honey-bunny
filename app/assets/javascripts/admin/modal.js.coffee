$ ->
  $('#myModal').on 'hidden.bs.modal', ->
    $(this).removeData('bs.modal')