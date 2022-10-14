import wollok.game.*
import direcciones.*
import marvin.*

class Enemigo {
	var property position
	var property image
	var valorSpawneoRandomX // a partir de que posicion en X va a spawnear aleatoriamente
	var valorSpawneoRandomY // a partir de que posicion en Y va a spawnear aleatoriamente
	const limiteFondoX = -1
	const limiteFondoY = -1
	const listaEnemigos = []
	method colisionadoPor(){
		marvin.muerte() }

	method deSpawnear(){
		game.removeVisual(self) }
		
	method spawnearRandom (){
		const x = (valorSpawneoRandomX.. game.width()-1).anyOne()
		const y = (valorSpawneoRandomY.. game.height()-1).anyOne()
		return game.at(x,y) }
		
	method fueraDelMapa (objeto) = ubicacion.posicionY(objeto) != limiteFondoY and ubicacion.posicionX(objeto) != limiteFondoX //dice si el objeto esta fuera del mapa o no

	method lanzarEnemigo(frecuenciaSpawneo, velocidad, valorUp, valorDown, valorLeft, valorRight)//funcion generica para todos los enemigos, poner 0 en la direccion que no se va a mover
		{ 
		game.onTick(frecuenciaSpawneo,"laboratorioEnemigos",{self.crearEnemigoPosRandom(image)})
		game.onTick(velocidad,"dispararEnemigo",{listaEnemigos.forEach( {enemigo => 
			if (self.fueraDelMapa(enemigo)) 
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
		
}

object globo inherits Enemigo (position = game.at(5,6),image = "./assets/enemigos/HotAirBalloon_2.png", valorSpawneoRandomX = 10, valorSpawneoRandomY = 6 ){
 	var frecuenciaSpawneo = 15000
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
	var frecuenciaSpawneo = 7000
 	var velocidad = 150
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 0, 1, 0)
	}
}

object bomba inherits Enemigo(position = game.center(), image = "./assets/enemigos/bomba.png", valorSpawneoRandomX = 0, valorSpawneoRandomY = 6){
	var frecuenciaSpawneo = 10000
 	var velocidad = 150
	method init(){
		self.lanzarEnemigo(frecuenciaSpawneo, velocidad, 0, 1, 0, 0)
	}
}


object cazador inherits Enemigo (
	position = game.at(11,1), image = "./assets/enemigos/JK_P_Gun__Attack_000.png", valorSpawneoRandomX = 8, valorSpawneoRandomY = 0){
		
	const bala1 = new Bala(image = "./assets/enemigos/bala1.png", vIzq = 100, vA = 200)
	const bala2 = new Bala(image = "./assets/enemigos/bala2.png", vIzq = 100, vA = 250)
	const bala3 = new Bala(image = "./assets/enemigos/bala3.png", vIzq = 100, vA = 400)
	const bala4 = new Bala(image = "./assets/enemigos/bala4.png", vIzq = 100, vA = 300) 
	
	const balas = [bala1,bala2,bala3,bala4]	//si se ponen todas las balas aca, tira muchas
		
	method spawnearYDisparar(){
		self.spawnearRandom()
		game.schedule(100, {game.addVisual(self)})
		game.schedule(200, {self.image("./assets/enemigos/JK_P_Gun__Attack_001.png")})
		game.schedule(300, {self.image("./assets/enemigos/JK_P_Gun__Attack_002.png")})
		game.schedule(400, {balas.forEach({bala => bala.init()})}) // on tick y random
		game.schedule(500, {self.image("./assets/enemigos/JK_P_Gun__Attack_003.png")})
		game.schedule(600, {self.image("./assets/enemigos/JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.image("./assets/enemigos/JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.image("./assets/enemigos/JK_P_Gun__Attack_009.png")})
		game.schedule(1500, {self.deSpawnear()})
		 //tener un contador de balas vivas
	}
	/*method subirDificultad(){ //ver como hacer para que ande bien esto, si pongo todas las balas en la lista anda
		if(balas.size() == 1){
			balas.add{bala2} }
		if(balas.size() == 2){
			balas.add{bala3}}
		else balas.add{bala4}	}*/
		
	method init(){
			game.onTick(10000,"CazadorAparece",{self.spawnearYDisparar()}) }
}

//hay medio un bug que la bala va aumentando exponencialmente la velocidad
class Bala inherits Enemigo(position = cazador.position(),image = "bala1.png", valorSpawneoRandomX = 0, valorSpawneoRandomY = 0){
	var contador = 0
	var vIzq //velocidad hacia izquierda
	var vA //velocidad hacia arriba
	
	/* 
	method colisionadoPor(){
		marvin.muerte()
	}
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}*/
//	method moverseEnDireccion(){
//		game.onTick(vIzq, "EnemigoMoviendose1", {self.moverseA(izquierda) })
//		game.onTick(vA, "EnemigoMoviendose2", {self.moverseA(arriba)})
//	}
	
	method init(){
		if(contador == 0){
			game.addVisual(self)
		}
		position = cazador.position()
		//self.moverseEnDireccion()
		contador += 1  }
}		
	


