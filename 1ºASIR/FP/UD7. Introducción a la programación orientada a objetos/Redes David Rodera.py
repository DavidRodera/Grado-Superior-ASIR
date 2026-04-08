class Dispositivo(object):
    def __init__(self, nombre, ip_base, mac, puertos):
        self.nombre = nombre
        self.ip = ip_base
        self.mac = mac
        self.puertos = puertos

    def __str__(self):
        return (f"Dispositivo: \n\tNombre: {self.nombre}, \n\tIP: {self.ip}, "
                f"\n\tMAC: {self.mac}, \n\tPuerto disponible: {self.puertos}, ")

router_principal = Dispositivo(
    "Router",
    "192.168.1.13",
    "00:1B:44:11:3A:B7",
    [20, 80, 100]
)

switch_oficina = Dispositivo(
    "Switch",
    "10.0.0.71",
    "A1:C2:E3:F4:05:06",
    [10,20,30]
)

print(router_principal)
print(switch_oficina)
