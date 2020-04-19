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
        $('#new_client').hide();
        $('#clientResponse').show();
        $('#newClientCancelButton').hide();
      } else {
        response.error.forEach(element => {
          const p = $('<p>'+ element + '</p>');
          $('.errorDiv').append(p);
        });
        $('.errorDiv').show();
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
      $('.showClient').html(response).show();
      $('.editClient').html('');
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
      $('.clientsTable').hide();
    }
  })
}

window.cancelCLientNew = function() {
  $('#newClientFormLink').show();
  $('.clientForm').html('');
  $('.clientsTable').show();
}
