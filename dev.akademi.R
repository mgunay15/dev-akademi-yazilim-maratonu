install.packages("rjson")
library("rjson")
result <- fromJSON(file = "all_data 3.json")
max_length <- max(unlist(lapply (result, FUN = length)))
result <- sapply (result, function (x) {length (x) <- max_length; return (x)})


parsed <- t(result)

# newdata <- subset(parsed, select=c(2,3,4,5,6,7,8,14,16,17))
# 
# clicked <- newdata[which(newdata[,8] == 'CLICK'),]
# clicked <- subset(clicked, select=c(1,2,3,4,5,6,7,9))
# 
# impressed <- newdata[which(newdata[,8] == 'IMPRESSION'),]
# impressed <- subset(impressed, select=c(1,2,3,4,5,6,7,9))
# 


newdata <- subset(parsed, select=c(3,4,5,6,7,8,14,16,17))

clicked <- newdata[which(newdata[,7] == 'CLICK'),]
clicked <- subset(clicked, select=c(1,2,3,4,5,6,8))

impressed <- newdata[which(newdata[,7] == 'IMPRESSION'),]
impressed <- subset(impressed, select=c(1,2,3,4,5,6,8))



clicked <- as.matrix(clicked)
impressed <- as.matrix(impressed)

#for(i in 1: 1334){
# for(j in 1335:101557){
#   if(newdata[i,1]==newdata[j,1] && newdata[i,7]==newdata[j,7]){
#     newdata[-j,]
#   }
# }
#}



#nrow(clicked) = 1334(1068    266)
#nrow(impressed) = 100155(80124   20031)

# dividing both classes into two parts as training(80%) and testing(20%) 


#clicked_train <- matrix((0:0), nrow = 1068, ncol = 7)
clicked_train<-clicked[1:1068,]
clicked_test<-clicked[1069:1334,]

impressed_train <- impressed[1:80124,]
impressed_test <- impressed[80125:100155,]
y <- as.numeric(unlist(clicked_train))

pcd_for_click <- matrix(0:0, nrow = 1068, ncol = 227)

for(i in 1:1068){
  for(j in 1:7){
    if(j==6){
      a = clicked_train[i,j]
      a <- as.numeric(unlist(a))
      pcd_for_click[i,a]<-1
    }else if(j==1){
      if(clicked_train[i,j] == "Üniversite"){
        pcd_for_click[i,205]<-1
      } else if(clicked_train[i,j] == "Lise"){
        pcd_for_click[i,206]<-1
      } else if(clicked_train[i,j] == "Yüksek Lisans / Doktora"){
        pcd_for_click[i,207]<-1
      } else if(clicked_train[i,j] == "Ortaokul"){
        pcd_for_click[i,208]<-1
      } else if(clicked_train[i,j] == "İlkokul"){
        pcd_for_click[i,209]<-1
      }
    }else if(j==2){
      if(clicked_train[i,j] == "Serbest Meslek"){
        pcd_for_click[i,210]<-1
      } else if(clicked_train[i,j] == "Özel Sektör"){
        pcd_for_click[i,211]<-1
      } else if(clicked_train[i,j] == "Çiftçi"){
        pcd_for_click[i,212]<-1
      } else if(clicked_train[i,j] == "Çalışmıyorum"){
        pcd_for_click[i,213]<-1
      } else if(clicked_train[i,j] == "Öğrenci"){
        pcd_for_click[i,214]<-1
      }else if(clicked_train[i,j] == "Emekli"){
        pcd_for_click[i,215]<-1
      } else if(clicked_train[i,j] == "Kamu Çalışanı"){
        pcd_for_click[i,216]<-1
      }
    }else if(j==3){
      if(clicked_train[i,j] == "Evli"){
        pcd_for_click[i,217]<-1
      } else if(clicked_train[i,j] == "Bekar"){
        pcd_for_click[i,218]<-1
      }
    }else if(j==5){
      if(clicked_train[i,j] == "K"){
        pcd_for_click[i,219]<-1
      } else if(clicked_train[i,j] == "E"){
        pcd_for_click[i,220]<-1
      } else if(clicked_train[i,j] == "U"){
        pcd_for_click[i,221]<-1
      }
    }else if(j==7){
      if(clicked_train[i,j] == "Emlak"){
        pcd_for_click[i,222]<-1
      } else if(clicked_train[i,j] == "İkinci El ve Sıfır Alışveriş"){
        pcd_for_click[i,223]<-1
      } else if(clicked_train[i,j] == "Yedek Parça, Aksesuar, Donanım & Tuning"){
        pcd_for_click[i,224]<-1
      }else if(clicked_train[i,j] == "Vasıta"){
        pcd_for_click[i,225]<-1
      } else if(clicked_train[i,j] == "Hayvanlar Alemi"){
        pcd_for_click[i,226]<-1
      }else if(clicked_train[i,j] == "İş Makineleri & Sanayi"){
        pcd_for_click[i,227]<-1
      } 
    }
  }
}


