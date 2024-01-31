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

//Cargar credito
document.addEventListener("DOMContentLoaded", function() {
    fetch('cgi-bin/get_credito.pl')
        .then(response => {
            if (!response.ok) {
                throw new Error(`Error en la solicitud: ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Datos recibidos:', data);
            const creditoUsuario = document.getElementById('credito-nav');
            if (creditoUsuario && data && data.credito !== undefined) {
                creditoUsuario.textContent = `s/.${data.credito}`;
            } else {
                console.error('Error: Datos de credito no disponibles en la respuesta.');
            }
        })
        .catch(error => console.error('Error al obtener el credito del usuario:', error));
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
