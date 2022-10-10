import wollok.game.*
import direcciones.*
import marvin.*
import extras.*

class Enemigo {
	var property position
	var property image
	
	method colisionadoPor(){
		marvin.muerte()
	}
	method actualizarImagen(imagen) {
		image = imagen
	}
	method spawnear(posicion){
		game.addVisualIn(self, posicion)
	}
	method deSpawnear(){
		game.removeVisual(self)
	}
	method spawnearRandom (limiteX, limiteY){
		 const x = limiteX.randomUpTo(game.width().truncate(0))
   		 const y = limiteY.randomUpTo(game.height().truncate(0))
   		 position = game.at(x,y)
	}
	//elegir direccion para que se mueva
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}
	//siempre se mueve a izquierda y hacia una direccion que definamos
	method moverseEnDireccion(velocidadDireccion, direccion){
		game.onTick(velocidadDireccion, "EnemigoMoviendose2", {self.moverseA(direccion)})
	}
	
}
object globo inherits Enemigo (
	position = game.at(13,6),
	image = "HotAirBalloon_2.png"
 ){
 	var velocidadIzquierda = 250
 	var velocidadAbajo = 500
 	
 	method init(){
 		game.addVisual(self)
 		self.moverseEnDireccion(velocidadIzquierda, izquierda)
 		self.moverseEnDireccion(velocidadAbajo, abajo)
		game.onTick(15000,"SpawnearGlobo",{self.spawnearRandom(12, 3)})
		game.onTick(30000,"aumentardificultad",{self.subirDificultad()}) //cada 2 globos aumenta la velocidad
	}
	method subirDificultad() {
		self.aumentarVelocidad()
		game.removeTickEvent("EnemigoMoviendose1")
		game.removeTickEvent("EnemigoMoviendose2")
		self.moverseEnDireccion(velocidadIzquierda, velocidadAbajo)
		
	}
	method aumentarVelocidad()
	{
		velocidadIzquierda = 100.max((velocidadIzquierda - 19))
		velocidadAbajo = 400.max(velocidadAbajo -15)
	}
	method cambiarPosition(direccion){
		position = direccion
	}
 }



//hay medio un bug que la bala va aumentando exponencialmente la velocidad
class Bala {
	var property position = cazador.position()
	var property image
	var contador = 0
	var vIzq //velocidad hacia izquierda
	var vA //velocidad hacia arriba
	
	
	method colisionadoPor(){
		marvin.muerte()
	}
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}
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
		contador += 1
	}
	}
	const bala2 = new Bala(image = "bala2.png", vIzq = 100, vA = 250)
	const bala3 = new Bala(image = "bala3.png", vIzq = 100, vA = 400)
	const bala4 = new Bala(image = "bala4.png", vIzq = 100, vA = 300) 
			
object cazador inherits Enemigo (
	position = game.at(11.8,0),
	image = "JK_P_Gun__Attack_000.png"
	){
		var balas = [new Bala(image = "bala1.png", vIzq = 100, vA = 200)]	//si se ponen todas las balas aca, tira muchas
		

	method spawnearYDisparar(){
		self.spawnearRandom(8, 0)
		game.schedule(100, {self.actualizarImagen("JK_P_Gun__Attack_001.png")})
		game.schedule(200, {self.actualizarImagen("JK_P_Gun__Attack_002.png")})
		game.schedule(300, {balas.forEach({bala => bala.init()})})
		game.schedule(350, {self.actualizarImagen("JK_P_Gun__Attack_003.png")})
		game.schedule(500, {self.actualizarImagen("JK_P_Gun__Attack_005.png")})
		game.schedule(700, {self.actualizarImagen("JK_P_Gun__Attack_007.png")})
		game.schedule(900, {self.actualizarImagen("JK_P_Gun__Attack_009.png")})
		game.schedule(1500, {self.deSpawnear()})
	}
	
	/*method subirDificultad(){ //ver como hacer para que ande bien esto, si pongo todas las balas en la lista anda
		if(balas.size() == 1){
			balas.add{bala2} }
		if(balas.size() == 2){
			balas.add{bala3}}
		else balas.add{bala4}	
	}*/
	
	method init(){
			game.onTick(30000,"Cazador",{self.spawnearYDisparar()})
		}
}
object edificio {
	
	
}

class Avion {
	var property position
	var property image = "avion.png"
	const aviones = []
	const limiteCaidaAvionX = 0
	method crearAvion(){
		const nuevoAvion = new Avion(position = funcionesExtra.randomPosicionInicialAviones())
		game.addVisual(nuevoAvion)
		aviones.add(nuevoAvion) }
		
	method eliminarAvion(unObjeto){
		game.removeVisual(unObjeto)
		aviones.remove(unObjeto) }
		
}

object nubeElectrica{
	
}

		

class Bomba  {
	var property position
	const bombas =[]
	const limiteCaidaBombaY = 0
	var property image = "bomba.png"
	
	method crearBomba(){
		const nuevaBomba = new Bomba(position = funcionesExtra.randomPosicionInicialBombas())
		game.addVisual(nuevaBomba)
		bombas.add(nuevaBomba) }
		
	method eliminarBomba(unObjeto){
		game.removeVisual(unObjeto)
		bombas.remove(unObjeto) }
				
}

object ataqueBombas inherits Bomba (position = game.center()){
	method init(){
		game.onTick(5000,"laboratorioBombas",{self.crearBomba()})
		game.onTick(150,"dispararBombas",{bombas.forEach( {bombita => if (funcionesExtra.posicionY(bombita) != limiteCaidaBombaY)
			{movimientos.moverDown(bombita,1)} else {self.eliminarBomba(bombita)}})})
	}
}
object ataqueAviones inherits Avion (position = game.center()){
	method init(){
		game.onTick(5000,"laboratorioAviones",{self.crearAvion()})
		game.onTick(150,"dispararAviones",{aviones.forEach( {avion => if (funcionesExtra.posicionX(avion) != limiteCaidaAvionX)
			{movimientos.moverLeft(avion,1)} else {self.eliminarAvion(avion)}})})
	}
}