pcd_for_impressed <- matrix(0:0, nrow = 80124, ncol = 227)


for(i in 1:80124){
  for(j in 1:7){
    if(j==6){
      a = impressed_train[i,j]
      a <- as.numeric(unlist(a))
      pcd_for_impressed[i,a]<-1
    }else if(j==1){
      if(impressed_train[i,j] == "Üniversite"){
        pcd_for_impressed[i,205]<-1
      } else if(impressed_train[i,j] == "Lise"){
        pcd_for_impressed[i,206]<-1
      } else if(impressed_train[i,j] == "Yüksek Lisans / Doktora"){
        pcd_for_impressed[i,207]<-1
      } else if(impressed_train[i,j] == "Ortaokul"){
        pcd_for_impressed[i,208]<-1
      } else if(impressed_train[i,j] == "İlkokul"){
        pcd_for_impressed[i,209]<-1
      }
    }else if(j==2){
      if(impressed_train[i,j] == "Serbest Meslek"){
        pcd_for_impressed[i,210]<-1
      } else if(impressed_train[i,j] == "Özel Sektör"){
        pcd_for_impressed[i,211]<-1
      } else if(impressed_train[i,j] == "Çiftçi"){
        pcd_for_impressed[i,212]<-1
      } else if(impressed_train[i,j] == "Çalışmıyorum"){
        pcd_for_impressed[i,213]<-1
      } else if(impressed_train[i,j] == "Öğrenci"){
        pcd_for_impressed[i,214]<-1
      }else if(impressed_train[i,j] == "Emekli"){
        pcd_for_impressed[i,215]<-1
      } else if(impressed_train[i,j] == "Kamu Çalışanı"){
        pcd_for_impressed[i,216]<-1
      }
    }else if(j==3){
      if(impressed_train[i,j] == "Evli"){
        pcd_for_impressed[i,217]<-1
      } else if(impressed_train[i,j] == "Bekar"){
        pcd_for_impressed[i,218]<-1
      }
    }else if(j==5){
      if(impressed_train[i,j] == "K"){
        pcd_for_impressed[i,219]<-1
      } else if(impressed_train[i,j] == "E"){
        pcd_for_impressed[i,220]<-1
      } else if(impressed_train[i,j] == "U"){
        pcd_for_impressed[i,221]<-1
      }
    }else if(j==7){
      if(impressed_train[i,j] == "Emlak"){
        pcd_for_impressed[i,222]<-1
      } else if(impressed_train[i,j] == "İkinci El ve Sıfır Alışveriş"){
        pcd_for_impressed[i,223]<-1
      } else if(impressed_train[i,j] == "Yedek Parça, Aksesuar, Donanım & Tuning"){
        pcd_for_impressed[i,224]<-1
      }else if(impressed_train[i,j] == "Vasıta"){
        pcd_for_impressed[i,225]<-1
      } else if(impressed_train[i,j] == "Hayvanlar Alemi"){
        pcd_for_impressed[i,226]<-1
      }else if(impressed_train[i,j] == "İş Makineleri & Sanayi"){
        pcd_for_impressed[i,227]<-1
      } 
    }
  }
}

