import random

class Pokemon:
    def __init__(self, nombre, codigo, menor_peso, mayor_peso, menor_altura, mayor_altura, *tipos):
        if len(tipos) <= 0 or len(tipos) > 2:
            raise NameError("Tipos de pokemon no validos")
        self.nombre = nombre
        self.codigo = codigo
        self.peso = random.randint(menor_peso, mayor_peso) #Uniform usará decimal
        self.altura = random.randint(mayor_altura, mayor_altura) #Randint usará enteros
        self.tipos = []
        for tipo in tipos:
            self.tipos.append(tipo)
    def __str__(self):
        return f"Pokemon: \n\tnombre: {self.nombre}, \n\tcodigo: {self.codigo}, \n\tpeso: {self.peso}, \n\taltura: {self.altura}, \n\ttipos: {self.tipos}"
class Equipo:
    def __init__(self, entrenador, nombre, *pokemons):
        if len(pokemons) != 3:
            raise IndexError("Tienen que ser 3 pokemons")
        self.entrenador = entrenador
        self.nombre = nombre
        self.pokemons = []
        for pokemon in pokemons:
            self.pokemons.append(pokemon)
    def __str__(self):
        resultado = f"Equipo: {self.nombre} - {self.entrenador} \n"
        for pokemon in self.pokemons:
            resultado += f"{pokemon} .\n"
        return resultado

pokemon = Pokemon("Ditto", 132, 2, 6, 20, 40, "normal")
print(pokemon)
equipo = Equipo("yo", "yogurt", pokemon, pokemon, pokemon)
print(equipo)

