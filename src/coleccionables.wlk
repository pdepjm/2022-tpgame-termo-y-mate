import wollok.game.*
import marvin.*
import direcciones.*
import marvin.*
import sonidos.*
import manejador.*
import menu.*

object iniciarColeccionables {
	method init (){
		moneda.init()
		monedero.init()
		corazon.init()
		saludMarvin.init()
	}
}
class Coleccionable {
	var property position = game.center()
	var property image = ""
	
	method spawnearRandom (limiteX, limiteY){  
		const x = (limiteX.. limiteDerechoMarvin).anyOne() 
		const y = (limiteY.. game.height()-1).anyOne()
		return game.at(x,y)} //position = game.at(x,y)
		
	method spawnearColeccionable (frecuenciaSpawneo){
		game.onTick(frecuenciaSpawneo,"laboratorioDePowerUps", {
		if(!game.hasVisual(self)){
		game.addVisualIn(self, self.spawnearRandom(0,0)) 
		}	
		game.schedule(3000, {if(game.hasVisual(self)) game.removeVisual(self)})  //tiempo de espera para agarrar los poweUps
		 	}	)
}
}
object moneda inherits Coleccionable {
	const property puntosAdiciona = 1
	method init(){
		self.spawnearColeccionable(10000)
		self.girar()
	}
	
	method colisionadoPor(){
		monedero.sumarPuntos(self) 
		game.removeVisual(self) 
		score.adicionarScorePorMoneda() 
		sonido.aplicarSonido("coin.wav")
		}  
		
	method girar(){
		game.onTick(900, "girarMoneda", {	
			game.schedule(100, {self.image("moneda 1.png")})
			game.schedule(200, {self.image("moneda 2.png")})
			game.schedule(300, {self.image("moneda 3.png")})
			game.schedule(400, {self.image("moneda 4.png")})
			game.schedule(500, {self.image("moneda 5.png")})
			game.schedule(600, {self.image("moneda 6.png")})
			game.schedule(700, {self.image("moneda 7.png")})
			game.schedule(800, {self.image("moneda 8.png")})})
	
	}

	}
object monedero{
	var property position = game.at(12,5)
	var property puntos = 0

	method sumarPuntos(unaMoneda){puntos += 1}

	method text() = puntos.toString()
	method textColor() = "000000"

	method init(){
		game.addVisual(self)
		game.schedule(100,{self.puntos()})}
	
	method mostrarMonedero(){
		position = game.at(7,8)
		game.addVisualIn(self, game.at(7,3))
		game.addVisual(imagenMoneda)
	}
}

object corazon inherits Coleccionable (image = "corazon.png"){

	method init(){
		self.spawnearColeccionable(45000) 
	}
	method colisionadoPor(){
		//marvin.sumarVidas(self)
		sonido.aplicarSonido("corazon.mp3")
		game.removeVisual(self)  
		saludMarvin.sumarVidas() 
		
		 }  		
}

