var productoActual;

function editarPopup(nombre, imagen, precio) {
    productoActual = {
        nombre: nombre,
        imagen: imagen,
        precio: precio
    };

    document.getElementById('nombre-popup-edit').value = nombre;
    document.getElementById('imagen-popup-edit').value = imagen;
    document.getElementById('precio-popup-edit').value = precio;

    // Código para abrir el popup, si es necesario
    abrirPopupEditar();
}

function abrirPopupEditar() {
    var popupEditar = document.getElementById('popupEditar');
    popupEditar.style.display = 'block';
}

function guardarCambios() {
    // Obtener los valores modificados
    var nombreModificado = document.getElementById('nombre-popup-edit').value;
    var imagenModificada = document.getElementById('imagen-popup-edit').value;
    var precioModificado = document.getElementById('precio-popup-edit').value;

    // Aplicar los cambios al objeto productoActual
    if (nombreModificado) productoActual.nombre = nombreModificado;
    if (imagenModificada) productoActual.imagen = imagenModificada;
    if (precioModificado) productoActual.precio = precioModificado;

    // Aquí puedes agregar lógica para guardar los cambios en el producto
    cerrarPopup();
}

function eliminarProducto() {
    // Aquí puedes agregar lógica para eliminar el producto
    console.log("Eliminar producto:", productoActual);
    cerrarPopup();
}

function abrirPopup() {
    var popup = document.getElementById('popupAgregar');
    popup.style.display = 'block';
}

function abrirPopupEditar() {
    var popupEditar = document.getElementById('popupEditar');
    popupEditar.style.display = 'block';
}

function cerrarPopup() {
    var popup = document.getElementById('popupAgregar');
    popup.style.display = 'none';

    var popupEditar = document.getElementById('popupEditar');
    popupEditar.style.display = 'none';
}

function agregarProducto() {
    var nombre = document.getElementById('nombre-popup').value;
    var imagen = document.getElementById('imagen-popup').value;
    var precio = document.getElementById('precio-popup').value;

    if (nombre && imagen && precio) {
        var productosContainer = document.querySelector('.contenedor-items');

        var productoDiv = document.createElement('div');
        productoDiv.classList.add('item');

        var productoHTML = `
            <span class="titulo-item">${nombre}</span>
            <img src="${imagen}" alt="" class="img-item">
            <span class="precio-item">s/.${precio}</span>
            <button class="boton-item" onclick="editarPopup('${nombre}', '${imagen}', ${precio})">Editar producto</button>
        `;

        productoDiv.innerHTML = productoHTML;
        productosContainer.insertBefore(productoDiv, productosContainer.lastElementChild);

        document.getElementById('nombre-popup').value = '';
        document.getElementById('imagen-popup').value = '';
        document.getElementById('precio-popup').value = '';
        cerrarPopup();
    } else {
        alert('Por favor, completa todos los campos.');
    }
}
