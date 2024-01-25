function enviarFormularioRegistro() {
    var user= document.getElementById('user').value;
    var password = document.getElementById('password').value;
    var type = document.getElementById('type').value;
    var name = document.getElementById('name').value;
    var card_number = document.getElementById('card_number').value;
    var card_expire = document.getElementById('card_expire').value;
    var card_code = document.getElementById('card_code').value;
    

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

document.addEventListener('DOMContentLoaded', function () {
  var xhr = new XMLHttpRequest();

  xhr.open('GET', 'cgi-bin/obtener_credito.pl?nombre_usuario=nombre_de_usuario', true);

  xhr.onload = function () {
      if (xhr.status >= 200 && xhr.status < 300) {
          var xmlDoc = xhr.responseXML;
          var credito = xmlDoc.getElementsByTagName('credito')[0].textContent;

          document.getElementById('credito-nav').textContent = 's/.' + credito;
      } else {
          console.error('Error al obtener el crédito del usuario');
      }
  };

  xhr.onerror = function () {
      console.error('Error de red al intentar obtener el crédito del usuario');
  };
  xhr.send();
});