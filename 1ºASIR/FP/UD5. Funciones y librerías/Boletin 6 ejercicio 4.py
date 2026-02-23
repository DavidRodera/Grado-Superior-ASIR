#Escribir una función en python que reciba una cadena de texto que representa una fracción y
#nos devuelva su valor en decimal. La fracción tiene que ser introducida con el formato:
#numerador/denominador, siendo numerador y denominador dos números enteros. Si
#introducimos algo que no corresponda con esto debería de devolver un cero
#EJEMPLOS DE EJECUCIÓN:
#INVOCACIÓN DE LA FUNCIÓN RESULTADO EN LA CONSOLA
#print(fraccion(“25/10”))
#print(fracción(“a/10”))
#print(fracción(“//10”))
#print(fracción(“10”))
#2.5
#0
#0
#0

def fraccion(texto=""):
    if texto.count("/") != 1:
        return 0

    numerador, denominador = texto.split("/")

    if not numerador.isdecimal() or not denominador.isdecimal():
        return 0

    num = int(numerador)
    den = int(denominador)

    if den == 0:
        return 0

    return num / den

operacion = input('Introduce la fracción (a/b): ')
print(fraccion(operacion))