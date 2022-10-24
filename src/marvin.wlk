import wollok.game.*
import direcciones.*
import manejador.*


object marvin {
	var property position = game.at(1,4)
	var property positionSig = position
	var property estaVivo = true
	var property image = "pajaro1.png"
	var property puntos = 0
	
	method init() {
		game.addVisual(self)
		self.volar()
		self.controles()
	}
	
	method muerte() {
		//self.actualizarImagen("pajaroMuerto4.png")
		game.schedule(100, {self.image("pajaroMuerto1.png")})
		game.schedule(200, {self.image("pajaroMuerto2.png")})
		game.schedule(300, {self.image("pajaroMuerto3.png")})
		game.schedule(400, {self.image("pajaroMuerto4.png")})
		if(saludMarvin.vidas() == 0){
		game.schedule(700, {manejadorDeJuego.juegoFinalizado()}) 
		estaVivo = false
			}
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
    	}
}

object saludMarvin{
	var property position = game.at(12,5)
	var property vidas = 1
	var property image = "corazon.png"

	method sumarVidas(unCorazon){
		if(vidas == 3) {} else vidas += 1
	}
	method restarVidas(){vidas -= 1}

	method text() = vidas.toString()
	method textColor() = "000000"

	method init(){
		game.addVisual(self)
		game.schedule(100,{self.vidas()})}
}		
