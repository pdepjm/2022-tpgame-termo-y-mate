import wollok.game.*
import manejador.*

class Texto {
	const property position //= game.at(6,0)
	const property text
	const property textColor
}

class Imagen {
	const property position
	var property image
}

const teclas = new Imagen(position = game.at(8,2), image = "wasdCeleste.png")
const titulo = new Imagen(position = game.at(3,3), image = "TituloDodgyBirdGrande.png")
const space2 = new Imagen(position = game.at(4,0), image = "texto-space2.png")
const instrucciones = new Imagen(position = game.at(3,2), image = "instrucciones2.png")
const gameOver = new Imagen(position = game.center(), image = "gameover.png")
 
object botonPlay inherits Imagen(position = game.at(4,1), image ="botonPlayCeleste.png") {
	var property seleccionado = false
	
	method cambiarImagen() {
		image = "botonPlayCeleste2.png"
		seleccionado = true
	}
	method cambiarImagen2() {
		image = "botonPlayCeleste.png"
		seleccionado = false
	}
}

object botonInstrucciones inherits Imagen(position = game.at(6,1), image ="botonPlayCeleste.png") {
	var property seleccionado = false
	
	method cambiarImagen() {
		image = "botonPlayCeleste2.png"
		seleccionado = true
	}
	method cambiarImagen2() {
		image = "botonPlayCeleste.png"
		seleccionado = false
	}
}