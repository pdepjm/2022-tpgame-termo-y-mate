import wollok.game.*
import direcciones.*
import marvin.*

const limiteDESPAWNFondoX = -1 //posicion en X en la que el objeto va a desaaparecer
const limiteDESPAWNFondoY = -1 //posicion en Y en la que el objeto va a desaaparecer
const limitePantallaX = game.width()-1 // limite de X en pantalla
const limitePantallaY = game.height()-1

class Enemigo {
	var property position = game.center() //se cambia para cada enemigo de ser necesario
	var property image = ""
	var valorSpawneoRandomXI = 0// a partir de que posicion inicial en X va a spawnear aleatoriamente
	var valorSpawneoRandomYI = 0// a partir de que posicion inicial en Y va a spawnear aleatoriamente
	var valorSpawneoRandomXF = limitePantallaX//hasta que posicion en X e Y final puede spawnear aleatoriamente
	var valorSpawneoRandomYF = limitePantallaY
	const listaEnemigos = []
	method colisionadoPor(){
		marvin.muerte() }

	method deSpawnear(){
		game.removeVisual(self) }
	
	method dentroDelMapa (objeto) = ubicacion.posicionY(objeto) != limiteDESPAWNFondoY and ubicacion.posicionX(objeto) != limiteDESPAWNFondoX //dice si el objeto esta dentro del mapa o no

	method lanzarEnemigo(frecuenciaSpawneo, velocidad, valorUp, valorDown, valorLeft, valorRight)//funcion generica para todos los enemigos, poner 0 en la direccion que no se va a mover
		{ 
		game.onTick(frecuenciaSpawneo,"laboratorioEnemigos",{self.crearEnemigoPosRandom(image)})
		game.onTick(velocidad,"dispararEnemigo",{listaEnemigos.forEach( {enemigo => 
			if (self.dentroDelMapa(enemigo)) 
			{	movimientos.moverUp(enemigo, valorUp)
				movimientos.moverDown(enemigo, valorDown)
				movimientos.moverLeft(enemigo, valorLeft) 
				movimientos.moverRight(enemigo, valorRight)
			}
			else {self.eliminarEnemigo(enemigo)
				} } ) } )  }
					
	method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = imagen, position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
		
	method spawnearRandom (){ 
		const x = (valorSpawneoRandomXI.. valorSpawneoRandomXF).anyOne()
		const y = (valorSpawneoRandomYI.. valorSpawneoRandomYF).anyOne()
		return game.at(x,y) }
		
	method eliminarEnemigo(enemigo){
		game.removeVisual(enemigo)
		listaEnemigos.remove(enemigo)}	
		
	method subirDificultad(){
		
	}	
}
//probando nuevas imagenes (decidir si quedan o no)
object aereosDiagonal inherits Enemigo (valorSpawneoRandomXI = 8, valorSpawneoRandomYI = 7, valorSpawneoRandomYF = 10 ){
 	const frecuenciaSpawneo = 22000
 	var velocidad = 300
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 1, 1, 0)
	}
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["HotAirBalloon_2.png", "Sky Diver.png"].anyOne(), position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
//		//game.onTick(5000,"SpawnearGlobo",{self.spawnearRandom(12, 5)}) }
//		//game.onTick(30000,"aumentardificultad",{self.subirDificultad()})  	}//cada 2 globos aumenta la velocidad
//	
//	method subirDificultad() {
//		self.aumentarVelocidad()
//		game.removeTickEvent("EnemigoMoviendose")
//		game.removeTickEvent("EnemigoMoviendose")
//		self.moverseEnDireccion(velocidadIzquierda, izquierda)
//		self.moverseEnDireccion(velocidadAbajo, abajo) }
//		
//	method aumentarVelocidad(){
//		velocidadIzquierda = 100.max((velocidadIzquierda - 19))
//		velocidadAbajo = 400.max(velocidadAbajo -15) }
//		

 }

object aereosHorizontal inherits Enemigo (valorSpawneoRandomXI = 12){ //probando nuevas imagenes
	const frecuenciaSpawneo = 10000
 	var velocidad = 100
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 0, 1, 0)
	}
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["Helicopter.png", "avion.png", "Bird.png"].anyOne(), position = self.spawnearRandom())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
}

object bomba inherits Enemigo(image = "Missile.png"){ //decidir si poner la imagen de bomba o misil
	const frecuenciaSpawneo = 17000
	var tiempoEnCaer = 3000
 	var velocidad = 250
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 1, 0, 0)
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

object lanzadorDeBalas inherits Enemigo {
	var balasDisparadas = 0
	method lanzarBala(){ //sube la dificultad segun la cantidad de disparos
			if (balasDisparadas < 2) {
			self.crearBalas(1)
			}
			if (balasDisparadas  < 4 and balasDisparadas  >= 2)
			{
			self.crearBalas(2) 
			}
			if (balasDisparadas  >= 4) {
			self.crearBalas(3)
			}
			balasDisparadas  += 1 
	}
	method moverBalas () {
			game.onTick(500,"dispararBala",{balas.forEach( {bala => 
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

