import wollok.game.*
import marvin.*
import fondo.*
import enemigos.*
import coleccionables.*
import menu.*

object manejadorDeJuego{
	method iniciarPantallaDeInicio(){
		// SONIDO
		const soundtrack = game.sound("menu-soundtrack.mp3")		
		soundtrack.shouldLoop(true)
		game.schedule(500,{soundtrack.play()})
		
		//FONDO DE PANTALLA
		game.boardGround("cielo2.png")
		//game.addVisual(botonPlay)
		
		//TEXTO
		game.addVisual(botonPlay)
		game.addVisual(instrucciones)
		game.addVisual(teclas)
		game.addVisual(titulo)
		game.addVisual(space2)
		
		//INICIO JUEGO
		keyboard.space().onPressDo{self.transicion()}
	}
	
	method transicion(){
		botonPlay.cambiarImagen()
		game.schedule(100,{game.removeVisual(botonPlay)})
		//game.schedule(100,{game.removeVisual(wasd)})
		game.schedule(100,{game.removeVisual(space2)})
		game.schedule(100,{game.removeVisual(teclas)})
		game.schedule(100,{game.removeVisual(titulo)})
		game.schedule(100,{game.removeVisual(instrucciones)})
		game.schedule(100,{self.iniciarJuego()})
	}
	
	method iniciarJuego(){
	//game.showAttributes(marvin)
			
	game.ground("cielo.png") //borrar esto si no queres ver las celdas
 
  	fondo.cargarFondo()
  	marvin.init()
   	cazador.init()
	misil.init()
	aereosHorizontal.init()
	aereosDiagonal.init()
	score.init()
	monedero.init()
	moneda.init()
	corazon.init()
	game.onCollideDo(marvin, {element => element.colisionadoPor()})
	
	}
	
	//que ahcer cuando finaliza el juego
	method juegoFinalizado(){
			game.schedule(100, {game.addVisual(fin)})
			game.clear()
			//sacar los elementos de pantalla
			//podemos hacer que vuelva al menu de inicio (falta menu)
      }
}

object fin{
	var property position = game.at(4,4)
	var property image = "gameover.png"
	
}

object score{
	var property position = game.at(12,6)
	var contadorKms = 0
	var property image = "score.png"
	method text() = contadorKms.toString()
	method textColor() = "000000"
	method init(){
		game.addVisual(self)
		//game.say(self,"Recorrido = "+ contadorKms + "Kms")
		game.onTick(500,"RecorridoEnMetros",{contadorKms += 1})}}
		
object monedero{
	var property position = game.at(10,6)
	var property puntos = 0
	var property image = "score.png"
	
	method sumarPuntos(unaMoneda){puntos = puntos + unaMoneda.puntosAdiciona()}
	
	method text() = puntos.toString()
	method textColor() = "000000"
	
	method init(){
		game.addVisual(self)
		game.schedule(100,{self.puntos()})}
}


