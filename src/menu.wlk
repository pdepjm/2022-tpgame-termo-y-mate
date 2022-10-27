import wollok.game.*
import manejador.*

class Imagen {
	const property position
	var property image
}

const titulo = new Imagen(position = game.at(2,3), image = "TituloDodgyBirdGrande2.png")
const space2 = new Imagen(position = game.at(4,0), image = "texto-space2.png")
const contador = new Imagen(position = game.at(12,4), image = "contador2.png")
const imagenScore = new Imagen(position = game.at(6,2), image = "score3.png")
const imagenMoneda = new Imagen(position = game.at(6,3), image = "moneda 1.png")
//const puntajeFinal = new Imagen(position = game.at(2,2), image = "puntajeFinal.png")

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

object informacionMenu inherits Imagen(position = game.at(2,2), image = "infoMenuPrincipal.png"){
	method pasarAlMenuInstrucciones(){
		image = "instrucciones.png"
	}
	method pasarAlMenuPrincipal(){
		image = "infoMenuPrincipal.png"
	}
}