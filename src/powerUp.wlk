import wollok.game.*
import marvin.*
/* 

object powerUp{
	
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
 */


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
