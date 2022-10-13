import wollok.game.*
import marvin.*

object ubicacion{
	
	method posicionY(unObjeto) = unObjeto.position().y()
	method posicionX(unObjeto) = unObjeto.position().x() //ponerla en direcciones o no ponerla en un objeto
	}
	
object arriba {
    method siguientePosicion(pos) = pos.up(1)
    method siguientePosicionMarvin(pos) = if(ubicacion.posicionY(marvin) != game.height() -1) pos.up(1) else pos.up(0)
    
    //method siguientePosicion(pos, cant) = pos.up(cant)
}
object derecha {
    method siguientePosicion(pos) = pos.right(1)
    method siguientePosicionMarvin(pos) = if(ubicacion.posicionX(marvin) != game.width() -1) pos.right(1) else pos.right(0)
    //method siguientePosicion(pos, cant) = pos.right(cant)
}
object abajo {
    method siguientePosicion(pos) = pos.down(1)
    method siguientePosicionMarvin(pos) = if(ubicacion.posicionY(marvin) != game.height() - 7) pos.down(1) else pos.down(0)
    //method siguientePosicion(pos, cant) = pos.down(cant)
}
object izquierda {
    method siguientePosicion(pos) = pos.left(1)
    method siguientePosicionMarvin(pos) = if(ubicacion.posicionX(marvin) != game.width() -13) pos.left(1) else pos.left(0)
    
    //method siguientePosicion(pos, cant) = pos.left(cant) 
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
