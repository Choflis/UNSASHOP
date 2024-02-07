const showPopupBtn = document.querySelector(".login-btn");
const formPopup = document.querySelector(".form-popup");
const hidePopupBtn = formPopup.querySelector(".close-btn");
const signupLoginLink = formPopup.querySelectorAll(".bottom-link a");

//animacion popup
showPopupBtn.addEventListener("click", () => {
    document.body.classList.toggle("show-popup");
});

//oculta animacion 
hidePopupBtn.addEventListener("click", () => showPopupBtn.click());