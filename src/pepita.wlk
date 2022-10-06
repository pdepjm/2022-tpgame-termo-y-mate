import wollok.game.*
import direcciones.*

object marvin {
	var property position = game.at(0,10)
	var property estaVivo = true
	method muere() {
		self.image("pajaroMuerto.png")
		estaVivo = false
	}
	
	method image() = "pajaro1.png"
	method image(imagen) = imagen
	method moverA(direccion) = direccion.siguientePosicion(position)

}
class Nube{
	var positionInicial
	var property position
	var property image
	
	method moverseA(direccion) {
    position = direccion.siguientePosicion(position)
	}	
	method volverADerecha() { 
		position = positionInicial
	}
}
const nube1 = new Nube(positionInicial = game.at(85, 30), position = game.at(20, 30), image = "Cloud_1.png")
const nube2 = new Nube(positionInicial = game.at(85, 15), position = game.at(60, 15), image = "Cloud_2.png")
const nube3 = new Nube(positionInicial = game.at(85, 3), position = game.at(40, 3), image = "Cloud_2.png")


object avion {
	
	
}

object cazador {
	
}

object globo {
	
	
}

object edificio {
	
	
}