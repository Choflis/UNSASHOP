document.addEventListener("DOMContentLoaded", function() {
    var cantidadesPorId = {};
    var pagarButton = document.getElementById("pagar");
    var productosContainer = document.getElementById("productos-container");
    
    pagarButton.addEventListener("click", function() {
        totalFinal = pagarButton.value;
        console.log("totalFinal entrante:", totalFinal);

        var productosF = [];
        for (const [productId, cantidad] of Object.entries(productosMap)) {
            if (cantidad > 0) {
                productosF.push({ id: productId, cantidad: cantidad });
            }
        }

        fetch("cgi-bin/pagar.pl", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                productos: productosF
            })
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