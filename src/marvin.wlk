import wollok.game.*
import direcciones.*
import manejador.*


object marvin {
	var property position = game.at(1,4)
	var property positionSig = position
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	//var property puntos = 0
	//var property vidas = 1

	//method sumarPuntos(unObjeto){puntos = puntos + unObjeto.puntosAdiciona()}
	//method sumarVidas(unObjeto){vidas = vidas + unObjeto.vidasQueSuma()}

	method muerte() {
		//self.actualizarImagen("pajaroMuerto4.png")
		game.schedule(100, {self.image("pajaroMuerto1.png")})
		game.schedule(200, {self.image("pajaroMuerto2.png")})
		game.schedule(300, {self.image("pajaroMuerto3.png")})
		game.schedule(400, {self.image("pajaroMuerto4.png")})
		//game.removeVisual(self)
		
		manejadorDeJuego.juegoFinalizado()
		
		//game.schedule(1000,{game.addVisual(fin)})
		//faltaria poner el removeVisual o pantalla de muerte
		estaVivo = false
		 }

	method volar(){
		game.onTick(1000, "Volar",{
		game.schedule(200, {self.image("pajaro2.png")})
		game.schedule(400, {self.image("pajaro3.png")})
		game.schedule(600, {self.image("pajaro4.png")})
		game.schedule(800, {self.image("pajaro1.png")})
		})
		}
	
    method moverseA(direccion) {
            	position = direccion.siguientePosicion(position)
     }
     
    method controles(){
    		keyboard.w().onPressDo {self.moverseA(arribaMarvin)}
    		keyboard.s().onPressDo {self.moverseA(abajoMarvin)} 
    		keyboard.a().onPressDo {self.moverseA(izquierdaMarvin)}
    		keyboard.d().onPressDo {self.moverseA(derechaMarvin)}
    	//keyboard.space().onPressDo {self.subirMucho(
    	}
    	
    	
	method init() {
		game.addVisual(self)
		self.volar()
		self.controles()
	}

}

		
