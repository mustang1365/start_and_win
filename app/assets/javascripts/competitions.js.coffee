# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#competition_model_to_main_category_attributes_main_category_id').change ->
    data = 'category_id=' + $('select#competition_model_to_main_category_attributes_main_category_id option:selected').val() + '&model_type=competition'
    $.get('/admin/admin_shared/load_subcategories',data)