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
  var datosObj = JSON.parse(datos);

  document.getElementById('nombreC').value = datosObj[0];
  document.getElementById('dni').value = datosObj[1];
  document.getElementById('celular').value = datosObj[2];
  document.getElementById('tipoUsuario').value = datosObj[3];
  document.getElementById('nombreUsuario').value = datosObj[4];
  document.getElementById('correo').value = datosObj[5];
  document.getElementById('idTarjeta').value = datosObj[6];
}

