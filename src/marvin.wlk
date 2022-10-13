import wollok.game.*
import direcciones.*
import extras.*
import manejador.*


object marvin {
	var property position = game.at(1,4)
	var property estaVivo = true
	var property image = "./assets/marvin/pajaro1.png"
	
	var property puntos = 0
	var property vidas = 1
	
	const limiteFondoX = 12
	const limiteFondoY = 6
	
	

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
		
		manejadorDeJuego.juegoFinalizado()
		
		game.schedule(1000,{game.addVisual(fin)})
		//faltaria poner el removeVisual o pantalla de muerte
		estaVivo = false
		 }

	method volar(){
		game.schedule(200, {self.actualizarImagen("./assets/marvin/pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("./assets/marvin/pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("./assets/marvin/pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("./assets/marvin/pajaro1.png")})  
		game.onTick(1000, "Volar",{self.volar()})
		}
	//imagen en funcion del tiempo
	
    method moverse(direccion) {
            position = direccion.siguientePosicion(position) }
            
     
    method controles(){
    	if (funcionesExtra.posicionY(self) != limiteFondoY-1){ 
    	
    		keyboard.w().onPressDo {self.moverse(arriba)}
    		keyboard.s().onPressDo {self.moverse(abajo)} 
			}
    	 
    	if (funcionesExtra.posicionX(self) != limiteFondoX-1){
    		keyboard.a().onPressDo {self.moverse(izquierda)}
    		keyboard.d().onPressDo {self.moverse(derecha)}
    	//keyboard.space().onPressDo {self.subirMucho()
    	
    
    	}
    	}
    	
    	
    	
    	
	method init() {
		game.addVisual(self)
		self.volar()
		self.controles()
	}

}


class CosasUtilesParaMarvin {
	
	var property position = game.center()

	method colisionadoPor()
	
	// ESTA LA PODEMOS PONER EN EXTRAS CON RETURN
	method spawnearRandom (limiteX, limiteY){  
		const x = (limiteX.. game.width()-1).anyOne()
		const y = (limiteY.. game.height()-1).anyOne()
		return game.at(x,y)} //position = game.at(x,y)
}

class Moneda inherits CosasUtilesParaMarvin {
	const property puntosAdiciona=10 
	const monedero =[]
	method image() = "./assets/powerup/moneda.png"
	
	override method colisionadoPor(){
		marvin.sumarPuntos(self)
		game.removeVisual(self)
		monedero.remove(self)}  
}

object aparacerMonedas inherits Moneda{
	
	method crearMonedas(){
		const nuevaMoneda = new Moneda(position = self.spawnearRandom(0,0)) 
		game.addVisual(nuevaMoneda)
		monedero.add(nuevaMoneda) }
	
	method init(){
	game.onTick(15000,"laboratorioMonedas",{self.crearMonedas()})}
}

class Corazon inherits CosasUtilesParaMarvin {
	const property vidasQueSuma = 1
	const saludMarvin =[]
	method image() = "./assets/powerup/corazon.png"
	
	override method colisionadoPor(){
		marvin.sumarVidas(self)
		game.removeVisual(self)
		saludMarvin.remove(self)}
}

object aparecerVidas inherits Corazon{
	
	method crearVidas(){
		const nuevaVida = new Corazon (position = self.spawnearRandom(0,0)) 
		game.addVisual(nuevaVida)
		saludMarvin.add(nuevaVida) }
	
	method init(){
	game.onTick(15000,"laboratorioVidas",{self.crearVidas()})}
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











