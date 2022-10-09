import wollok.game.*
import direcciones.*
import marvin.*

class Enemigo {
	var property position
	var property image
	var direccion
	var limiteX
	var limiteY
	
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
	method spawnearRandom (){
		 const x = limiteX.randomUpTo(game.width().truncate(0))
   		 const y = limiteY.randomUpTo(game.height().truncate(0))
   		 position = game.at(x,y)
	}
	//elegir direccion para que se mueva
	method moverseA(direccion_){
		position = direccion_.siguientePosicion(position)
	}
	//siempre se mueve a izquierda y hacia una direccion que definamos
	method moverseEnDireccion(velocidadIzquierda, velocidadDireccion){
		game.onTick(velocidadIzquierda, "EnemigoMoviendose1", {self.moverseA(izquierda) })
		game.onTick(velocidadDireccion, "EnemigoMoviendose2", {self.moverseA(direccion)})
	}
	
}
object globo inherits Enemigo (
	position = game.at(13,6),
	image = "HotAirBalloon_2.png", 
	limiteX = 12, 
	limiteY = 3, 
	direccion = abajo
 ){
 	var velocidadIzquierda = 250
 	var velocidadDireccion = 500
 	
 	method init(){
 		game.addVisual(self)
 		self.moverseEnDireccion(velocidadIzquierda, velocidadDireccion)
		game.onTick(15000,"SpawnearGlobo",{self.spawnearRandom()})
		game.onTick(30000,"aumentardificultad",{self.subirDificultad()}) //cada 2 globos aumenta la velocidad
	}
	method subirDificultad() {
		self.aumentarVelocidad()
		game.removeTickEvent("EnemigoMoviendose1")
		game.removeTickEvent("EnemigoMoviendose2")
		self.moverseEnDireccion(velocidadIzquierda, velocidadDireccion)
		
	}
	method aumentarVelocidad()
	{
		velocidadIzquierda = 100.max((velocidadIzquierda - 19))
		velocidadDireccion = 400.max(velocidadDireccion -15)
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
	image = "JK_P_Gun__Attack_000.png", 
	limiteX = 6, 
	limiteY = 0, 
	direccion = abajo
	){
	var balas = [new Bala(image = "bala1.png", vIzq = 100, vA = 200)]	//si se ponen todas las balas aca, tira muchas
	method spawnearYDisparar(){
		self.spawnear(position)
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

object avion {
	
	
}

object nubeElectrica{
	
}