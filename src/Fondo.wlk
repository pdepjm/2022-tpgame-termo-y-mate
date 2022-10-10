import wollok.game.*
import direcciones.*
import extras.*

class Nube{
	const resetPosition
	var property position
	var property image
	method volverADerecha() { 
		position = resetPosition } } // CERRAMOS LA CLASE NUBE

object fondo {
	
	const limiteNubeIzquierda = 1
	
	const nube1 = new Nube(resetPosition = game.at(13, 6), position = game.at(11, 5),image = "Cloud_1.png")
	const nube2 = new Nube(resetPosition = game.at(13, 4), position = game.at(3, 3),image = "Cloud_2.png")
	const nube3 = new Nube(resetPosition = game.at(13, 2), position = game.at(7, 1),image = "Cloud_3.png") 
	
	const nubes = [nube1, nube2, nube3]
	
	method cargarFondo(){
  		game.addVisual(nube1)
  		game.addVisual(nube2)
  		game.addVisual(nube3)
		
		game.onTick(1000,"laboratorioDeNubes",{nubes.forEach( {nebesita => if (funcionesExtra.posicionX(nebesita) != limiteNubeIzquierda)
			{movimientos.moverLeft(nebesita,2)} else {nebesita.volverADerecha()}            }         )     }     )
		
}
} // CERRAMOS EL METODO CARGAR FONDO
