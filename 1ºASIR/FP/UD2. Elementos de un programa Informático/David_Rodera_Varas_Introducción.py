#Dar una idea general al usuario
print('Un rectángulo es un paralelogramo que tiene los cuatro ángulos rectos y los lados contiguos desiguales, y suele verse así.')
print('')
print ('-------------------------------------------')
print('|                                          |')
print('|                                          |')
print('|                                          | --> altura')
print('|                                          |')
print('|                                          |')
print('|                                          |')
print(' ------------------------------------------')
print('                     ^')
print('                     |')
print('                    base')

# Damos las instrucciones al usuario, creando las variables de los lados a partir de las preguntas y haciendo la operación
print('')
altura = float(input('Escribe la longitud de la altura: '))
base = float(input('Escribe la longitud de la base: '))
area = altura * base

# Damos el resultado al usuario
print('')
print('El area de un rectángulo es = base x altura')
print('')
print('')
print(f'El area del rectángulo es: {area}m^2')