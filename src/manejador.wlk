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
		musicaFondo.play()
		musicaFondo.controlesMusica() // flechas arriba y abajo para cambiar volumen, "p" para pausar, "r" para resume (despues puedo cambiar a otras teclas si quieren)
		
		//FONDO DE PANTALLA
		game.boardGround("cielo1.jpg")
		
		//IMAGENES DEL MENÚ
		game.addVisual(instrucciones)
		game.addVisual(teclas)
		game.addVisual(titulo)
		game.addVisual(space2)
		
		//BOTONES: para moverse entre un boton y otro es con "a" y "d", para seleccionar "space"
		game.addVisual(botonPlay)
		game.addVisual(botonInstrucciones)
		keyboard.a().onPressDo{botonPlay.cambiarImagen()}
		keyboard.d().onPressDo{botonPlay.cambiarImagen2()}
		keyboard.d().onPressDo{botonInstrucciones.cambiarImagen()}
		keyboard.a().onPressDo{botonInstrucciones.cambiarImagen2()}
		
		//INICIO JUEGO
		keyboard.space().onPressDo{self.transicion()}
	}
	
	method transicion(){
		if (botonPlay.seleccionado()) {
			botonPlay.cambiarImagen()
			self.borrarTodo()
			game.schedule(100,{self.iniciarJuego()})
		}
		if (botonInstrucciones.seleccionado()) {
			botonInstrucciones.cambiarImagen()
			game.schedule(100,{game.removeVisual(botonInstrucciones)})
			game.schedule(100,{game.removeVisual(teclas)})
			self.mostrarInstrucciones()
				
		}
		else self.esperar()
	}
	
	method esperar() {}
	
	method borrarTodo(){
		game.schedule(100,{game.removeVisual(botonPlay)})
		game.schedule(100,{game.removeVisual(botonInstrucciones)})
		game.schedule(100,{game.removeVisual(space2)})
		game.schedule(100,{game.removeVisual(teclas)})
		game.schedule(100,{game.removeVisual(titulo)})
		game.schedule(100,{game.removeVisual(instrucciones)})
	}
	method mostrarInstrucciones(){
		//agregar imagenes de instrucciones
	}
	
	method iniciarJuego(){		
		//game.ground("cielo.png") //borrar esto si no queres ver las celdas
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
			game.schedule(100, {game.addVisual(fin)})
			//podemos hacer que vuelva al menu de inicio (falta menu)
      }
}

object fin{
	var property position = game.at(4,3)
	var property image = "gameover.png"
}

object score{
	var property position = game.at(12,6)
	var contadorKms = 0
	
	method adicionarScorePorMoneda(){contadorKms+=50}
	method text() = contadorKms.toString()
	method textColor() = "000000"
	method init(){
		game.addVisual(self)
		//game.say(self,"Recorrido = "+ contadorKms + "Kms")
		game.onTick(500,"RecorridoEnMetros",{contadorKms += 1})}
	}


