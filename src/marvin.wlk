import wollok.game.*
import direcciones.*
import manejador.*
import sonidos.*

object marvin {
	var property position// = game.at(1,4)
	var property positionSig = position
	var property estaVivo = true
	var property image// = "pajaro1.png"
	var property puntos// = 0
	
	method init() {
		position = game.at(1,4)
		image = "pajaro1.png"
		puntos = 0
		game.addVisual(self)
		self.volar()
		self.controles()
		game.schedule(1000, {self.bajarSiempre()})
	}
	
	method muerte() {
		game.schedule(100, {self.image("pajaroMuerto1.png")})
		game.schedule(200, {self.image("pajaroMuerto2.png")})
		game.schedule(300, {self.image("pajaroMuerto3.png")})
		game.schedule(400, {self.image("pajaroMuerto4.png")})
		game.schedule(100, {sonido.aplicarSonido("muerteMarvin.wav")})
		if(saludMarvin.vidas() == 0){
		game.schedule(500, {manejadorDeJuego.juegoFinalizado()}) 
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
		
	method bajarSiempre(){ //valores originales 1000 en onTick, 500 en schedule
		game.onTick(500, "bajarMarvin", {
			const posicionAnterior = self.position() 
			game.schedule(400, {if(self.position().y() == posicionAnterior.y()) self.moverseA(abajoMarvin)}) 
		})		
	}

    method moverseA(direccion) {
            	position = direccion.siguientePosicion(position)
     }
     
    method controles(){
    		keyboard.w().onPressDo {self.moverseA(arribaMarvin)}
    		//keyboard.s().onPressDo {self.moverseA(abajoMarvin)} 
    		keyboard.a().onPressDo {self.moverseA(izquierdaMarvin)}
    		keyboard.d().onPressDo {self.moverseA(derechaMarvin)}
    	}
}

object saludMarvin{
	var property position = game.at(12,4)
	var property vidas// = 1

	method sumarVidas(){
		vidas = 3.min(vidas + 1)
	}
	method restarVidas(){ // mandar un solo mensaje desde collisionadoPor cuando marvin muere
		vidas = 0.max(vidas-1)
	}

	method text() = vidas.toString()
	method textColor() = "000000"

	method init(){
		vidas = 1
		game.addVisual(self)
		game.schedule(100, {self.vidas()})}
}		
