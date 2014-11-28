equipos<-read.csv("EquiposPrueba.csv")
plan<-read.csv("MantenimientoPruebaR.csv")
summary(equipos)
names(equipos)
names(plan)
#dim(equipos)
tablajunta<-NULL
filas<-dim(plan)[1]
for (i in 1:filas){
  object<-plan[i,3]
  ubica<-plan[i,1]
  if (sum(equipos[,5]==as.character(object))>0){
    result1<-equipos[equipos[,5]==as.character(object),]
    if (sum(result1[,1]==as.character(ubica))>0){
        result2<-result1[result1[,1]==as.character(ubica),]
        tablajunta=rbind(tablajunta,c(result2,plan[i,2:7]))
    }
    else if (sum(result1[,2]==as.character(ubica))>0){
      result2<-result1[result1[,2]==as.character(ubica),]
      tablajunta=rbind(tablajunta,c(result2,plan[i,2:7]))
    }
    else if (sum(result1[,3]==as.character(ubica))>0){
      result2<-result1[result1[,3]==as.character(ubica),]
      tablajunta=rbind(tablajunta,c(result2,plan[i,2:7]))
    }
    else{
      print(i)
      print(ubica)
  }
}
}

#object<-plan[1,2]
#ubica<-plan[1,1]
#sum(equipos[,4]==as.character(object))
#result<-equipos[equipos[,4]==as.character(object),]
#result[,3]==as.character(ubica)
