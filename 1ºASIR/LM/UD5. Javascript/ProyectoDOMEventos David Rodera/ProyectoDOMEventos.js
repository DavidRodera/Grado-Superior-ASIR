// Variables de control del juego
const numeroParaAdivinar = Math.floor(Math.random() * 100) + 1;
let cuentaIntentos = 0;
let registroDeNumeros = [];

// Elementos del DOM - Nombres actualizados según tu HTML
const entrada = document.getElementById('Numero'); // Cambiado de 'campoNumero' a 'Numero'
const boton = document.getElementById('botonJugar');
const mensaje = document.getElementById('recuadroMensaje');
const historial = document.getElementById('areaHistorial');

boton.addEventListener('click', () => {
    const numeroUsuario = parseInt(entrada.value);

    // Validación: Solo números entre 1 y 100
    if (isNaN(numeroUsuario) || numeroUsuario < 1 || numeroUsuario > 100) {
        alert("Introduce un número válido entre 1 y 100.");
        return;
    }

    cuentaIntentos++;
    registroDeNumeros.push(numeroUsuario);
    
    // Actualizar historial de texto
    historial.textContent = registroDeNumeros.join(" - ");
    
    // Cambiar la casilla correspondiente a la fila de las 'X'
    const casillaActual = document.getElementById(`casilla-${cuentaIntentos}`);
    if (casillaActual) {
        casillaActual.textContent = "X";
        casillaActual.classList.add('casilla-usada');
    }

    // Comprobación de resultados
    if (numeroUsuario === numeroParaAdivinar) {
        // Victoria
        mensaje.textContent = "¡HAS ACERTADO!";
        mensaje.className = "celda-estado estado-exito";
        finalizarPartida();
    } else {
        // Fallo
        if (cuentaIntentos >= 10) {
            // Fin de intentos
            mensaje.textContent = `HAS PERDIDO. Era el ${numeroParaAdivinar}`;
            mensaje.className = "celda-estado estado-fallo";
            finalizarPartida();
        } else {
            // Pistas
            mensaje.className = "celda-estado estado-fallo";
            if (numeroUsuario > numeroParaAdivinar) {
                mensaje.textContent = `${numeroUsuario} ES MAYOR`;
            } else {
                mensaje.textContent = `${numeroUsuario} ES MENOR`;
            }
        }
    }
    
    // Limpiar y enfocar para el siguiente intento
    entrada.value = "";
    entrada.focus();
});

function finalizarPartida() {
    entrada.disabled = true;
    boton.disabled = true;
    boton.style.opacity = "0.5";
    boton.style.cursor = "not-allowed";
}