pcd_for_click <- colSums(pcd_for_click)/227
pcd_for_impressed <- colSums(pcd_for_impressed)/227

#normalize clicked_test
nclicked_test <- matrix(0:0, nrow = 266, ncol = 227)
for(i in 1:266){
  for(j in 1:7){
    if(j==6){
      a = clicked_test[i,j]
      a <- as.numeric(unlist(a))
      nclicked_test[i,a]<-1
    }else if(j==1){
      if(clicked_test[i,j] == "Üniversite"){
        nclicked_test[i,205]<-1
      } else if(clicked_test[i,j] == "Lise"){
        nclicked_test[i,206]<-1
      } else if(clicked_test[i,j] == "Yüksek Lisans / Doktora"){
        nclicked_test[i,207]<-1
      } else if(clicked_test[i,j] == "Ortaokul"){
        nclicked_test[i,208]<-1
      } else if(clicked_test[i,j] == "İlkokul"){
        nclicked_test[i,209]<-1
      }
    }else if(j==2){
      if(clicked_test[i,j] == "Serbest Meslek"){
        nclicked_test[i,210]<-1
      } else if(clicked_test[i,j] == "Özel Sektör"){
        nclicked_test[i,211]<-1
      } else if(clicked_test[i,j] == "Çiftçi"){
        nclicked_test[i,212]<-1
      } else if(clicked_test[i,j] == "Çalışmıyorum"){
        nclicked_test[i,213]<-1
      } else if(clicked_test[i,j] == "Öğrenci"){
        nclicked_test[i,214]<-1
      }else if(clicked_test[i,j] == "Emekli"){
        nclicked_test[i,215]<-1
      } else if(clicked_test[i,j] == "Kamu Çalışanı"){
        nclicked_test[i,216]<-1
      }
    }else if(j==3){
      if(clicked_test[i,j] == "Evli"){
        nclicked_test[i,217]<-1
      } else if(clicked_test[i,j] == "Bekar"){
        nclicked_test[i,218]<-1
      }
    }else if(j==5){
      if(clicked_test[i,j] == "K"){
        nclicked_test[i,219]<-1
      } else if(clicked_test[i,j] == "E"){
        nclicked_test[i,220]<-1
      } else if(clicked_test[i,j] == "U"){
        nclicked_test[i,221]<-1
      }
    }else if(j==7){
      if(clicked_test[i,j] == "Emlak"){
        nclicked_test[i,222]<-1
      } else if(clicked_test[i,j] == "İkinci El ve Sıfır Alışveriş"){
        nclicked_test[i,223]<-1
      } else if(clicked_test[i,j] == "Yedek Parça, Aksesuar, Donanım & Tuning"){
        nclicked_test[i,224]<-1
      }else if(clicked_test[i,j] == "Vasıta"){
        nclicked_test[i,225]<-1
      } else if(clicked_test[i,j] == "Hayvanlar Alemi"){
        nclicked_test[i,226]<-1
      }else if(clicked_test[i,j] == "İş Makineleri & Sanayi"){
        nclicked_test[i,227]<-1
      } 
    }
  }
}


