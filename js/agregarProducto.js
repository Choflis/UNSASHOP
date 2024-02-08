function agregarProducto() {
    console.log("...");
    var nombre = document.getElementById('nombre-popup').value;
    var imagen = document.getElementById('imagen-popup').value;
    var precio = document.getElementById('precio-popup').value;
    var stock = document.getElementById('stock-popup').value;
    console.log("nombre: ", nombre, "imagen", imagen, "precio", precio, "stock", stock);
   // if (nombre && imagen && precio && stock) {
        //var productosContainer = document.querySelector('.contenedor-items');

        //var productoDiv = document.createElement('div');
        //productoDiv.classList.add('item');

        //productoDiv.innerHTML = productoHTML;
        //productosContainer.insertBefore(productoDiv, productosContainer.lastElementChild);

        cerrarPopup();
    //} else {
        //alert('Por favor, completa todos los campos.');
    //}

    console.log("nombre: ", nombre, "imagen", imagen, "precio", precio, "stock", stock);
    
    fetch("cgi-bin/agregar_producto.pl", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            nombre: nombre,
            imagen: imagen,
            precio: precio,
            stock: stock
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log("Datos procesados correctamente:", data);
        console.log("nombre: ", nombre, "imagen", imagen, "precio", precio, "stock", stock);
        otraFuncion();
    })
    .catch(error => {
        console.error("Error al procesar los datos:", error);
        
    });

}