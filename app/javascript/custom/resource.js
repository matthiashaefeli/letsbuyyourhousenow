window.addNewResourceForm = function(e) {
  e.preventDefault();
  $.ajax({
    url: 'resources/new',
    method: 'get',
    success: function(response) {
      $('.newClientLinkDiv').hide();
      $(response).insertAfter('.newClientLinkDiv');
      $('#resource_name').css('background-color', 'yellow').focus();
    }
  })
}

window.cancelResourceNew = function(e) {
  e.preventDefault();
  $('.newClientLinkDiv').show();
  $('#new_resource').remove();
}

window.addResource = function(e, form) {
  e.preventDefault();
  $.ajax({
    url: form.action,
    method: form.method,
    data: $(form).serialize(),
    success: function(response) {
      $('#resourceSubmitButton, #resourceCancelButton').attr('disabled', false);
      $('#resource_name, #resource_url').css('background-color', 'white');
      if (response.error) {
        if (response.error == 'name') {
          $('#resource_name').css('background-color', 'yellow').focus();
        } else if (response.error == 'link') {
          $('#resource_url').css('background-color', 'yellow').focus();
        }
      } else {
        $('.newClientLinkDiv').show();
        $('#new_resource').remove();
        $('.resourcesTable').prepend(response);
      }
    }
  })
}

window.deleteResource = function(e, id, link) {
  e.preventDefault();
  const x = confirm('Are You sure')
  if (x === true) {
    $.ajax({
      url: 'resources/' + id,
      method: 'delete',
      success: function(response) {
        if (response.message == 'deleted') {
          $(link).closest('tr').remove();
        }
      }
    })
  }
}