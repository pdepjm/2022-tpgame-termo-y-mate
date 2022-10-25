import wollok.game.*
import manejador.*

object sonido{
	
	method aplicarSonido(sonido)
	{
		game.sound(sonido).play()
	}
	method sonidoEnemigo(imagen)
	{
		if(imagen == "HotAirBalloon_2.png"){self.aplicarSonido("balloon.mp3")}
		//game.sound(sonido).play() 
		if(imagen == "Sky Diver.png"){self.aplicarSonido("skyDiver.mp3")}
		if(imagen == "Missile.png"){self.aplicarSonido("Missile.mp3")}
		if(imagen == "Helicopter.png"){self.aplicarSonido("helicopter.mp3")}
		if(imagen == "avion.png"){self.aplicarSonido("airplane.mp3")}
		if(imagen == "Bird.png"){self.aplicarSonido("eagle.mp3")}
		else {}
	}
	
	}

object musicaFondo {
	const soundtrack = game.sound("pencil-maze.mp3")
	
	method play() {		
		soundtrack.shouldLoop(true)
		game.schedule(500,{soundtrack.play()})
	}
	method controlesMusica(){
		keyboard.r().onPressDo{if(soundtrack.paused()) self.resume()}
		keyboard.p().onPressDo{if(!soundtrack.paused()) self.pause()}
		keyboard.up().onPressDo{self.subirVolumen()}
		keyboard.down().onPressDo{self.bajarVolumen()}
	}
	method resume() {
		soundtrack.resume()
	}
	method pause() {
		soundtrack.pause()
	}
	method subirVolumen() {
		soundtrack.volume(soundtrack.volume() * 1.2)
	}
	method bajarVolumen() {
		soundtrack.volume(soundtrack.volume() * 0.8)
	}
}