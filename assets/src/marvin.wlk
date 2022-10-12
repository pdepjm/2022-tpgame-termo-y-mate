import wollok.game.*
import direcciones.*
import extras.*
object marvin {
	var property position = game.at(1,4)
	var property estaVivo = true
	var property image = "pajaro1.png"
	var puntos = 0
	const limiteFondoX = 12
	const limiteFondoY = 6
	
	method sumarPuntos(unObjeto){puntos = puntos+unObjeto.puntos()}
	method actualizarImagen(imagen) {
		image = imagen
	}
	method muerte() {
		self.actualizarImagen("pajaroMuerto4.png")
		game.schedule(100, {self.actualizarImagen("pajaroMuerto1.png")})
		game.schedule(200, {self.actualizarImagen("pajaroMuerto2.png")})
		game.schedule(300, {self.actualizarImagen("pajaroMuerto3.png")})
		game.schedule(400, {self.actualizarImagen("pajaroMuerto4.png")})
		//faltaria poner el removeVisual o pantalla de muerte
		estaVivo = false
	}
	method volar(){
		
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")})
	}
	 
	/*method subirMucho() {
        position = position.up(3)
    }*/
    
    method moverse(direccion) {
            position = direccion.siguientePosicion(position)
            }
     
    method controles(){
    	if (funcionesExtra.posicionX(self) != limiteFondoY) 
    	keyboard.w().onPressDo {self.moverse(arriba)}
    	keyboard.s().onPressDo {self.moverse(abajo)}
    	if (funcionesExtra.posicionX(self) != limiteFondoX){
    	keyboard.a().onPressDo {self.moverse(izquierda)}
    	keyboard.d().onPressDo {self.moverse(derecha)}}
    	
    	//keyboard.space().onPressDo {self.subirMucho()}
    }
	method init() {
		game.addVisual(self)
		game.onTick(1000, "Volar",{self.volar()})
		self.controles()
		
	}
}


