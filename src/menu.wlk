import wollok.game.*
import manejador.*

//en contruccion

object menu{
//	var property seleccionado = 0
  //  const opciones = [play,/*controles,creditos,bonus*/]
  //  var property screenOnTop = null        //Example: credits or controls

//	method seleccionado() = opciones.get(seleccionado)

    method vista(){
        //self.controles()
//        game.boardGround("./assets/fondo/fondomenu2.jpg")
 //       opciones.forEach({option => game.addVisual(option)})
//        game.addVisual(title)

       //aca se pondria la musica
    }
	 //falta completar
	
	
}

//el titulo en imagen
//object title {
 //   const property position = game.at(2, 11)    
  //  const property image =                  
//}

/*
object teclas {
	const property position = game.at(7,3)
	var property image = "wasd.png"
} 
*/



class Texto {
	const property position //= game.at(6,0)
	const property text
	const property textColor
	
	//method text() = "presione SPACE para iniciar el juego"
	//method textColor() = "000000"
}

//const space = new Texto(position = game.at(6,0), text ="presione SPACE para seleccionar", textColor = "000000")
//const wasd = new Texto(position = game.at(8,5), text ="teclas con las que se juega", textColor = "000000")

class Imagen {
	const property position
	var property image
}

const teclas = new Imagen(position = game.at(8,2), image = "wasdCeleste.png")
const titulo = new Imagen(position = game.at(2,3), image = "TituloDodgyBirdGrande.png")
const space2 = new Imagen(position = game.at(4,0), image = "texto-space2.png")
const instrucciones = new Imagen(position = game.at(3,2), image = "instrucciones2.png")
 
object botonPlay inherits Imagen(position = game.at(4,1), image ="botonPlayCeleste.png") {

	method cambiarImagen() {
		image = "botonPlayCeleste2.png"
	}
}




