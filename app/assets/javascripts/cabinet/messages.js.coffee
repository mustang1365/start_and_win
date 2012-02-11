$ ->
  $('.message_button').click ->
    $('#message_status').val($(this).attr('id'))
    $('#messages_form').submit();
  check_buttons()
  $(".messages td input[type='checkbox']").click ->
    check_buttons()
  $('#check_all').click ->
    if $(this).attr('checked')
      $(".messages td input[type='checkbox']").attr('checked', 'checked')
    else
      $(".messages td input[type='checkbox']").removeAttr('checked')
    check_buttons()


###check witch link show###
check_buttons = ->
  $('.message_button').hide()
  if $(".messages td input[type='checkbox']:checked").size() > 0
    $('#deleted').show()
    if $(".messages input.read_checkbox[type='checkbox']:checked").size() > 0
      $('#unread').show()
    if $(".messages td input.unread_checkbox[type='checkbox']:checked").size() > 0
      $('#read').show()

