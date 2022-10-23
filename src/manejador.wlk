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
		game.addVisual(botonPlay) //creo que Ami se olvido de subir la iamgen, apretar espacio para empezar
		
		//INICIO JUEGO
		keyboard.space().onPressDo{self.transicion()}
	}
	
	method transicion(){
		botonPlay.cambiarImagen()
		game.schedule(200,{game.removeVisual(botonPlay)})
		game.schedule(200,{self.iniciarJuego()})
	}
	
	method iniciarJuego(){
	//game.showAttributes(marvin)
			
	game.ground("cielo.png") //borrar esto si no queres ver las celdas
 
  	fondo.cargarFondo()
  	marvin.init()
   	cazador.init()
	bomba.init()
	aereosHorizontal.init()
	aereosDiagonal.init()
	score.init()
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





