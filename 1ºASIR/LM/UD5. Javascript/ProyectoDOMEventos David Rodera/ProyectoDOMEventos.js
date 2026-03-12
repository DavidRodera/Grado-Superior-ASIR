// Generamos número entre 1 y 100
const numeroSecreto = Math.floor(Math.random() * 100) + 1;
let intentos = 0;
let listaNumeros = [];

// Captura de elementos
const input = document.getElementById('inputNum');
const btn = document.getElementById('btnJugar');
const feedback = document.getElementById('feedback');
const visualLista = document.getElementById('listaNumeros');
const marcasX = document.querySelectorAll('#marcasIntentos span');

btn.addEventListener('click', () => {
    const valor = parseInt(input.value);

    // Validación simple
    if (isNaN(valor) || valor < 1 || valor > 100) return;

    intentos++;
    listaNumeros.push(valor);
    visualLista.innerText = listaNumeros.join(" ");

    // Iluminamos la "X" correspondiente en morado
    if (intentos <= 10) {
        marcasX[intentos - 1].classList.add('activo');
    }

    // Lógica de comparación
    if (valor === numeroSecreto) {
        feedback.innerText = "HAS ACERTADO";
        feedback.className = "feedback ganar";
        finalizar();
    } else if (intentos >= 10) {
        feedback.innerText = "HAS PERDIDO. ERA EL " + numeroSecreto;
        feedback.className = "feedback perder";
        finalizar();
    } else {
        // Pista de mayor o menor
        if (valor > numeroSecreto) {
            feedback.innerText = valor + " ES MAYOR";
        } else {
            feedback.innerText = valor + " ES MENOR";
        }
        feedback.className = "feedback pista";
    }

    input.value = "";
    input.focus();
});

function finalizar() {
    btn.disabled = true;
    input.disabled = true;
}