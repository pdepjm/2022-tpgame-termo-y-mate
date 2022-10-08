import wollok.game.*
import direcciones.*

object marvin {
	var property position = game.at(5,10)
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	method actualizarImagen(imagen) {
		image = imagen
	}
	
	// posible solucion para la colision
	// otra forma seria haciendo que coincida el cellsize con el tamaño de los enemigos (o quitando enemigos grandes) y usar whenCollideDo
	method chocoConEnemigo() = 
		if(self.position().distance(globo.position()) <= 10) self.muerte()
		else null
	
	method muerte() {
		//game.schedule(100, {self.actualizarImagen("pajaroMuerto1.png")})
		//game.schedule(200, {self.actualizarImagen("pajaroMuerto2.png")})
		//game.schedule(300, {self.actualizarImagen("pajaroMuerto3.png")})
		//game.schedule(400, {self.actualizarImagen("pajaroMuerto4.png")})
		self.actualizarImagen("pajaroMuerto4.png") //al ejecutar chocoConEnemigo() realiza el cambio pero con el schedule no me aparece el cambio
		estaVivo = false
	}
	method volar(){
		
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")})
	}
	 
	method subirMucho() {
        position = position.up(5)
    }
    method moverse(direccion) {
            position = direccion.siguientePosicion(position, 2)
            }
     
    method controles(){
    	keyboard.w().onPressDo {self.moverse(arriba)}
    	keyboard.d().onPressDo {self.moverse(derecha)}
    	keyboard.s().onPressDo {self.moverse(abajo)}
    	keyboard.a().onPressDo {self.moverse(izquierda)}
    	keyboard.space().onPressDo {self.subirMucho()}
    }
	method init() {
		game.addVisual(self)
		game.onTick(1000, "Volar",{self.volar()})
		self.controles()
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
	method moverseSiempreAIzq() {
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
		nubes.forEach({nube => 
			nube.moverseSiempreAIzq()
			nube.volverAEmpezar()
		})
	}
}
class Enemigo {
	var property position
	var property image
	var direccion
	var limiteX
	var limiteY
	method spawnear (){
		 const x = limiteX.randomUpTo(game.width().truncate(0))
   		 const y = limiteY.randomUpTo(game.height().truncate(0))
   		 position = game.at(x,y)
	}
	//elegir direccion para que se mueva
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}
	//siempre se mueve a izquierda y hacia una direccion que definamos
	method moverseEnDireccion(velocidadIzquierda, velocidadDireccion){
		game.onTick(velocidadIzquierda, "EnemigoMoviendose1", {self.moverseA(izquierda) })
		game.onTick(velocidadDireccion, "EnemigoMoviendose2", {self.moverseA(direccion)})
	}
}
object globo inherits Enemigo (
	position = game.at(70,20),
	image = "HotAirBalloon_1.png", 
	limiteX = 70, 
	limiteY = 10, 
	direccion = abajo
 ){
 	var velocidadIzquierda = 100
 	var velocidadDireccion = 400
 	method init(){
 		game.addVisual(self)
 		self.moverseEnDireccion(velocidadIzquierda, velocidadDireccion)
		game.onTick(15000,"SpawnearGlobo",{self.spawnear()})
		game.onTick(30000,"aumentardificultad",{self.subirDificultad()}) //cada 2 globos aumenta la velocidad
	}
	method subirDificultad() {
		self.aumentarVelocidad()
		game.removeTickEvent("EnemigoMoviendose1")
		game.removeTickEvent("EnemigoMoviendose2")
		self.moverseEnDireccion(velocidadIzquierda, velocidadDireccion)
		
	}
	method aumentarVelocidad()
	{
		velocidadIzquierda = 20.max(velocidadIzquierda - 19)
		//velocidadDireccion -= 10
	}
	method cambiarPosition(direccion){
		position = direccion
	}
 }





object avion {
	
	
}

object cazador {
	
}


object edificio {
	
	
}