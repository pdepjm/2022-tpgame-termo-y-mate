import wollok.game.*
import manejador.*

class Imagen {
	const property position
	var property image
}

const titulo = new Imagen(position = game.at(2,3), image = "TituloDodgyBirdGrande2.png")
const space2 = new Imagen(position = game.at(4,0), image = "texto-space2.png")
const contador = new Imagen(position = game.at(12,4), image = "contador2.png")
//const imagenScore = new Imagen(position = game.at(6,2), image = "score3.png")
//const imagenMoneda = new Imagen(position = game.at(6,3), image = "moneda 1.png")
const puntajeFinal = new Imagen(position = game.at(5,2), image = "puntajeFinal.png")
const recuadroFinal = new Imagen(position = game.at(2,1), image = "recuadroJuegoFinalizado.png")
const gameOver = new Imagen(position = game.at(4,3), image = "gameover.png")
const botonMenuReinicio = new Imagen(position = game.at(4,0), image = "")
/*
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
*/
class Boton inherits Imagen {
	var property seleccionado = false
	const imagenOriginal = image
	const imagenSeleccionado
	
	method cambiarImagen() {
		image = imagenSeleccionado
		seleccionado = true
	}
	method volverALaOriginal() {
		image = imagenOriginal
		seleccionado = false
	}
}

const botonPlay = new Boton(position = game.at(4,1), image = "botonPlayCeleste.png", imagenSeleccionado = "botonPlayCeleste2.png")
const botonInstrucciones = new Boton(position = game.at(6,1), image = "botonInstrucciones.png", imagenSeleccionado = "botonInstrucciones2.png")

object botonesMenuReinicio inherits Boton(position = game.at(4,1), image = "BotonesMenuReinicio.png", imagenSeleccionado = "MenuSeleccionado.png"){
	const imagen2Seleccionado = "ReinicioSeleccionado.png"
	
	method menuSeleccionado() = self.seleccionado()
	method reiniciarSeleccionado() = !self.seleccionado()
	
	override method volverALaOriginal(){
		image = imagen2Seleccionado
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