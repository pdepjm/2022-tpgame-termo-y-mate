import wollok.game.*
import direcciones.*

class Nube{
	var resetPosition
	var property position
	var property image
	method colisionadoPor(){}
	method moverseA(direccion) {
    position = direccion.siguientePosicion(position)
	}	
	method volverADerecha() { 
		position = resetPosition
	}
	method moverseSiempreAIzq() {
		game.onTick(100, "nubeMoviendose", {self.moverseA(izquierda) })
	}
}

object nube1 inherits Nube (
	resetPosition = game.at(13, 6), 
	position = game.at(11, 5), 
	image = "Cloud_1.png"
){
	method volverAEmpezar(){
		game.schedule(3800,{self.volverADerecha()})
		game.onTick(10000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube2 inherits Nube (
	resetPosition = game.at(13, 4), 
	position = game.at(3, 3), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(6500,{self.volverADerecha()})
		game.onTick(12000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube3 inherits Nube (
	resetPosition = game.at(13, 2), 
	position = game.at(7, 1), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(4800,{self.volverADerecha()})
		game.onTick(9500,"empezarDeVuelta",{self.volverADerecha()})
	}
}

object fondo {
	const nubes = [nube1, nube2, nube3]
	method cargarFondo(){
		game.addVisual(nube1)
  		game.addVisual(nube2)
  		game.addVisual(nube3)
		//game.boardGround("cielo.jpg")
		nubes.forEach({nube => 
			nube.moverseSiempreAIzq()
			nube.volverAEmpezar()
		})
	}
}
