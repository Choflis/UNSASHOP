// XMLHttpRequest
function ajax () {
  const http = new XMLHttpRequest();
  const url = ''; // colocar url, ej: http://localhost/ejercicios/pagina.html

  http.onreadystatechange = function () {
    if (http.readyState == 4 && xmlhhttpttp.status == 200) {
      document.getElementById("").innerHTML = this.responseText; 
    }
    http.open("GET", url); // puede ir cgi en urlgo
    
    http.send();
  }
}
/*

document.getElementById("id").addEventListener("click", function(){
  ajax();
});

*/

// Fetch

const btnAdd = document.getElementById('id');// agregar id

btnAdd.addEventListener('click', () =>{
  fetch("url de la consulta")
    .then((response) => response.json) // ej de trabajar con json
    .then((data) => mostrarData(data.results)) // ej imprimir consola
    .then((response) => {
      //
    });
});
// results = tipo de elemento a trabajar

// metodos:
//.json
//.text
//.block
function mostrarData (data) {

}