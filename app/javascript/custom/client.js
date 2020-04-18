function addClient(e,form) {
  e.preventDefault();
  $.ajax({
    url: form.action,
    method: form.method,
    data: $(form).serialize(),
    beforeSend: function() {
      $('.errorDiv').html('').hide();
    },
    success: function(response) {
      if (response == 'saved') {
        $('#new_client').hide();
        $('#clientResponse').show();
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

export default addClient