import wollok.game.*
import personaje.*
import direcciones.*
import enemigos.*
import extras.*

	const bombas = []
	const aviones = []
	const balas = []
	const monedero = []


object juego { 
	const limiteCaidaBombaY = 1 // ES EL LIMITE DE CAIDA DE LA BOMBA
	const limiteMovimientoIzquierdaAvionX = 1 // ES EL LIMITE DE MOVIMIENTO DE AVION

	method iniciar(){
		
		game.onTick(5000,"laboratorioBombas",{self.crearBomba()})
		//game.onTick(5000,"laboratorioAviones",{self.crearAvion()})
		game.onTick(500,"laboratorioBalas",{self.crearBalas()})
		
		
		game.onTick(15000,"modificarPosicionCazador",{cazador.actualizarPosicion()})

		game.onTick(150,"dispararBalas", {balas.forEach({balita => if(funcionesExtra.posicionX(balita) != limiteMovimientoIzquierdaAvionX)
			{movimientos.moverLeft(balita,1)} else {self.eliminarBalas(balita)} })})
		
		game.onTick(150,"dispararBombas",{bombas.forEach( {bombita => if (funcionesExtra.posicionY(bombita) != limiteCaidaBombaY)
			{movimientos.moverDown(bombita,1)} else {self.eliminarBomba(bombita)}})})
		
		//game.onTick(100,"dispararAviones",{aviones.forEach( {avioncito => if (funcionesExtra.posicionX(avioncito) != limiteMovimientoIzquierdaAvionX)
			//{movimientos.moverLeft(avioncito,1)} else {self.eliminarAvion(avioncito)} })})
			
		
} // TERMINA EL METODO DE INICIAR JUEGO

	method crearBomba(){
		const nuevaBomba = new Bomba(position = funcionesExtra.randomPosicionInicialBombas())
		game.addVisual(nuevaBomba)
		bombas.add(nuevaBomba) }
		
	method crearAvion(){
		const nuevoAvion = new Avion(position = funcionesExtra.randomPosicionInicialAviones())
		game.addVisual(nuevoAvion)
		aviones.add(nuevoAvion) }
		
	method crearBalas(){
		const nuevaBala = new Bala(position = funcionesExtra.posicionBalas())
		game.addVisual(nuevaBala)
		balas.add(nuevaBala) }
	
	method crearMonedas(){
		const nuevaMonda = new Moneda(position = funcionesExtra.ramdomPosicionTablero())
		game.addVisual(nuevaMonda)
		monedero.add(nuevaMonda) }	
		
	method eliminarBomba(unObjeto){
		game.removeVisual(unObjeto)
		bombas.remove(unObjeto) }
			
	method eliminarAvion(unObjeto){
		game.removeVisual(unObjeto)
		aviones.remove(unObjeto) }
		
	method eliminarBalas(unObjeto){
		game.removeVisual(unObjeto)
		balas.remove(unObjeto)}
	
	method desaparecer(unObjeto){
		game.removeVisual(unObjeto)  }
		}