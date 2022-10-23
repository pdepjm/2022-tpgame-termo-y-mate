import wollok.game.*
import marvin.*
import fondo.*
import enemigos.*


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
		game.addVisual(texto)
		
		//INICIO JUEGO
		keyboard.space().onPressDo{self.transicion()}
	}
	
	method transicion(){
		game.removeVisual(texto)
		self.iniciarJuego()
	}
	
	method iniciarJuego(){
	//game.showAttributes(marvin)		
	game.ground("cielo2.png") //borrar esto si no queres ver las celdas
 
  	fondo.cargarFondo()
  	globo.init()
  	marvin.init()
   	cazador.init()
	bomba.init()
	avion.init()
	//contadorKms.init()
	moneda.init()
	corazon.init()
	game.onCollideDo(marvin, {element => element.colisionadoPor()})
	
	}
	
	//que ahcer cuando finaliza el juego
	method juegoFinalizado(){
		//	game.schedule(1500, {game.addVisual(fin)})
			game.clear()
			//sacar los elementos de pantalla
			//podemos hacer que vuelva al menu de inicio (falta menu)
      }
}

object fin{
	var property position = game.at(4,4)
	method image ()= "gameover.png"
	
}





