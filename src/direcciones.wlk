import wollok.game.*
import marvin.*

const limiteArribaMarvin = 6
const limiteAbajoMarvin = 0
const limiteDerechoMarvin = 4
const limiteIzquierdoMarvin = 0

object ubicacion{
	
	method posicionY(unObjeto) = unObjeto.position().y()
	method posicionX(unObjeto) = unObjeto.position().x() 
	}
	
//solo para marvin
object arribaMarvin {
    method siguientePosicion(pos) = if(ubicacion.posicionY(marvin) != limiteArribaMarvin) pos.up(1) else pos.up(0)
}
object derechaMarvin {
    method siguientePosicion(pos) = if(ubicacion.posicionX(marvin) != limiteDerechoMarvin) pos.right(1) else pos.right(0) 
    }
object abajoMarvin {
    method siguientePosicion(pos) = if(ubicacion.posicionY(marvin) != limiteAbajoMarvin) pos.down(1) else pos.down(0)
}
object izquierdaMarvin {
    method siguientePosicion(pos) = if(ubicacion.posicionX(marvin) != limiteIzquierdoMarvin) pos.left(1) else pos.left(0)
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
