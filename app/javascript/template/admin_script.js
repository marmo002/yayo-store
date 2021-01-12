window.addEventListener("turbolinks:load", () => {

    const element = document.querySelector(".resend_ref_code_form");
    
    if (element) {
        
        element.addEventListener("ajax:success", (event) => {
            const [_data, _status, xhr] = event.detail;
    
            if (_status == "OK") {
                // Hide modal
                $('#resend_ref_code').modal('toggle')
                
                // Display alert message
                let alertContent = '<div class="main-alerts alert alert-success alert-dismissible fade show" role="alert">' +
                                        'Se envio codigo de referencia satisfactoriamente!' +
                                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                            '<span aria-hidden="true">&times;</span>' +
                                        '</button>' +
                                    '</div>';
                document.querySelector('#alerts-container').insertAdjacentHTML('afterbegin', alertContent);
    
            }
        });
    
    }


});