registro = {}

print('')
print('Introducción de datos (escribe -1 en el país para finalizar)')
print('')

continuar = True

while continuar:
    pais = input("Nombre del país: ")

    if pais == "-1":
        continuar = False
    elif pais.isdigit() and pais != -1:
        print("Error: Debe introducir un nombre de país válido o -1 para finalizar.")
    else:
        poblacion = float(input(f"Población de {pais} (en millones): "))
        registro[pais] = poblacion

if len(registro) == 0:
    print('')
    print("Como no ha introducido ningún país, no hay nada que ordenar.")
else:
    paises_ordenados = sorted(registro.items(), key=lambda item: item[1], reverse=True)
    print('')
    print('Países ordenados de mayor a menor población:')
    print('')
    for indice, (pais, poblacion) in enumerate(paises_ordenados, start=1):
        print(f"{indice}-{pais}")
