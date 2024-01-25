document.addEventListener("DOMContentLoaded", function () {
  fetch('cgi-bin/get_products.pl')
      .then(response => response.json())
      .then(data => {
          const items = document.querySelectorAll('.item');

          data.forEach((producto, index) => {
              const item = items[index];
              item.querySelector('.titulo-item').textContent = producto.nombre;
              item.querySelector('.img-item').src = producto.imagen;
              item.querySelector('.precio-item').textContent = producto.precio;
              item.querySelector('.boton-item').setAttribute('onclick', `agregarAlCarrito('${producto.nombre}', '${producto.precio}')`);
          });
          ocultarElementosVacios();
      })
      .catch(error => console.error('Error al obtener los productos:', error));
});

function agregarAlCarrito(nombre, precio) {
  console.log(`Agregado al carrito: ${nombre} - Precio: ${precio}`);
}

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
