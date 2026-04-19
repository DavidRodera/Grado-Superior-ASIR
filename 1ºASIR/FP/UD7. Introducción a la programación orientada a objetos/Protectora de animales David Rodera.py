from abc import ABCMeta, abstractmethod


class Animal(metaclass=ABCMeta):
    def __init__(self, año_nacimiento, nombre=None):
        self.año_nacimiento = año_nacimiento
        self.nombre = nombre
        self.adoptado = False

    @property
    def edad(self):
        return 2026 - self.año_nacimiento

    @abstractmethod
    def __str__(self):
        pass


class Perro(Animal):
    def __init__(self, año_nacimiento, vacunado, nombre=None):
        super().__init__(año_nacimiento, nombre)
        self.vacunado = vacunado

    def __str__(self):
        nombre = self.nombre or "sin nombre"
        estado = "vacunado" if self.vacunado else "no vacunado"
        return f"Perro '{nombre}' | edad: {self.edad} años | {estado}"


class Gato(Animal):
    def __init__(self, año_nacimiento, vacunado, nombre=None):
        super().__init__(año_nacimiento, nombre)
        self.vacunado = vacunado

    def __str__(self):
        nombre = self.nombre or "sin nombre"
        estado = "vacunado" if self.vacunado else "no vacunado"
        return f"Gato '{nombre}' | edad: {self.edad} años | {estado}"


class Tortuga(Animal):
    def __str__(self):
        nombre = self.nombre or "sin nombre"
        return f"Tortuga '{nombre}' | edad: {self.edad} años"


class Cliente:
    MAX_PERROS   = 2
    MAX_GATOS    = 3
    MAX_TORTUGAS = 1
    MAX_TOTAL    = 4

    def __init__(self, nombre, apellido, edad, telefono):
        self.nombre   = nombre
        self.apellido = apellido
        self.edad     = edad
        self.telefono = telefono
        self.animales = []

    def adoptar(self, animal):
        if animal.adoptado:
            print(f"  ✗ Ese animal ya fue adoptado.")
            return

        if len(self.animales) >= self.MAX_TOTAL:
            print(f"  ✗ {self.nombre} ya tiene {self.MAX_TOTAL} animales (límite total).")
            return

        conteo = {Perro: 0, Gato: 0, Tortuga: 0}
        for a in self.animales:
            conteo[type(a)] += 1

        limites = {Perro: self.MAX_PERROS, Gato: self.MAX_GATOS, Tortuga: self.MAX_TORTUGAS}
        if conteo[type(animal)] >= limites[type(animal)]:
            print(f"  ✗ {self.nombre} ya alcanzó el límite de {type(animal).__name__}s.")
            return

        animal.adoptado = True
        self.animales.append(animal)
        print(f"  ✓ {self.nombre} adoptó: {animal}")

    def listar_animales(self):
        print(f"\n  Animales de {self.nombre} {self.apellido}:")
        if not self.animales:
            print("    (ninguno todavía)")
        else:
            for i, a in enumerate(self.animales, 1):
                print(f"    {i}. {a}")

    def __str__(self):
        return f"{self.nombre} {self.apellido} | tel: {self.telefono} | animales: {len(self.animales)}"


class Protectora:
    def __init__(self, nombre):
        self.nombre   = nombre
        self.animales = []
        self.clientes = []

    def añadir_animal(self, animal):
        self.animales.append(animal)

    def registrar_cliente(self, cliente):
        self.clientes.append(cliente)

    def listar_disponibles(self):
        print(f"\nAnimales disponibles en '{self.nombre}':")
        disponibles = [a for a in self.animales if not a.adoptado]
        if not disponibles:
            print("  (ninguno disponible)")
        else:
            for i, a in enumerate(disponibles, 1):
                print(f"  {i}. {a}")


if __name__ == "__main__":

    p = Protectora("Huellas Felices")

    p.añadir_animal(Perro(2019, vacunado=True,  nombre="Rex"))
    p.añadir_animal(Perro(2021, vacunado=False))
    p.añadir_animal(Perro(2020, vacunado=True,  nombre="Buddy"))
    p.añadir_animal(Gato(2020,  vacunado=True,  nombre="Misu"))
    p.añadir_animal(Gato(2018,  vacunado=False))
    p.añadir_animal(Tortuga(2015, nombre="Speedy"))

    ana   = Cliente("Ana",   "García",   30, "600111222")
    luis  = Cliente("Luis",  "Martínez", 45, "600333444")
    sofia = Cliente("Sofía", "López",    25, "600555666")

    for c in [ana, luis, sofia]:
        p.registrar_cliente(c)

    p.listar_disponibles()

    print("\n--- Adopciones de Ana ---")
    ana.adoptar(p.animales[0])
    ana.adoptar(p.animales[3])
    ana.adoptar(p.animales[5])
    ana.adoptar(p.animales[1])
    ana.adoptar(p.animales[2])

    print("\n--- Adopciones de Luis ---")
    luis.adoptar(p.animales[2])
    luis.adoptar(p.animales[4])
    luis.adoptar(p.animales[0])

    ana.listar_animales()
    luis.listar_animales()
    sofia.listar_animales()

    p.listar_disponibles()