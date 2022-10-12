import wollok.game.*
import direcciones.*
import enemigos.*

object funcionesExtra {
	
	method posicionY(unObjeto) = unObjeto.position().y()

	method posicionX(unObjeto) = unObjeto.position().x()
	
	/*method ramdomPosicionTablero(){
		const x = (0.. game.width()-1).anyOne()
		const y = (0.. game.width()-1).anyOne()
		return game.at(x,y) } */
	
	// tablero de (13,7)
	
	/*method randomPosicionInicialBombas(){
		const x = (0.. game.width()-1).anyOne() 
		const y = 7
		return game.at(x,y)}*/
		
	/*method randomPosicionInicialAviones(){
		const x = 13
		const y = (0.. game.height()-1).anyOne()
		return game.at(x,y)} */

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
