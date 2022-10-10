import wollok.game.*


object arriba {
    method siguientePosicion(pos) = pos.up(1)
    method siguientePosicion(pos, cant) = pos.up(cant)
}
object derecha {
    method siguientePosicion(pos) = pos.right(1)
    method siguientePosicion(pos, cant) = pos.right(cant)
}
object abajo {
    method siguientePosicion(pos) = pos.down(1)
    method siguientePosicion(pos, cant) = pos.down(cant)
}
object izquierda {
    method siguientePosicion(pos) = pos.left(1)
    method siguientePosicion(pos, cant) = pos.left(cant) 
}

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
