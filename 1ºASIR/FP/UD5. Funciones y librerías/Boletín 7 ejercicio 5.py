#Haz una función en python que reciba dos fechas en formato “DD/MM/YYYY” y compruebe si
#ambas son correctas y en caso afirmativo cual de ambas es mas antigua. Contempla los
#meses que tienen 30 y/o 31 días, los años bisiestos, etc

def bisiesto(anio):
    return (anio % 4 == 0 and anio % 100 != 0) or (anio % 400 == 0)


def es_fecha_valida(fecha_str):
    try:
        partes = fecha_str.split('/')
        if len(partes) != 3: return False

        dia, mes, anio = map(int, partes)

        if mes < 1 or mes > 12 or anio < 1:
            return False

        dias_por_mes = [31, 29 if bisiesto(anio) else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        if dia < 1 or dia > dias_por_mes[mes - 1]:
            return False

        return True
    except ValueError:
        return False


def comparar_fechas(f1, f2):
    if not es_fecha_valida(f1) or not es_fecha_valida(f2):
        return "Una o ambas fechas son incorrectas."

    d1, m1, a1 = map(int, f1.split('/'))
    d2, m2, a2 = map(int, f2.split('/'))

    fecha1 = (a1, m1, d1)
    fecha2 = (a2, m2, d2)

    if fecha1 < fecha2:
        return f"La fecha más antigua es: {f1}"
    elif fecha2 < fecha1:
        return f"La fecha más antigua es: {f2}"
    else:
        return "Ambas fechas son iguales."


fecha_a = input('Introduce la primera fecha: ')
fecha_b = input('Introduce la segunda fecha: ')
print('')
print(comparar_fechas(fecha_a, fecha_b))