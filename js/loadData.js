//Cargar productos
document.addEventListener("DOMContentLoaded", function () {
    fetch('cgi-bin/get_products.pl')
        .then(response => response.json())
        .then(data => {
            const items = document.querySelectorAll('.item');
  
            data.forEach((producto, index) => {
                const item = items[index];
                item.querySelector('.titulo-item').textContent = producto.nombre;
                item.querySelector('.img-item').src = producto.imagen;
                item.querySelector('.precio-item').textContent = `s/.${producto.precio}`;
                item.querySelector('.boton-item').setAttribute('onclick', `agregarAlCarrito('${producto.nombre}', '${producto.precio}')`);
            });
            ocultarElementosVacios();
            //obtenerCreditoUsuario();
        })
        .catch(error => console.error('Error al obtener los productos:', error));
});
  
//Agregar boton "Agregar al carrito"
function agregarAlCarrito(nombre, precio) {
        console.log(`Agregado al carrito: ${nombre} - Precio: ${precio}`);
  }
  
//Ocultar elementos no llenados
function ocultarElementosVacios() {
    const contenedor = document.getElementById("productos-container");
    const elementos = contenedor.getElementsByClassName("item");
  
    for (let i = 0; i < elementos.length; i++) {
        const titulo = elementos[i].getElementsByClassName("titulo-item")[0].innerText.trim();
        const imgSrc = elementos[i].getElementsByClassName("img-item")[0].getAttribute("src").trim();
        const precio = elementos[i].getElementsByClassName("precio-item")[0].innerText.trim();
  
      if (!titulo || !imgSrc || !precio) {
            elementos[i].style.display = "none";
      }
    }
}

//Cargar credito y perfil
document.addEventListener("DOMContentLoaded", function() {
    fetch('cgi-bin/get_datos.pl')
        .then(response => {
            if (!response.ok) {
                throw new Error(`Error en la solicitud: ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Datos recibidos:', data);
            const creditoUsuario = document.getElementById('credito-nav');
            const perfilUsuario = document.getElementById('perfil-nav');

            if (creditoUsuario && data && data.credito !== undefined &&
                perfilUsuario && data && data.perfil !== undefined) {
                creditoUsuario.textContent = `s/.${data.credito}`;
                perfilUsuario.textContent = `${data.perfil}`;
            } else {
                console.error('Error: Datos no disponibles en la respuesta.');
            }
        })
        .catch(error => console.error('Error al obtener los datos del usuario:', error));
});

//Mostrar errores de inicio de sesion
/*document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector('#form-login');
    const errorLabel = document.getElementById('errorLogin');

    form.addEventListener('submit', function (event) {
        event.preventDefault();

        const formData = new FormData(form);

        fetch('cgi-bin/login.pl', {
            method: 'post',
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(data, "text/xml");

            const errors = xmlDoc.getElementsByTagName("error");

            if (errors.length > 0) {
                const element = errors[0].getElementsByTagName("element")[0].textContent;
                const message = errors[0].getElementsByTagName("message")[0].textContent;

                if (element === "login") {
                    // Aquí puedes manejar el mensaje de error específico para el intento de inicio de sesión
                } else {
                    errorLabel.textContent = message;
                }
            } else {
                // Limpiar el mensaje de error si no hay errores
                errorLabel.textContent = '';
            }
        })
        .catch(error => console.error('Error al procesar el formulario:', error));
    });
});*/

//Funcionalidad de cambiar boton ACCEDER a CERRAR SESION
document.addEventListener('DOMContentLoaded', function () {
    const loginBtn = document.getElementById('login-btn');

    // Función para verificar el estado de inicio de sesión
    function checkLoginStatus() {
        // Hacer una solicitud AJAX al servidor para verificar el estado de inicio de sesión
        // Puedes usar Fetch API o XMLHttpRequest

        // Ejemplo con Fetch API:
        fetch('cgi-bin/check_login_status.pl')
            .then(response => response.json())
            .then(data => {
                if (data.isLoggedIn) {
                    // Si el usuario está autenticado, cambia el texto a "CERRAR SESIÓN"
                    loginBtn.textContent = 'CERRAR SESIÓN';
                    // Agrega un evento al botón para manejar el cierre de sesión
                    loginBtn.addEventListener('click', function () {
                        // Realiza acciones para cerrar la sesión (puede ser otra solicitud AJAX al servidor)
                        // Por ejemplo, redirige a una página de cierre de sesión
                        fetch('logout.pl')
                            .then(response => {
                                if (response.ok) {
                                    // Puedes realizar más acciones después de cerrar sesión, si es necesario
                                    window.location.href = 'index.html';
                                } else {
                                    console.error('Error al cerrar sesión:', response.statusText);
                                }
                            })
                            .catch(error => console.error('Error al cerrar sesión:', error));
                    });
                } else {
                    // Si el usuario no está autenticado, vuelve al texto original "ACCEDER"
                    loginBtn.textContent = 'ACCEDER';
                    // Elimina el evento de cierre de sesión
                    loginBtn.removeEventListener('click', function () {});
                }
            })
            .catch(error => console.error('Error al verificar el estado de inicio de sesión:', error));
    }

    // Llama a la función al cargar la página
    checkLoginStatus();
});

