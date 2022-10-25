import wollok.game.*
import manejador.*

class Imagen {
	const property position
	var property image
}

const teclas = new Imagen(position = game.at(8,2), image = "wasdCeleste.png")
const titulo = new Imagen(position = game.at(2,3), image = "TituloDodgyBirdGrande2.png")
const space2 = new Imagen(position = game.at(4,0), image = "texto-space2.png")
const instrucciones = new Imagen(position = game.at(2,2), image = "recuadroInfo.png")
const gameOver = new Imagen(position = game.center(), image = "gameover.png")
const contador = new Imagen(position = game.at(12,4), image = "contador2.png")
 
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

object botonInstrucciones inherits Imagen(position = game.at(6,1), image ="botonInstrucciones.png") {
	var property seleccionado = false
	
	method cambiarImagen() {
		image = "botonInstrucciones2.png"
		seleccionado = true
	}
	method cambiarImagen2() {
		image = "botonInstrucciones.png"
		seleccionado = false
	}
}