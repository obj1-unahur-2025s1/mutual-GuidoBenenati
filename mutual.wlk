class Viaje{
  const idiomas
  method idiomas()=idiomas
  method implicaEsfuerzo()
  method bronceo()
  method cantidadDias()
  method esInteresante()=idiomas.size()>1
  method lePareceInteresante(unSocio)= unSocio.leAtrae(self) and self.esInteresante() and unSocio.ahRealizado(self)
}

class ViajePlaya inherits Viaje{
const largo

override method cantidadDias() =largo/500 
override method implicaEsfuerzo() =largo>1200
override method bronceo()=true 

}
class ViajeCiudad inherits Viaje{
const atracciones

override method cantidadDias() =atracciones/2 
override method implicaEsfuerzo() =atracciones.between(5,8)
override method bronceo()=false 

override method esInteresante()=super() or atracciones==5

}
class ViajeCiudadTropical inherits ViajeCiudad{
override method cantidadDias()=super()+1
override method bronceo()=true 
}

class Trekking inherits Viaje{
const kilometros
const diasDeSol
override method cantidadDias() =kilometros/50
override method implicaEsfuerzo() =kilometros>80
override method bronceo()=diasDeSol>200 or (diasDeSol.between(100, 200) and kilometros >120 )
override method esInteresante()=super() and diasDeSol>1340
}

class Clasegimansia inherits Viaje(idiomas=["español"]){
override method cantidadDias() =1
override method implicaEsfuerzo() =true
override method bronceo()=false
override method lePareceInteresante(unSocio)=unSocio.edad().between(20,30)

}

///Bonus: taller literario
class TallerLiterario inherits Viaje{
const libros =[]
method agregarLibro(unLibro){libros.add(unLibro)}
method idiomasUsados()=libros.map{x=>x.idioma()}.asSet().asList()
method diasQueLleva()=self.cantidadLibros()+1
method cantidadLibros()=libros.size()
override method implicaEsfuerzo()=libros.ant{x=>x.cantidadDePaginas()>500} or (self.cantidadLibros()>1 and libros.map{x=>x.nombreAutor()}.asSet()==1)
override method bronceo()=false
method esRecomendado(unSocio)=unSocio.idiomas().size()>1
}


//libros

class Libro{
  const idioma
  const cantidadDePaginas 
  method cantidadDePaginas()=cantidadDePaginas
  const nombreAutor
  method idiomas()=idioma
}


/////SOCIO/////
class Socio{
const edad
const idiomasQueLeGustan //[]
const actividades=[]
const maximoActividades
method edad()=edad

method agregarActividad(unaActividad){
  if(actividades.size()!=maximoActividades){actividades.add(unaActividad)}
  else{self.error("ya se alcanso el maximo de actividades")}
  }

method esAdoradorDelSol()=actividades.all{x=>x.bronceo()}
method actividadesForsadas()=actividades.filter{x=>x.implicaEsfuerzo()}


//### 5. Actividades que le atraen a cada socio


//### 6. Actividades recomendadas para socios

method ahRealizado(unaActividad)=actividades.contains(unaActividad)
}

class SocioTranquilo inherits Socio{
  method leAtrae(unaActividad)=unaActividad.cantidadDias()>=4
}
class SocioCoherente inherits Socio {
  method leAtrae(unaActividad)=if(self.esAdoradorDelSol())unaActividad.bronceo() else unaActividad.implicaEsfuerzo() 
}
class SocioRelajado inherits Socio {
  method leAtrae(unaActividad)= not idiomasQueLeGustan.intersection(unaActividad.idiomas()).isEmpty()
}