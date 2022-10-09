import wollok.game.*
import direcciones.*

object marvin {
	var property position = game.at(1,4)
	var property estaVivo = true
	var property image = "pajaro1.png"
	
	method actualizarImagen(imagen) {
		image = imagen
	}
	/*method chocoConEnemigo() = 
		if(self.position().distance(globo.position()) <= 10) self.muerte()
		else null*/
	method muerte() {
		self.actualizarImagen("pajaroMuerto4.png")
		game.schedule(100, {self.actualizarImagen("pajaroMuerto1.png")})
		game.schedule(200, {self.actualizarImagen("pajaroMuerto2.png")})
		game.schedule(300, {self.actualizarImagen("pajaroMuerto3.png")})
		game.schedule(400, {self.actualizarImagen("pajaroMuerto4.png")})
		//faltaria poner el removeVisual o pantalla de muerte
		estaVivo = false
	}
	method volar(){
		
		game.schedule(200, {self.actualizarImagen("pajaro2.png")})
		game.schedule(400, {self.actualizarImagen("pajaro3.png")})
		game.schedule(600, {self.actualizarImagen("pajaro4.png")})
		game.schedule(800, {self.actualizarImagen("pajaro1.png")})
	}
	 
	method subirMucho() {
        position = position.up(3)
    }
    
    method moverse(direccion) {
            position = direccion.siguientePosicion(position)
            }
     
    method controles(){
    	//if (position != ) ver como poner un borde para que el pajaro no suba mas
    	keyboard.w().onPressDo {self.moverse(arriba)}
    	//if (position != game.height())
    	keyboard.a().onPressDo {self.moverse(izquierda)}
    	keyboard.d().onPressDo {self.moverse(derecha)}
    	keyboard.s().onPressDo {self.moverse(abajo)}
    	keyboard.space().onPressDo {self.subirMucho()}
    }
	method init() {
		game.addVisual(self)
		game.onTick(1000, "Volar",{self.volar()})
		self.controles()
		
	}
}

class Nube{
	var resetPosition
	var property position
	var property image
	method colisionadoPor(){}
	method moverseA(direccion) {
    position = direccion.siguientePosicion(position)
	}	
	method volverADerecha() { 
		position = resetPosition
	}
	method moverseSiempreAIzq() {
		game.onTick(100, "nubeMoviendose", {self.moverseA(izquierda) })
	}
}

object nube1 inherits Nube (
	resetPosition = game.at(13, 6), 
	position = game.at(11, 5), 
	image = "Cloud_1.png"
){
	method volverAEmpezar(){
		game.schedule(3800,{self.volverADerecha()})
		game.onTick(12000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube2 inherits Nube (
	resetPosition = game.at(13, 4), 
	position = game.at(3, 3), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(6500,{self.volverADerecha()})
		game.onTick(14000,"nubeInfinita",{self.volverADerecha()})
	}
}

object nube3 inherits Nube (
	resetPosition = game.at(13, 2), 
	position = game.at(7, 1), 
	image = "Cloud_2.png"
){
	method volverAEmpezar(){
		game.schedule(4800,{self.volverADerecha()})
		game.onTick(11500,"empezarDeVuelta",{self.volverADerecha()})
	}
}

object fondo {
	const nubes = [nube1, nube2, nube3]
	method cargarFondo(){
		game.addVisual(nube1)
  		game.addVisual(nube2)
  		game.addVisual(nube3)
		//game.boardGround("cielo.jpg")
		nubes.forEach({nube => 
			nube.moverseSiempreAIzq()
			nube.volverAEmpezar()
		})
	}
}
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
	position = game.at(13,5),
	image = "HotAirBalloon_2.png", 
	limiteX = 8, 
	limiteY = 2, 
	direccion = abajo
 ){
 	var velocidadIzquierda = 200
 	var velocidadDireccion = 400
 	
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
		velocidadIzquierda = 75.max(velocidadIzquierda - 19)
		//velocidadDireccion -= 10
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
	

object cazador inherits Enemigo (
	position = game.at(11.8,0),
	image = "JK_P_Gun__Attack_000.png", 
	limiteX = 6, 
	limiteY = 0, 
	direccion = abajo
	){
	var balas =[new Bala(image = "bala1.png", vIzq = 100, vA = 200)]	//si se ponen todas las balas aca, tira muchas
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
	
	/*method subirDificultad(){ ver como hacer para que ande bien esto, si pongo todas las balas en la lista anda
		if(balas.size() == 1){
			balas.add{new Bala(image = "bala2.png", vIzq = 100, vA = 250)} }
		if(balas.size() == 2){
			balas.add{new Bala(image = "bala3.png", vIzq = 100, vA = 400)} }
		else balas.add{new Bala(image = "bala4.png", vIzq = 100, vA = 300) }	
	}*/
	method init(){
		game.onTick(30000,"Cazador",{self.spawnearYDisparar()})
		//game.onTick(11000,"aumentarDificultad",{self.subirDificultad()})
		}
}
object edificio {
	
	
}

object avion {
	
	
}

object nubeElectrica{
	
}