import wollok.game.*
import direcciones.*
import marvin.*

const limiteFondoX = -1
const limiteFondoY = -1

class Enemigo {
	var property position
	var property image
	var valorSpawneoRandomX // a partir de que posicion en X va a spawnear aleatoriamente
	var valorSpawneoRandomY // a partir de que posicion en Y va a spawnear aleatoriamente
	const listaEnemigos = []
	method colisionadoPor(){
		marvin.muerte() }

	method deSpawnear(){
		game.removeVisual(self) }
		
	method spawnearRandom (){
		const x = (valorSpawneoRandomX.. game.width()-1).anyOne()
		const y = (valorSpawneoRandomY.. game.height()-1).anyOne()
		return game.at(x,y) }
		
	method dentroDelMapa (objeto) = ubicacion.posicionY(objeto) != limiteFondoY and ubicacion.posicionX(objeto) != limiteFondoX //dice si el objeto esta dentro del mapa o no

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
		const nuevoEnemigo = new Enemigo(image = imagen, position = self.spawnearRandom(), valorSpawneoRandomX = valorSpawneoRandomX, valorSpawneoRandomY = valorSpawneoRandomY)
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
	method eliminarEnemigo(enemigo){
		game.removeVisual(enemigo)
		listaEnemigos.remove(enemigo)}	
		
	method subirDificultad(){
		
	}	
}

object globo inherits Enemigo (position = game.at(5,6),image = "./assets/enemigos/HotAirBalloon_2.png", valorSpawneoRandomX = 10, valorSpawneoRandomY = 6 ){
 	const frecuenciaSpawneo = 22000
 	var velocidad = 400
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 1, 2, 0)
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

object avion inherits Enemigo (position = game.center(), image = "./assets/enemigos/avion.png", valorSpawneoRandomX = 12, valorSpawneoRandomY = 0){
	const frecuenciaSpawneo = 10000
 	var velocidad = 150
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 0, 1, 0)
	}
}

object bomba inherits Enemigo(position = game.center(), image = "./assets/enemigos/bomba.png", valorSpawneoRandomX = 0, valorSpawneoRandomY = 6){
	const frecuenciaSpawneo = 17000
	var tiempoEnCaer = 3000
 	var velocidad = 250
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 1, 0, 0)
	}
		override method spawnearRandom (){
		const x = (valorSpawneoRandomX.. limiteDerechoMarvin).anyOne()
		const y = 12
		game.say(marvin, "¡Se aproxima una bomba!")
		return game.at(x,y) }		
}
	
	
object cazador inherits Enemigo (position = game.at(11,0), image = "./assets/enemigos/JK_P_Gun__Attack_000.png", valorSpawneoRandomX = 9, valorSpawneoRandomY = 0)
	{
	const frecuenciaSpawneo = 30000
	method spawnearYDisparar(){
		game.schedule(200, {self.image("./assets/enemigos/JK_P_Gun__Attack_001.png")})
		game.schedule(300, {self.image("./assets/enemigos/JK_P_Gun__Attack_002.png")})
		game.schedule(400, {lanzadorDeBalas.lanzarBala()}) 
		game.schedule(500, {self.image("./assets/enemigos/JK_P_Gun__Attack_003.png")})
		game.schedule(600, {self.image("./assets/enemigos/JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.image("./assets/enemigos/JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.image("./assets/enemigos/JK_P_Gun__Attack_009.png")})
		game.schedule(1500, {self.deSpawnear()})
		}

	method init (){
		lanzadorDeBalas.moverBalas()
		game.onTick(frecuenciaSpawneo,"spawnCazador", {
		if(!game.hasVisual(self)){
			game.addVisualIn(self, self.spawnearRandom())
			self.spawnearYDisparar()
			}  } ) } 
		 	
	override method spawnearRandom (){
		const x = (valorSpawneoRandomX.. game.width()-1).anyOne()
		const y = 0
		return game.at(x,y) }		
}

const balas = []
class Bala inherits Enemigo(position = cazador.position(), image = "bala1.png", valorSpawneoRandomX = 0, valorSpawneoRandomY = 0){
	const property valorUp
	const property valorLeft
	
}

object lanzadorDeBalas inherits Enemigo (position = game.center(), image = "", valorSpawneoRandomX = 0, valorSpawneoRandomY = 0) {
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
			self.crearBala("./assets/enemigos/bala1.png")
			self.crearBala("./assets/enemigos/bala2.png")
			self.crearBala("./assets/enemigos/bala3.png")		//probe con times y no se como hacer para que ande bien //2.times({self.crearBala()})
		}
		if (cant == 2) {
			self.crearBala("./assets/enemigos/bala1.png")
			self.crearBala("./assets/enemigos/bala2.png")
		}
		else {
			self.crearBala("./assets/enemigos/bala1.png")
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

