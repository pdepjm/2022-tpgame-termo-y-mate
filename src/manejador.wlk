import wollok.game.*
import marvin.*
import fondo.*
import enemigos.*


object manejadorDeJuego{
	
	method iniciarJuego(){
	
	
	//game.addVisual("./assets/fondo/gameover.png")
		
	game.ground("./assets/fondo/cielo.jpg") //borrar esto si no queres ver las celdas
 
 
  	fondo.cargarFondo()
  	game.schedule(1000, {globo.init()})
  	marvin.init()
   	cazador.init()
	ataqueBombas.init()
	ataqueAviones.init()
	
	game.onCollideDo(marvin, {element => element.colisionadoPor()
								self.juegoFinalizado()
	})
	//contadorKms.init()
	aparacerMonedas.init()
	aparecerVidas.init()
 
   	globo.init()
	}
	
	//que ahcer cuando finaliza el juego
	method juegoFinalizado(){
		//	game.schedule(1500, {game.addVisual(fin)})
			
		//	game.removeVisual(globo)
		//	game.removeVisual(ataqueBombas)
		//	game.removeVisual(ataqueAviones)
		//	game.removeVisual(cazador)
			 
		//	globo.removerDePantalla()
		//	ataqueBombas.removerDePantalla()
		//	cazador.removerDePantalla()
		//	globo.removerDePantalla()
		
			//sacar los elementos de pantalla
			//podemos hacer que vuelva al menu de inicio (falta menu)
      }

	
}

object fin{
	var property position = game.origin()
	method image ()= "./assets/fondo/gameover.png"
	
}





