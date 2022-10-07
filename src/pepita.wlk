import wollok.game.*
import direcciones.*

object marvin {
	var property position = game.at(5,10)
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	method actualizarImagen(imagen) {
		image = imagen
	}
	method muerte() {
		game.schedule(100, {self.actualizarImagen("pajaroMuerto1.png")})
		game.schedule(200, {self.actualizarImagen("pajaroMuerto2.png")})
		game.schedule(300, {self.actualizarImagen("pajaroMuerto3.png")})
		game.schedule(400, {self.actualizarImagen("pajaroMuerto4.png")})
		estaVivo = false
	}
	method animacionVuelo(){
		
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")})
	}
	
	method init() {
		game.addVisualCharacter(self)
		game.onTick(1000, "Volar",{self.animacionVuelo()})
	}
}

class Nube{
	var resetPosition
	var property position
	var property image
	
	method moverseA(direccion) {
    position = direccion.siguientePosicion(position)
	}	
	method volverADerecha() { 
		position = resetPosition
	}
	method moverseInfinito() {
		game.onTick(50, "nubeMoviendose", {self.moverseA(izquierda) })
	}

}

object nube1 inherits Nube (
	resetPosition = game.at(85, 30), 
	position = game.at(20,30), 
	image = "Cloud_1.png"
){
	method volverAEmpezar(){
		game.schedule(3800,{self.volverADerecha()})
		game.onTick(12000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube2 inherits Nube (
	resetPosition = game.at(85, 15), 
	position = game.at(60, 15), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(6500,{self.volverADerecha()})
		game.onTick(13000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube3 inherits Nube (
	resetPosition = game.at(85, 3), 
	position = game.at(40,3), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(4800,{self.volverADerecha()})
		game.onTick(11500,"empezarDeVuelta",{self.volverADerecha()})
	}
}

object fondo {
	
	const nubes = [nube1, nube2, nube3]
	method cargarFondo(){
		game.addVisual(nube1)
  		game.addVisual(nube2)
  		game.addVisual(nube3)
		game.boardGround("cielo.jpg")
		nubes.forEach({nube => nube.moverseInfinito()})
		nubes.forEach({nube => nube.volverAEmpezar()})
	}
}

object avion {
	
	
}

object cazador {
	
}

object globo {
	
	
}

object edificio {
	
	
}