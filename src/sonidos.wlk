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
		if(imagen == "Sky Diver.png"){self.aplicarSonido("")}
		if(imagen == "Missile.png"){self.aplicarSonido("Missile.mp3")}
		if(imagen == "Helicopter.png"){self.aplicarSonido("helicopter.mp3")}
		if(imagen == "avion.png"){self.aplicarSonido("airplane.ogg")}
		if(imagen == "Bird.png"){self.aplicarSonido("eagle.mp3")}
		else {}
	}
	
	}
