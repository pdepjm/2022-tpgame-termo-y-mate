import wollok.game.*
import marvin.*
import fondo.*
import enemigos.*
import coleccionables.*
import menu.*
import sonidos.*

object manejadorDeJuego{
	method iniciarPantallaDeInicio(){
		// SONIDO
		musicaFondo.controlesMusica() // flechas arriba y abajo para cambiar volumen, "p" para pausar, "r" para resume (despues puedo cambiar a otras teclas si quieren)
		
		//FONDO DE PANTALLA
		game.boardGround("cielo1.jpg")
		
		//IMAGENES DEL MENÚ
		game.addVisual(titulo)
		game.addVisual(space2)
		game.addVisual(informacionMenu)
		
		//BOTONES: para moverse entre un boton y otro es con "a" y "d", para seleccionar "space"
		game.addVisual(botonPlay)
		game.addVisual(botonInstrucciones)
		keyboard.a().onPressDo{botonPlay.cambiarImagen()}
		keyboard.d().onPressDo{botonPlay.volverALaOriginal()}
		keyboard.d().onPressDo{botonInstrucciones.cambiarImagen()}
		keyboard.a().onPressDo{botonInstrucciones.volverALaOriginal()}
		
		//INICIO JUEGO
		keyboard.space().onPressDo{self.transicion()}
	}
	
	method transicion(){
		if (botonPlay.seleccionado() and game.hasVisual(botonPlay)) {
			
			game.clear()
			game.schedule(100,{self.iniciarJuego()})
		}
		if (botonInstrucciones.seleccionado() and game.hasVisual(botonInstrucciones)) {
			
			game.schedule(100,{game.removeVisual(botonInstrucciones)})
			game.schedule(100,{informacionMenu.pasarAlMenuInstrucciones()})
			keyboard.backspace().onPressDo{self.volverAlMenuPrincipal()}
		}	

	}
	method volverAlMenuPrincipal(){
		game.clear()
		
		self.iniciarPantallaDeInicio()
		informacionMenu.pasarAlMenuPrincipal()
	}

	method iniciarJuego(){
  		fondo.cargarFondo()
  		game.addVisual(contador)
  		marvin.init()
		score.init()
		iniciarEnemigos.init()
		iniciarColeccionables.init() //saludMarvin y Monedero
	
		game.onCollideDo(marvin, {element => element.colisionadoPor()})
	}
	
	//cuando finaliza el juego
	method juegoFinalizado(){
		game.clear()
		game.schedule(100, {game.addVisual(recuadroFinal)})
		game.schedule(100, {game.addVisual(puntajeFinal)})
		game.schedule(100, {game.addVisual(gameOver)})
		game.schedule(100, {game.addVisual(botonesMenuReinicio)})
			
		game.schedule(100, {score.mostrarScore()})
		game.schedule(100, {monedero.mostrarMonedero()})
		keyboard.enter().onPressDo{self.volverAIniciar()}
		keyboard.a().onPressDo{botonesMenuReinicio.cambiarImagen()}
		keyboard.d().onPressDo{botonesMenuReinicio.volverALaOriginal()}
		keyboard.space().onPressDo{self.transicion2()}
		
		//podemos hacer que vuelva al menu de inicio (falta menu)
	}
	
	method transicion2() {
		if (botonesMenuReinicio.menuSeleccionado() and game.hasVisual(botonesMenuReinicio)) {
			game.schedule(100,{self.volverAlMenuPrincipal()})
		}
		
		if (botonesMenuReinicio.reiniciarSeleccionado() and game.hasVisual(botonesMenuReinicio)) {
			game.schedule(100,{self.volverAIniciar()})
		}
	}
	
	method volverAIniciar() {
		game.clear()
		
		self.iniciarJuego()
	}
}

object score{
	var property position = game.at(12,6)
	var contadorKms// = 0
	
	method adicionarScorePorMoneda(){contadorKms+=50}
	method text() = contadorKms.toString()
	method textColor() = "000000"
	method init(){
		contadorKms = 0
		game.addVisual(self)
		//game.say(self,"Recorrido = "+ contadorKms + "Kms")
		game.onTick(500,"RecorridoEnMetros",{contadorKms += 1})}
	
	method mostrarScore(){
		//position = game.at(7,7)
		game.addVisualIn(self, game.at(7,2))
		//game.addVisual(imagenScore)
	}
	
	}


