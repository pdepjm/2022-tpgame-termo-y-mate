import wollok.game.*
import direcciones.*
import marvin.*
import coleccionables.*
import manejador.*

const limiteDESPAWNFondoX = -1 //posicion en X en la que el objeto va a desaaparecer
const limiteDESPAWNFondoY = -1 //posicion en Y en la que el objeto va a desaaparecer
const limitePantallaX = game.width()-1 // limite de X en pantalla
const limitePantallaY = game.height()-1

class Enemigo {
	var property position = game.center() //se cambia para cada enemigo de ser necesario
	var property image = ""
	var property velocidad = 0
	var valorSpawneoRandomXI = 0 // a partir de que posicion inicial en X va a spawnear aleatoriamente
	var valorSpawneoRandomYI = 0 // a partir de que posicion inicial en Y va a spawnear aleatoriamente
	var valorSpawneoRandomXF = limitePantallaX //hasta que posicion en X e Y final puede spawnear aleatoriamente
	var valorSpawneoRandomYF = limitePantallaY
	const listaEnemigos = #{}
	
	method colisionadoPor(){
		if(saludMarvin.vidas() == 1) {marvin.muerte()} else {saludMarvin.restarVidas()}
		}

	method deSpawnear(){
		game.removeVisual(self) }
	
	method dentroDelMapa (objeto) = ubicacion.posicionY(objeto) != limiteDESPAWNFondoY and ubicacion.posicionX(objeto) != limiteDESPAWNFondoX //dice si el objeto esta dentro del mapa o no

	method moverEnemigo(valorUp, valorDown, valorLeft, valorRight)//cantidad de celdas que se mueve en cada direccion. Poner 0 en la direccion que no se va a mover
		{ 
		self.crearEnemigoPosRandom(image)
		game.onTick(velocidad,"moverEnemigo",{listaEnemigos.forEach( {enemigo => 
			if (self.dentroDelMapa(enemigo)) 
			{	movimientos.moverUp(enemigo, valorUp)
				movimientos.moverDown(enemigo, valorDown)
				movimientos.moverLeft(enemigo, valorLeft) 
				movimientos.moverRight(enemigo, valorRight)
			}
			else {self.eliminarEnemigo(enemigo) game.schedule(3000, {game.removeTickEvent("moverEnemigo")}) 
				} } ) } )
				}
				
	method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = imagen, position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo) }
		
	method spawnearRandom (){ 
		const x = (valorSpawneoRandomXI.. valorSpawneoRandomXF).anyOne()
		const y = (valorSpawneoRandomYI.. valorSpawneoRandomYF).anyOne()
		return game.at(x,y) }
		
	method eliminarEnemigo(enemigo){
		game.removeVisual(enemigo)
		listaEnemigos.remove(enemigo)}	
	
	method lanzarEnemigo(frecuenciaSpawneo, velocidadMax, valorUp, valorDown, valorLeft, valorRight){ 
			game.onTick(frecuenciaSpawneo, "lanzarEnemigo", {
				self.moverEnemigo(valorUp, valorDown, valorLeft, valorRight)
				if(velocidad != velocidadMax){ 
				velocidad = velocidadMax.max((velocidad - (velocidad * 0.1))) //los enemigos van aumentando su velocidad progresivamente
				}
				}
				) 
				
	}	
		
}
//probando nuevas imagenes (decidir si quedan o no)
object aereosDiagonal inherits Enemigo (velocidad = 300, valorSpawneoRandomXI = 7, valorSpawneoRandomXI=11, valorSpawneoRandomYI = 7, valorSpawneoRandomYF = 11 ){
 	const frecuenciaSpawneo = 20000
 	const velocidadMax = 90 //maxima velocidad que alcanzara
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 1, 1, 0)
	}
				
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["HotAirBalloon_2.png", "Sky Diver.png"].anyOne(), position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}

 }

object aereosHorizontal inherits Enemigo (velocidad = 170, valorSpawneoRandomXI = 12){ 
	const frecuenciaSpawneo = 10000
	const velocidadMax = 30
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 0, 1, 0)
	}
	
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["Helicopter.png", "avion.png", "Bird.png"].anyOne(), position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
}

object misil inherits Enemigo(velocidad = 250, image = "Missile.png"){ //decidir si poner la imagen de bomba o misil
	const frecuenciaSpawneo = 17000
	var tiempoEnCaer = 3000
	const velocidadMax = 80
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 1, 0, 0)
	}
		override method spawnearRandom (){
		const x = (valorSpawneoRandomXI.. limiteDerechoMarvin).anyOne()
		const y = 12
		game.say(marvin, "¡Se aproxima una bomba!")
		return game.at(x,y) }		
}
	
	
object cazador inherits Enemigo (image = "JK_P_Gun__Attack_000.png", valorSpawneoRandomXI = 9, valorSpawneoRandomYI = 0, valorSpawneoRandomYF = 0)
	{
	const frecuenciaSpawneo = 30000
	override method position(pos){ //necesito que sea getter
		position = self.spawnearRandom()
	}
	method disparar(){
		game.schedule(200, {self.image("JK_P_Gun__Attack_001.png")})
		game.schedule(300, {self.image("JK_P_Gun__Attack_002.png")})
		game.schedule(400, {lanzadorDeBalas.lanzarBala()}) 
		game.schedule(500, {self.image("JK_P_Gun__Attack_003.png")})
		game.schedule(600, {self.image("JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.image("JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.image("JK_P_Gun__Attack_009.png")})
		game.schedule(1500, {self.deSpawnear()})
		}

	method init (){
		lanzadorDeBalas.moverBalas()
		game.onTick(frecuenciaSpawneo,"spawnCazador", {
		if(!game.hasVisual(self)){
			self.position(0) //no importa el valor
			game.addVisual(self)
			self.disparar()
			}  } ) } 		
	}
			
const balas = []
class Bala inherits Enemigo(position = cazador.position(), image = "bala1.png"){
	const property valorUp
	const property valorLeft
}

object lanzadorDeBalas inherits Enemigo (velocidad = 250) {
	
	var balasDisparadas = 0
	method lanzarBala(){ //sube la dificultad segun la cantidad de disparos
			if (balasDisparadas < 3) {
			self.crearBalas(1)
			}
			if (balasDisparadas  < 5 and balasDisparadas  >= 3)
			{
			self.crearBalas(2) 
			}
			if (balasDisparadas  >= 5) {
			self.crearBalas(3)
			}
			balasDisparadas  += 1 
	}
	method moverBalas () {
			game.onTick(velocidad,"dispararBala",{balas.forEach( {bala => 
			if (self.dentroDelMapa(bala)) 
			{	movimientos.moverUp(bala, bala.valorUp())
				movimientos.moverLeft(bala, bala.valorLeft()) 
			}
			else {self.eliminarBala(bala)} 
			} ) } )  
	}
	
	method crearBalas(cant){
		if(cant == 3)
		{
			self.crearBala("bala1.png")
			self.crearBala("bala2.png")
			self.crearBala("bala3.png")		//probe con times y no se como hacer para que ande bien //2.times({self.crearBala()})
		}
		if (cant == 2) {
			self.crearBala("bala1.png")
			self.crearBala("bala2.png")
		}
		else {
			self.crearBala("bala1.png")
		}
	}
	method crearBala(imagen){
		const bala = new Bala(position = cazador.position(), image = imagen, valorUp = (0.. 1).anyOne(), valorLeft = (1.. 2).anyOne())
		game.addVisual(bala)
		balas.add(bala)
	}
	method eliminarBala(bala){
		game.removeVisual(bala)
		balas.remove(bala)
	}

	
}

