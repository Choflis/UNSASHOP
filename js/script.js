function enviarFormularioRegistro() {
    var user= document.getElementById('user').value;
    var password = document.getElementById('password').value;
    var type = document.getElementById('type').value;
    var name = document.getElementById('name').value;
    var card_number = document.getElementById('card_number').value;
    var card_expire = document.getElementById('card_expire').value;
    var card_code = document.getElementById('card_code').value;
    

    // Llamar a la función fetch para enviar los datos al script Perl
    fetch('./cgi-bin/registro.pl', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            nombreC: nombreC,
            password: password,
            
        }),
    })
    .then(response => response.json())
    .then(data => {
        console.log('Respuesta del servidor:', data);
    })
    .catch((error) => {
        console.error('Error en la solicitud:', error);
    });
}