#normalize impressed_test
nimpressed_test <- matrix(0:0, nrow = 20031, ncol = 227)
for(i in 1:20031){
  for(j in 1:7){
    if(j==6){
      a = impressed_test[i,j]
      a <- as.numeric(unlist(a))
      nimpressed_test[i,a]<-1
    }else if(j==1){
      if(impressed_test[i,j] == "Üniversite"){
        nimpressed_test[i,205]<-1
      } else if(impressed_test[i,j] == "Lise"){
        nimpressed_test[i,206]<-1
      } else if(impressed_test[i,j] == "Yüksek Lisans / Doktora"){
        nimpressed_test[i,207]<-1
      } else if(impressed_test[i,j] == "Ortaokul"){
        nimpressed_test[i,208]<-1
      } else if(impressed_test[i,j] == "İlkokul"){
        nimpressed_test[i,209]<-1
      }
    }else if(j==2){
      if(impressed_test[i,j] == "Serbest Meslek"){
        nimpressed_test[i,210]<-1
      } else if(impressed_test[i,j] == "Özel Sektör"){
        nimpressed_test[i,211]<-1
      } else if(impressed_test[i,j] == "Çiftçi"){
        nimpressed_test[i,212]<-1
      } else if(impressed_test[i,j] == "Çalışmıyorum"){
        nimpressed_test[i,213]<-1
      } else if(impressed_test[i,j] == "Öğrenci"){
        nimpressed_test[i,214]<-1
      }else if(impressed_test[i,j] == "Emekli"){
        nimpressed_test[i,215]<-1
      } else if(impressed_test[i,j] == "Kamu Çalışanı"){
        nimpressed_test[i,216]<-1
      }
    }else if(j==3){
      if(impressed_test[i,j] == "Evli"){
        nimpressed_test[i,217]<-1
      } else if(impressed_test[i,j] == "Bekar"){
        nimpressed_test[i,218]<-1
      }
    }else if(j==5){
      if(impressed_test[i,j] == "K"){
        nimpressed_test[i,219]<-1
      } else if(impressed_test[i,j] == "E"){
        nimpressed_test[i,220]<-1
      } else if(impressed_test[i,j] == "U"){
        nimpressed_test[i,221]<-1
      }
    }else if(j==7){
      if(impressed_test[i,j] == "Emlak"){
        nimpressed_test[i,222]<-1
      } else if(impressed_test[i,j] == "İkinci El ve Sıfır Alışveriş"){
        nimpressed_test[i,223]<-1
      } else if(impressed_test[i,j] == "Yedek Parça, Aksesuar, Donanım & Tuning"){
        nimpressed_test[i,224]<-1
      }else if(impressed_test[i,j] == "Vasıta"){
        nimpressed_test[i,225]<-1
      } else if(impressed_test[i,j] == "Hayvanlar Alemi"){
        nimpressed_test[i,226]<-1
      }else if(impressed_test[i,j] == "İş Makineleri & Sanayi"){
        nimpressed_test[i,227]<-1
      } 
    }
  }
}



#prior probabilities  #of samples of that class/# of samples
impression = 80124/81192
click = 1068/81192

pcd_for_click <- t(pcd_for_click)
pcd_for_impressed <-t(pcd_for_impressed)

#nimpressed_test #nclicked_test


confusion_matrix_test_set <- matrix(nrow = 2, ncol = 2)

x <- log(pcd_for_impressed)
x[x == -Inf] <- 0
x[is.na(x)] <- 0
y <- log(1-pcd_for_impressed)
y[y == -Inf] <- 0
y[is.na(y)] <- 0
z <- log(pcd_for_click)
z[z == -Inf] <- 0
z[is.na(z)] <- 0
t <- log(1-pcd_for_click)
t[t == -Inf] <- 0
t[is.na(t)] <- 0

for(i in 1:20031){
  imValue<-0
  clickValue <-0
  
  imValue <-(nimpressed_test[i,]%*%x) + ((1-nimpressed_test[i,])%*%y)+log(impression)
  clickValue<-(nimpressed_test[i,]%*%z) + ((1-nimpressed_test[i,])%*%t)+log(impression)
  if(imValue>clickValue){
    confusion_matrix_test_set[2,2] <- (confusion_matrix_test_set[2,2]+1)
  }else{
    confusion_matrix_test_set[2,1] <- (confusion_matrix_test_set[2,1]+1)
  }
  
}


for(i in 1:266){
  max <- -Inf
  imValue<-0
  clickValue <-0
  imValue <-(nimpressed_test[i,]%*%x) + ((1-nimpressed_test[i,])%*%y)+log(click)
  clickValue<-(nimpressed_test[i,]%*%z) + ((1-nimpressed_test[i,])%*%t)+log(click)
  if(imValue>clickValue){
    confusion_matrix_test_set[1,2] <- (confusion_matrix_test_set[1,2]+1)
  }else{
    confusion_matrix_test_set[1,1] <- (confusion_matrix_test_set[1,1]+1)
  }
  
}








