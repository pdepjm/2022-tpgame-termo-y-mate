import wollok.game.*
import extras.*
import personaje.*
import iniciadorObjetos.*
import direcciones.*

class Enemigo{
	var property position = game.center()}

class Bomba inherits Enemigo {
	method image() = "virusVerde.png" }
	
class Avion inherits Enemigo {
	method image() = "pelotaRugby.png" }


class Bala inherits Enemigo{
	 method image() ="bala1.png" } // CERRAMOS LA CLASE NUBE


object cazador{
	 var property position = game.at(11,0)
	 
	 method image() = "cazador.png"
	 method actualizarPosicion(){
	 	position = funcionesExtra.ramdonPosicionInicialCazador() } }
	
class Moneda{ 
	const property position
	const property puntos = 10
	
	method image() = "moneda.png"
	method chocasteCon(personaje) {
		personaje.sumarPuntos(self.puntos())
		monedero.remove(self)
		game.removeVisual(self)   // FALTA CONSTANTE DE CREAR MONEDAS EN EL MONEDERO
	}   // PARECE QUE ALGORITMO DE CHOQUE DE MONEDAS FUNCIIONA
}   // RANDOM POSICION DEL CAZADOR

		



