import wollok.game.*
import direcciones.*
import manejador.*


object marvin {
	var property position = game.at(1,4)
	var property positionSig = position
	var property estaVivo = true
	var property image = "./assets/marvin/pajaro1.png"
	
	var property puntos = 0
	var property vidas = 1

	method sumarPuntos(unObjeto){puntos = puntos + unObjeto.puntosAdiciona()}
	method sumarVidas(unObjeto){vidas = vidas + unObjeto.vidasQueSuma()}
	

	method actualizarImagen(imagen) {
		image = imagen }
		
	method muerte() {
		self.actualizarImagen("./assets/marvin/pajaroMuerto4.png")
		game.schedule(100, {self.actualizarImagen("./assets/marvin/pajaroMuerto1.png")})
		game.schedule(200, {self.actualizarImagen("./assets/marvin/pajaroMuerto2.png")})
		game.schedule(300, {self.actualizarImagen("./assets/marvin/pajaroMuerto3.png")})
		game.schedule(400, {self.actualizarImagen("./assets/marvin/pajaroMuerto4.png")})
		//game.removeVisual(self)
		
		//manejadorDeJuego.juegoFinalizado()
		
		//game.schedule(1000,{game.addVisual(fin)})
		//faltaria poner el removeVisual o pantalla de muerte
		estaVivo = false
		 }

	method volar(){
		game.onTick(1000, "Volar",{
		game.schedule(200, {self.actualizarImagen("./assets/marvin/pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("./assets/marvin/pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("./assets/marvin/pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("./assets/marvin/pajaro1.png")})
			
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
		const x = (limiteX.. game.width()-1).anyOne() //hay que poner bien el limite que se va a poder mover marvin
		const y = (limiteY.. game.height()-1).anyOne()
		return game.at(x,y)} //position = game.at(x,y)
		
	method init (){
		game.onTick(15000,"laboratorioDePowerUps", {
		if(!game.hasVisual(self)){
		game.addVisualIn(self, self.spawnearRandom(0,0)) 
		}	
		game.schedule(4000, {if(game.hasVisual(self)) game.removeVisual(self)})  //tiempo de espera para agarrar los poweUps
		 	}	)
}
}
object moneda inherits Coleccionable (image = "./assets/powerup/moneda.png"){
	
	method colisionadoPor(){
		//marvin.sumarPuntos(self) ver bien esto
		game.removeVisual(self) 
		}  
	}



object corazon inherits Coleccionable (image = "./assets/powerup/corazon.png"){
	
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











