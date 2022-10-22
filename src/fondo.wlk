import wollok.game.*
import direcciones.*


class Nube{
	const resetPosition
	var property position
	var property image
	method volverADerecha() { 
		position = resetPosition } 
	method colisionadoPor(){}
		} // CERRAMOS LA CLASE NUBE
	
object fondo {	
	const limiteNubeX = -1
	
	const nube1 = new Nube(resetPosition = game.at(13, 5), position = game.at(11, 5),image = "./assets/fondo/Cloud_1.png")
	const nube2 = new Nube(resetPosition = game.at(13, 3), position = game.at(3, 3),image = "./assets/fondo/Cloud_2.png")
	const nube3 = new Nube(resetPosition = game.at(13, 1), position = game.at(8, 1),image = "./assets/fondo/Cloud_2.png") 
	
	const nubes = [nube1, nube2, nube3]
	
	method cargarFondo(){
  		game.addVisual(nube1)
  		game.addVisual(nube2)
  		game.addVisual(nube3)
  		//game.boardGround(cielo.jpg)
		game.onTick(170,"laboratorioDeNubes",{nubes.forEach( {nubesita => if (ubicacion.posicionX(nubesita) != limiteNubeX)
			{movimientos.moverLeft(nubesita,1)} else {nubesita.volverADerecha()}            }         )     }     )
}
		
} // CERRAMOS EL METODO CARGAR FONDO
