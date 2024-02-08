document.addEventListener("DOMContentLoaded", function() {
    const showPopupBtn = document.querySelector(".login-btn");
    const formPopup = document.querySelector(".form-popup");
    const hidePopupBtn = formPopup.querySelector(".close-btn");
    const correoInput = document.querySelector("input[name='nombreC']");
    const pregunta1Input = document.querySelector("input[name='p1']");
    const pregunta2Input = document.querySelector("input[name='p2']");
    const tipoUsuarioRadios = document.querySelectorAll("input[name='tipo_usuario_login']"); // Obtener todos los radios

    showPopupBtn.addEventListener("click", function(event) {
        event.preventDefault();

        const correo = correoInput.value;
        const pregunta1 = pregunta1Input.value;
        const pregunta2 = pregunta2Input.value;
        let tipoUsuario = ''; // Inicializar variable para guardar el tipo de usuario seleccionado

        // Iterar sobre los radios para encontrar el seleccionado
        tipoUsuarioRadios.forEach(function(radio) {
            if (radio.checked) {
                tipoUsuario = radio.value; // Obtener el valor del radio seleccionado
            }
            console.log("TIPO : ", tipoUsuario);
        });

        if (correo.trim() === '' || pregunta1.trim() === '' || pregunta2.trim() === '') {
            alert("Por favor complete todos los campos.");
            return;
        }

        fetch('cgi-bin/recuperar.pl', {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                correo: correo,
                pregunta1: pregunta1,
                pregunta2: pregunta2,
                tipoUsuario: tipoUsuario
            })
        })
        .then(response => {
            if (!response.ok) {
                throw new Error("Error en la solicitud al servidor.");
            }
            return response.json();
        })
        .then(data => {
            if (data.valido) {
                console.log("CONSULTA EXITOSA: ", data);
                document.querySelector(".blurOverlay").style.display = "block";
                document.querySelector(".form-popup").style.display = "block";
            } else {
                alert("Los datos ingresados no son válidos.");
            }
        })
        .catch(error => {
            console.error("Error:", error);
            alert("Hubo un error al procesar la solicitud.");
        });
    });

    hidePopupBtn.addEventListener("click", () => showPopupBtn.click());
});
