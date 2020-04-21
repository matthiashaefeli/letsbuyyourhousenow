window.addClient = function(e,form) {
  e.preventDefault();
  $.ajax({
    url: form.action,
    method: form.method,
    data: $(form).serialize(),
    beforeSend: function() {
      $('.errorDiv').html('').hide();
    },
    success: function(response) {
      if (response.message == 'saved') {
        $('.clientForm').hide();
        $('#clientResponse').show();
        $('#newClientCancelButton').hide();
      } else {
        $('#client_first_name, #client_last_name, #client_email, #client_tel').css('background-color', 'white');
        if (response.error.includes('first_name')) {
          $('#client_first_name').css('background-color', 'yellow').focus();
        } else if (response.error.includes('last_name')) {
          $('#client_last_name').css('background-color', 'yellow').focus();
        } else if (response.error.includes('email_or_tel')) {
          $('#client_email').css('background-color', 'yellow').focus();
          $('#client_tel').css('background-color', 'yellow').focus();
        } else if (response.error.includes('email')) {
          $('#client_email').css('background-color', 'yellow').attr('placeholder', 'Please add a valid email').focus();
        }
        $('#clientSubmit').attr('disabled', false);
      }
    }
  })
}

window.editClient = function(e, clientId) {
  e.preventDefault();
  $.ajax({
    url: clientId + '/edit',
    method: 'get',
    success: function(response) {
      $('#editClientLink').hide();
      $('.showClient').hide();
      $('.editClient').html(response);
    }
  })
}

window.cancelClientEdit = function(e) {
  e.preventDefault();
  $('#editClientLink').show();
  $('.showClient').show();
  $('.editClient').html('');
}

window.updateClient = function(e, form) {
  e.preventDefault();
  $.ajax({
    url: form.action,
    method: form.method,
    data: $(form).serialize(),
    success: function(response) {
      $('.clientHome').html(response);
      // $('.showClient').html(response).show();
      // $('.editClient').html('');
    }
  })
}

window.addNewClientForm = function(e) {
  e.preventDefault();
  $.ajax({
    url: 'clients/new',
    method: 'get',
    success: function(response) {
      const cancelButton = $("<button id='newClientCancelButton' onclick='cancelCLientNew()'>Cancel</button>")
      $('.clientForm').html(response).append(cancelButton);
      $('#newClientFormLink').hide();
      $('.clientsTableDiv').hide();
      $('#clientSubmit').val('Save');
    }
  })
}

window.cancelCLientNew = function() {
  $('#newClientFormLink').show();
  $('.clientForm').html('');
  $('.clientsTableDiv').show();
}

window.filterClientsTable = function(select) {
  const selected = $(select).val();
  $.ajax({
    url: 'client/client_entries',
    method: 'get',
    data: { status: selected },
    success: function(response) {
      $('.clientsTableDiv').remove();
      $(response).insertAfter('#clientResponse');
    }
  })
}
