document.addEventListener("DOMContentLoaded", function() {
    var pagarButton = document.getElementById("pagar");
    pagarButton.addEventListener("click", function() {
        totalFinal = pagarButton.value;
        console.log("totalFinal entrante:", totalFinal);
        fetch("cgi-bin/pagar.pl", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                total: totalFinal
            })
        })
        .then(response => response.json())
        .then(data => {
            const creditoA = document.getElementById("credito-nav");
            creditoA.textContent = "s/." + data.creditoF;
            console.log("costoFinal:", totalFinal);
            console.log("credito actualizado a:", data.creditoF);
            //totalFinal = 0;
        })
        .catch(error => {
            console.error("Error al realizar la solicitud de compra:", error);
        });
    });
    
});