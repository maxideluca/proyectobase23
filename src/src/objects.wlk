object agencia {
	
	var property empleados=#{}
	
}

class Empleado {
	
	const property habilidades=#{}
	var property salud
	const property esJefe
	const property subordinados=#{}
	var property misionesRealizadas=#{}
	
	
	method saludCritica()
	
	method incapacitado(){
		return self.saludCritica()>self.salud()
	}
	
	method puedeUsarHabilidadNoJefe(unaHabilidad){
		return (not(self.incapacitado()) and habilidades.contains(unaHabilidad))
	}
	
	method puedeUsarHabilidad(unaHabilidad){
		if(self.esJefe()){
		return subordinados.any({unEmpleado=>unEmpleado.puedeUsarHabilidadNoJefe(unaHabilidad)})
		
		}
		else{return self.puedeUsarHabilidadNoJefe(unaHabilidad)}
	}
	
	method cumplirMision(unaMision){
		unaMision.habilidadesRequeridas().all({unaHabilidad=>self.puedeUsarHabilidad(unaHabilidad)})
		self.recibirDanio(unaMision.peligrosidad())
		if(self.sobrevivio()){
			self.agregarEstrella(1)
			misionesRealizadas.add(unaMision)
		}
		
	}
	
	method recibirDanio(numero){
		salud=salud-numero
	}
	
	method sobrevivio(){
		return salud>0
	}
	
	method agregarEstrella(numero)
}

class Espia inherits Empleado {
	
	override method saludCritica(){
		return 15
	}
}

class Oficinista inherits Empleado{
	var property estrellas
	
	override method agregarEstrella(numero){
		estrellas=estrellas+numero
	}
	override method saludCritica(){
		return 40-(5*estrellas)
	}
}

class Mision {
	const property habilidadesRequeridas
	const property peligrosidad
}

class Equipo{
	const property empleados=#{}
	
	method cumplirMision(mision){
		empleados.any({unEmpleado=>unEmpleado.cumplirMision(mision)})
		empleados.forEach({unEmpleado=>unEmpleado.recibirDanio((mision.peligrosidad())/3)})
	}
}
