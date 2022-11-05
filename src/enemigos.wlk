import wollok.game.*
import direcciones.*
import marvin.*
import sonidos.*

const limiteDESPAWNFondoX = -1 //posicion en X en la que el objeto va a desaaparecer
const limiteDESPAWNFondoY = -1 //posicion en Y en la que el objeto va a desaaparecer
const limitePantallaX = game.width()-1 // limite de X en pantalla
const limitePantallaY = game.height()-1 //limite de Y en pantalla

object iniciarEnemigos{
	
	method init(){
		game.schedule(1000, {cazador.init() misil.init() aereosHorizontal.init() aereosDiagonal.init()})
	}	
}

class Enemigo {
	var property position = game.center() //se cambia para cada enemigo de ser necesario
	var property image = ""
	var property velocidad = 0
	const valorSpawneoRandomXI = 0 // a partir de que posicion inicial en X va a spawnear aleatoriamente
	const valorSpawneoRandomYI = 0 // a partir de que posicion inicial en Y va a spawnear aleatoriamente
	const valorSpawneoRandomXF = limitePantallaX //hasta que posicion en X e Y final puede spawnear aleatoriamente
	const valorSpawneoRandomYF = limitePantallaY
	const listaEnemigos = #{}
	
	method colisionadoPor(){
		marvin.muerte() 
		saludMarvin.restarVidas()
		 marvin.muerte() 
		}

	method dentroDelMapa (objeto) = ubicacion.posicionY(objeto) != limiteDESPAWNFondoY and ubicacion.posicionX(objeto) != limiteDESPAWNFondoX //dice si el objeto esta dentro del mapa o no
	method lanzarEnemigo(frecuenciaSpawneo, velocidadMax, valorUp, valorDown, valorLeft, valorRight){ 
			game.onTick(frecuenciaSpawneo, "lanzarEnemigo", {
				self.moverEnemigo(valorUp, valorDown, valorLeft, valorRight)
				if(velocidad != velocidadMax){ 
				velocidad = velocidadMax.max((velocidad - (velocidad * 0.1))) //los enemigos van aumentando su velocidad progresivamente
				}}) }
	
	method moverEnemigo(valorUp, valorDown, valorLeft, valorRight)//cantidad de celdas que se mueve en cada direccion. Poner 0 en la direccion que no se va a mover
		{ 
		self.crearEnemigoPosRandom(image)
		game.onTick(velocidad,"moverEnemigo", {listaEnemigos.forEach( {enemigo => 
			if (self.dentroDelMapa(enemigo)) 
			{	
				self.moverseDentroDelMapa(enemigo, valorUp, valorDown, valorLeft, valorRight)
			}
			else self.eliminarEnemigo(enemigo) } ) } ) }
			
	method moverseDentroDelMapa(enemigo, valorUp, valorDown, valorLeft, valorRight)
	{
				movimientos.moverUp(enemigo, valorUp)
				movimientos.moverDown(enemigo, valorDown)
				movimientos.moverLeft(enemigo, valorLeft) 
				movimientos.moverRight(enemigo, valorRight)
	}

					
	method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = imagen, position = self.spawnearRandom())
		sonido.sonidoEnemigo(nuevoEnemigo.image())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
		
	method spawnearRandom (){ 
		const x = (valorSpawneoRandomXI.. valorSpawneoRandomXF).anyOne()
		const y = (valorSpawneoRandomYI.. valorSpawneoRandomYF).anyOne()
		return game.at(x,y) }
		
	method eliminarEnemigo(enemigo){
		if(game.hasVisual(enemigo))
		{
			game.removeVisual(enemigo)
			game.schedule(2000, {game.removeTickEvent("moverEnemigo")})
		}
		listaEnemigos.remove(enemigo)

		}
			
}

object aereosDiagonal inherits Enemigo (valorSpawneoRandomXI = 7, valorSpawneoRandomXF=11, valorSpawneoRandomYI = 7, valorSpawneoRandomYF = 11 ){
 	const frecuenciaSpawneo = 21000
 	const velocidadMax = 90 //maxima velocidad que alcanzara
	method init(){
		velocidad = 300
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 1, 1, 0)
	}
				
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["HotAirBalloon_2.png", "Sky Diver.png"].anyOne(), position = self.spawnearRandom())
		sonido.sonidoEnemigo(nuevoEnemigo.image())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
 }

object aereosHorizontal inherits Enemigo (valorSpawneoRandomXI = 12){ 
	const frecuenciaSpawneo = 5000
	const velocidadMax = 30
	method init(){
		velocidad = 190
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 0, 1, 0)
	}
	
	override method crearEnemigoPosRandom(imagen){
		const nuevoEnemigo = new Enemigo(image = ["Helicopter.png", "avion.png", "Bird.png" ].anyOne(), position = self.spawnearRandom())
		sonido.sonidoEnemigo(nuevoEnemigo.image())
		game.addVisual(nuevoEnemigo)
		listaEnemigos.add(nuevoEnemigo)
	}
}

object misil inherits Enemigo(image = "Missile.png"){ //decidir si poner la imagen de bomba o misil
	const frecuenciaSpawneo = 12000
	const velocidadMax = 80
	method init(){
		velocidad = 250
		self.lanzarEnemigo(frecuenciaSpawneo, velocidadMax, 0, 1, 0, 0)
	}
		override method spawnearRandom (){
		const x = (valorSpawneoRandomXI.. limiteDerechoMarvin).anyOne()
		const y = 12
		game.say(marvin, "¡Se aproxima un misil!")
		return game.at(x,y) }		
}
	
	
object cazador inherits Enemigo (image = "JK_P_Gun__Attack_000.png", valorSpawneoRandomXI = 9, valorSpawneoRandomYI = 0, valorSpawneoRandomYF = 0)
	{
	const frecuenciaSpawneo = 27000
	
	override method position(pos){ //necesito que sea getter
		position = self.spawnearRandom()}
		
	method disparar(){
		game.schedule(200, {self.image("JK_P_Gun__Attack_001.png")})
		game.schedule(300, {self.image("JK_P_Gun__Attack_002.png")})
		game.schedule(400, {lanzadorDeBalas.lanzarBala()}) 
		game.schedule(500, {self.image("JK_P_Gun__Attack_003.png")})
		game.schedule(600, {self.image("JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.image("JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.image("JK_P_Gun__Attack_009.png")})
		game.schedule(1500, {game.removeVisual(self)})
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
			sonido.aplicarSonido("bang_01.ogg")
			}
			if (balasDisparadas  < 5 and balasDisparadas  >= 3)
			{
			self.crearBalas(2) 
			sonido.aplicarSonido("bang_02.ogg")
			}
			if (balasDisparadas  >= 5) {
			self.crearBalas(3)
			sonido.aplicarSonido("bang_02.ogg")
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
	
	method crearBalas(cant){ //crear balas segun la cantidad, maximo 3
		if(cant == 3)
		{
			self.crearBala("bala2.png")
			self.crearBala("bala3.png")	
		}
		if (cant == 2) {
			self.crearBala("bala2.png")
		}
			self.crearBala("bala1.png")

	}
	method crearBala(imagen){
		const bala = new Bala(position = cazador.position(), image = imagen, valorUp = (0.. 1).anyOne(), valorLeft = (1.. 2).anyOne())
		game.addVisual(bala)
		balas.add(bala)
	}
	method eliminarBala(bala){
		if(game.hasVisual(bala))
		{game.removeVisual(bala)}
		balas.remove(bala)
	}
}

