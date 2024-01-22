document.addEventListener('DOMContentLoaded', function() {
  const http = new XMLHttpRequest();
  http.open('GET', 'cgi-bin/perfil.pl', true);
  http.onreadystatechange = function() {
      if (http.readyState == 4 && http.status == 200) {
          actualizarCampos(http.responseText);
      }
  };
  http.send();
});

function actualizarCampos(datos) {
  var datosArray = datos.split(',');

  document.getElementById('nombreC').value = datosArray[0];
  document.getElementById('dni').value = datosArray[1];
  document.getElementById('celular').value = datosArray[2];
  document.getElementById('tipoUsuario').value = datosArray[3];
  document.getElementById('nombreUsuario').value = datosArray[4];
  document.getElementById('correo').value = datosArray[5];
  document.getElementById('idTarjeta').value = datosArray[6];
}
