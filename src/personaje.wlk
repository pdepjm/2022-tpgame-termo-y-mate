import wollok.game.*

object marvin {
  var property position = game.at(0,game.center().y())
  var property image = "pajaro1.png"
  var puntos = 0
    
    method sumarPuntos(unObjeto){puntos = puntos+unObjeto.puntos()}
 	method actualizarImagen(imagenString){
		image = imagenString }
    method hablarConUsuario(){ return "GRR"}
    method eliminarPersonaje(){
		game.removeVisual(self)} 

method volar(){
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")}) }
		
method personajeVolando(){
		game.onTick(1000,"MarvinTransicionVolando",{self.volar()})
		
	}


}  // FINALIZA EL OBJETO JUEGO
 

	/* 
	method actualizarImagen(imagenString){
		image = imagenString }
	
	method volar(){
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")}) }
		
	method personajeVolando(){
		game.onTick(1000,"MarvinTransicionVolando",{self.volar()})
	}
	*/ // ME ROMPIA EL JAVA
	
/*object marvin {
	var property position = game.at(1,4)
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	method actualizarImagen(imagen) {
		image = imagen
	}
	method chocoConEnemigo() = 
		if(self.position().distance(globo.position()) <= 10) self.muerte()
		else null
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
	 
	method subirMucho() {
        position = position.up(3)
    }
    
    method moverse(direccion) {
            position = direccion.siguientePosicion(position)
            }
     
    method controles(){
    	//if (position != ) ver como poner un borde para que el pajaro no suba mas
    	keyboard.w().onPressDo {self.moverse(arriba)}
    	//if (position != game.height())
    	keyboard.a().onPressDo {self.moverse(izquierda)}
    	keyboard.d().onPressDo {self.moverse(derecha)}
    	keyboard.s().onPressDo {self.moverse(abajo)}
    	keyboard.space().onPressDo {self.subirMucho()}
    }
	method init() {
		game.addVisual(self)
		game.onTick(1000, "Volar",{self.volar()})
		self.controles()
		
	}
}*/



