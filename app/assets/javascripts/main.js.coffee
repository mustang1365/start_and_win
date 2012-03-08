$ ->
  if $('#flash_notice').size() > 0
    $.jGrowl($('#flash_notice').html(), {sticky: true});
  if $('#flash_alert').size() > 0
    $.jGrowl($('#flash_alert').html(), {sticky: true});