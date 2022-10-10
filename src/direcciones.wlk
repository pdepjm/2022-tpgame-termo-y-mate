import wollok.game.*

object movimientos {
	
	method moverUp(objeto,number){
		objeto.position(objeto.position().up(number))	}
	
	method moverDown(objeto,number){
		objeto.position(objeto.position().down(number))  }
	
	method moverRight(objeto,number){
		objeto.position(objeto.position().right(number)) }
	
	method moverLeft(objeto,number){
		objeto.position(objeto.position().left(number)) }
		
} // TERMINA EL OBJETO MOVIMIENTOS
