import wollok.game.*
import direcciones.*
import manejador.*


object marvin {
	var property position = game.at(1,4)
	var property positionSig = position
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	var property puntos = 0
	var property vidas = 1

	method sumarPuntos(unObjeto){puntos = puntos + unObjeto.puntosAdiciona()}
	method sumarVidas(unObjeto){vidas = vidas + unObjeto.vidasQueSuma()}

	method muerte() {
		//self.actualizarImagen("pajaroMuerto4.png")
		game.schedule(100, {self.image("pajaroMuerto1.png")})
		game.schedule(200, {self.image("pajaroMuerto2.png")})
		game.schedule(300, {self.image("pajaroMuerto3.png")})
		game.schedule(400, {self.image("pajaroMuerto4.png")})
		//game.removeVisual(self)
		
		//manejadorDeJuego.juegoFinalizado()
		
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


class Coleccionable {
	
	var property position = game.center()
	var property image
	
	method spawnearRandom (limiteX, limiteY){  
		const x = (limiteX.. limiteDerechoMarvin).anyOne() 
		const y = (limiteY.. game.height()-1).anyOne()
		return game.at(x,y)} //position = game.at(x,y)
		
	method spawnearColeccionable (frecuenciaSpawneo){
		game.onTick(frecuenciaSpawneo,"laboratorioDePowerUps", {
		if(!game.hasVisual(self)){
		game.addVisualIn(self, self.spawnearRandom(0,0)) 
		}	
		game.schedule(3500, {if(game.hasVisual(self)) game.removeVisual(self)})  //tiempo de espera para agarrar los poweUps
		 	}	)
}
}
object moneda inherits Coleccionable (image = "pieniąszka 01.gif"){
	method init(){
		self.spawnearColeccionable(10000)
		self.girar()
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
	method colisionadoPor(){
		//marvin.sumarPuntos(self) ver bien esto
		game.removeVisual(self) 
		}  
	}



object corazon inherits Coleccionable (image = "corazon.png"){
	
	method init(){
		self.spawnearColeccionable(50000) //mientras no supere el maximo de vidas permitido (falta eso)
	}
	method colisionadoPor(){
		//marvin.sumarVidas(self)
		game.removeVisual(self) }  
		
}

//class Moneda inherits Coleccionable {
//	const property puntosAdiciona=10 
//	
//	method image() = "./assets/powerup/moneda.png"
//	
//	override 
//}

//object creadorDeMonedas {
//	const monedero =[]
//	method crearMonedas(){
//		const nuevaMoneda = new Moneda(position = self.spawnearRandom(0,0)) 
//		game.addVisual(nuevaMoneda)
//		monedero.add(nuevaMoneda) }
//	
//	method init(){
//	game.onTick(15000,"laboratorioMonedas",{self.crearMonedas()})}
//}

//class Corazon inherits Coleccionable {
//	const property vidasQueSuma = 1
//	const saludMarvin =[]
//	method image() = "./assets/powerup/corazon.png"
//	
//	override method colisionadoPor(){
//		marvin.sumarVidas(self)
//		game.removeVisual(self)
//		saludMarvin.remove(self)}
//}
//object crearVidas inherits Corazon{
//	
//	method crear(){
//		const nuevaVida = new Corazon (position = self.spawnearRandom(0,0)) 
//		game.addVisual(nuevaVida)
//		saludMarvin.add(nuevaVida) }
//	
//	method init(){
//	game.onTick(15000,"laboratorioVidas",{self.crearVidas()})}
//}


object score{
	var property position = game.at(12,6)
	var contadorKms = 0
	var property image = "score.png"
	method text() = contadorKms.toString()
	method textColor() = "ffff00ff"
	method init(){
		game.addVisual(self)
		//game.say(self,"Recorrido = "+ contadorKms + "Kms")
		game.onTick(500,"RecorridoEnMetros",{contadorKms += 1})}}
		
object scoreImage{
	var property position = game.at(11,6)
	var property image = "score.png"
}
/* 
object contadorKms{
	var property position = game.at(12,0)
	var contadorKms = 0
	
	method image() = "contadorKms.png"
	method init(){
		game.addVisual(self)
		game.say(self,"Recorrido = "+ contadorKms + "Kms")
		game.onTick(500,"RecorridoKms",{contadorKms = contadorKms + 1})}}

*/











