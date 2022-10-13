import wollok.game.*
import direcciones.*
import marvin.*
import extras.*

class Enemigo {
	var property position
	var property image
	
	method colisionadoPor(){
		marvin.muerte() }
	
	method actualizarImagen(imagen) {
		image = imagen }
	
	method deSpawnear(){
		game.removeVisual(self) }
		
	method spawnearRandom (limiteX, limiteY){
		const x = (limiteX.. game.width()-1).anyOne()
		const y = (limiteY.. game.height()-1).anyOne()
		return game.at(x,y) }
	
	//elegir direccion para que se mueva
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}
	//siempre se mueve a izquierda y hacia una direccion que definamos
	method moverseEnDireccion(velocidadDireccion, direccion){
		game.onTick(velocidadDireccion, "EnemigoMoviendose", {self.moverseA(direccion)})
	}
	
}

object globo inherits Enemigo (position = game.at(12,6),image = "./assets/enemigos/HotAirBalloon_2.png" ){
 	var velocidadIzquierda = 200
 	var velocidadAbajo = 500
 	const limiteGloboY = 1
 	
 	method init(){	
		game.onTick(7000,"SpawnearGlobo",{
			if(funcionesExtra.posicionY(self) != limiteGloboY)
			{ 	
				game.addVisual(self)
				self.moverseEnDireccion(velocidadIzquierda, izquierda)
 				self.moverseEnDireccion(velocidadAbajo, abajo)
 				}
 				else 
 					self.deSpawnear()
 				})}
 					
					
		//game.onTick(5000,"SpawnearGlobo",{self.spawnearRandom(12, 5)}) }
		//game.onTick(30000,"aumentardificultad",{self.subirDificultad()})  	}//cada 2 globos aumenta la velocidad
	
	method subirDificultad() {
		self.aumentarVelocidad()
		game.removeTickEvent("EnemigoMoviendose")
		game.removeTickEvent("EnemigoMoviendose")
		self.moverseEnDireccion(velocidadIzquierda, izquierda)
		self.moverseEnDireccion(velocidadAbajo, abajo) }
		
	method aumentarVelocidad(){
		velocidadIzquierda = 100.max((velocidadIzquierda - 19))
		velocidadAbajo = 400.max(velocidadAbajo -15) }
		
	method cambiarPosition(direccion){
		position = direccion }
 }



//hay medio un bug que la bala va aumentando exponencialmente la velocidad
class Bala inherits Enemigo(position = cazador.position(),image = "bala1.png"){
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
	method moverseEnDireccion(){
		game.onTick(vIzq, "EnemigoMoviendose1", {self.moverseA(izquierda) })
		game.onTick(vA, "EnemigoMoviendose2", {self.moverseA(arriba)})
	}
	
	method init(){
		if(contador == 0){
			game.addVisual(self)
		}
		position = cazador.position()
		self.moverseEnDireccion()
		contador += 1  }
}		
	
object cazador inherits Enemigo (
	position = game.at(11,1),image = "./assets/enemigos/JK_P_Gun__Attack_000.png"){
		
	const bala1 = new Bala(image = "./assets/enemigos/bala1.png", vIzq = 100, vA = 200)
	const bala2 = new Bala(image = "./assets/enemigos/bala2.png", vIzq = 100, vA = 250)
	const bala3 = new Bala(image = "./assets/enemigos/bala3.png", vIzq = 100, vA = 400)
	const bala4 = new Bala(image = "./assets/enemigos/bala4.png", vIzq = 100, vA = 300) 
	
	const balas = [bala1,bala2,bala3,bala4]	//si se ponen todas las balas aca, tira muchas
		
	method spawnearYDisparar(){
		self.spawnearRandom(8, 0)
		game.schedule(100, {game.addVisual(self)})
		game.schedule(200, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_001.png")})
		game.schedule(300, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_002.png")})
		game.schedule(400, {balas.forEach({bala => bala.init()})}) // on tick y random
		game.schedule(500, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_003.png")})
		game.schedule(600, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.actualizarImagen("./assets/enemigos/JK_P_Gun__Attack_009.png")})
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


 // VER EL TEMA DE LAS LLAVES EN LA CLASE ENEMIGO Y AVION
class Avion inherits Enemigo(position = game.center(),image = "./assets/enemigos/avion.png",velocidad){}



object ataqueAviones inherits Avion (position = game.center()){
	const aviones = []
	const limiteCaidaAvionX = 0
	
	method init(){
		game.onTick(5000,"laboratorioAviones",{self.crearAvion()})
		game.onTick(150,"dispararAviones",{aviones.forEach( {avion => if (funcionesExtra.posicionX(avion) != limiteCaidaAvionX) //hacer un objeto que hago esto ara todos
			{movimientos.moverLeft(avion,1)} else {self.eliminarAvion(avion)}})})   }

	method crearAvion(){
		const nuevoAvion = new Avion(position = self.spawnearRandom(12,0)) 
		game.addVisual(nuevoAvion)
		aviones.add(nuevoAvion) }
		
	method eliminarAvion(unObjeto){
		game.removeVisual(unObjeto)
		aviones.remove(unObjeto) }		
}

class Bomba inherits Enemigo(position = game.center(), image = "./assets/enemigos/bomba.png"){} 
	
object ataqueBombas inherits Bomba (position = game.center()){
	const bombas =[]
	const limiteCaidaBombaY = 0
	
	method init(){
		game.onTick(5000,"laboratorioBombas",{self.crearBomba()})
		game.onTick(150,"dispararBombas",{bombas.forEach( {bombita => if (funcionesExtra.posicionY(bombita) != limiteCaidaBombaY)
			{movimientos.moverDown(bombita,1)} else {self.eliminarBomba(bombita)}})})   }
	
	method crearBomba(){
		const nuevaBomba = new Bomba(position = self.spawnearRandom(0,6))
		game.addVisual(nuevaBomba)
		bombas.add(nuevaBomba) }
		
	method eliminarBomba(unObjeto){
		game.removeVisual(unObjeto)
		bombas.remove(unObjeto) }
}

	
	
	
	
	
	
	
	
	
	
	
	

