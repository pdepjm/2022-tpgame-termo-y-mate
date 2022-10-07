import wollok.game.*


object arriba {
    method siguientePosicion(pos) = pos.up(1)
    method siguientePosicion(pos, cant) = pos.up(cant)
}
object derecha {
    method siguientePosicion(pos) = pos.right(1)
    method siguientePosicion(pos, cant) = pos.right(cant)
}
object abajo {
    method siguientePosicion(pos) = pos.down(1)
    method siguientePosicion(pos, cant) = pos.down(cant)
}
object izquierda {
    method siguientePosicion(pos) = pos.left(1)
    method siguientePosicion(pos, cant) = pos.left(cant) 
}
