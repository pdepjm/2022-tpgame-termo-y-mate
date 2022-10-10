import wollok.game.*
import personaje.*
import direcciones.*
import iniciadorObjetos.*
import enemigos.*

object funcionesExtra {
	
	method posicionY(unObjeto) { 
		const y = unObjeto.position().y()
		return y }
	method posicionX(unObjeto) { 
		const x = unObjeto.position().x()
		return x }
	
	
	method ramdomPosicionTablero(){
		const x = (0.. game.width()-1).anyOne()
		const y = (0.. game.width()-1).anyOne()
		return game.at(x,y) }
	//method ambosEnMismaPosicion(unObjeto1,unObjeto2){
		//return unObjeto1.position() == unObjeto2.position() }
	
	// tablero de (13,7)
	method randomPosicionInicialBombas(){
		const x = (0.. game.width()-1).anyOne() 
		const y = 7
		return game.at(x,y)}
		
	method randomPosicionInicialAviones(){
		const x = 13
		const y = (0.. game.width()-1).anyOne()
		return game.at(x,y)}

//(tablero de 13,7)
// quiero que el cazador este por el lado bajo derecho del tablero
	
	method posicionBalas(){
		const y = self.posicionY(cazador)
		const x = self.posicionX(cazador)
		return game.at(x,y)}
	
	method ramdonPosicionInicialCazador(){
		const x = (8.. game.width()-1).anyOne()
		const y = (1.. 5).anyOne()
		return game.at(x,y)}
		
} // TERMINA EL OBJETO DE FUNCIONES EXTRA
