var productoActual;
/*
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
*/
function guardarCambios() {
    // Obtener los valores modificados
    var nombreModificado = document.getElementById('nombre-popup-edit').value;
    var imagenModificada = document.getElementById('imagen-popup-edit').value;
    var precioModificado = document.getElementById('precio-popup-edit').value;

    // Aplicar los cambios al objeto productoActual
    if (nombreModificado) productoActual.nombre = nombreModificado;
    if (imagenModificada) productoActual.imagen = imagenModificada;
    if (precioModificado) productoActual.precio = precioModificado;

    cerrarPopup();
}
/*
function eliminarProducto() {
    
    console.log("Eliminar producto:", productoActual);
    cerrarPopup();
}
*/
function abrirPopup() {
    var popup = document.getElementById('popupAgregar');
    popup.style.display = 'block';
}
/*
function abrirPopupEditar() {
    var popupEditar = document.getElementById('popupEditar');
    popupEditar.style.display = 'block';
}
*/
function cerrarPopup() {
    var popup = document.getElementById('popupAgregar');
    popup.style.display = 'none';

    /*
    var popupEditar = document.getElementById('popupEditar');
    popupEditar.style.display = 'none';
    */
}
