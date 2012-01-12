function delete_image(elem, path) {
  var data = 'id=' +  elem.val();
  $.post(path,data);
}