document.addEventListener("DOMContentLoaded", function() {
    var pagarButton = document.getElementById("pagar");
    var productosContainer = document.getElementById("productos-container");
    var items = productosContainer.querySelectorAll(".item");
    
    pagarButton.addEventListener("click", function() {
        var cantidadesPorId = {};
        
        items.forEach(function(item){
            var cantidadC = item.getAttribute("data-cantidad");
            var idC = item.getAttribute("data-id");
            console.log("ID PR: ", idC, "CANTIDAD: ", cantidadC);
            //cantidadesPorId[idC] = parseInt(cantidadC);
            cantidadesPorId[idC] = cantidadC;
        });

        var totalFinal = pagarButton.value;
        console.log("totalFinal entrante:", totalFinal);
        console.log("productos seleccionados: ", cantidadesPorId);
    
        var productosCLA = [];
        var productosCLH = {};
        Object.entries(cantidadesPorId).forEach(([idC, cantidadC]) => {
            if (cantidadC > 0) {
                productosCLA.push({ id: idC, cantidadC: cantidadC });
                productosCLH[idC] = cantidadC;
                console.log("id prueba: ", idC);
            }
        });
        console.log(productosCLA);
        console.log(productosCLH);

        fetch("cgi-bin/pagar.pl", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify()
        })
        .then(response => response.json())
        .then(data => {
            const creditoA = document.getElementById("credito-nav");
            creditoA.textContent = "s/." + data.saldoF;
            console.log("costoFinal:", totalFinal);
            console.log("credito actualizado a:", data.saldoF);
            //totalFinal = 0;
        })
        .catch(error => {
            console.error("Error al realizar la solicitud de compra:", error);
        });
    });
});
