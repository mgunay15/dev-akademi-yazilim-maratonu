# dev-akademi-yazilim-maratonu
Bu projede datalari kullanarak hangi kullanicinin hangi id'li reklama tiklayacagini ongorebilmek icin bir ml modeli gelistirdim.
Projeyi R'da yazdim. Son anda cikan sorunlar(bazi degerlerin Nan gelmesi) yuzunden sonuca ulasamadim fakat confusion_matrix_test_set'i
print ettigimizde bize modelin dogrulugunu olcen bir confusion matrix dondurmesi gerekiyor. Datalarin 80% i ile modelimi train
ettim, 20% si ile de test ettim. Confusion matrix'i bu testler dogrultusunda olusturdum .Bu matrix 2x2 boyutunda ve ilk satiri
aslinda degeri clicked olan rowlarin benim modelimde nasil degerlendirildigini gosteriyor. Mesela ben clicked bir reklami clicked
olarak dogru labelladiysam bu matrixin [1][1]'deki degerini arttiriyor. Eger impression olarak yanlis classify ettiysem de matrixin
[1][2] degeri bir artiyor. Sonuc olarak model ne kadar dogru kurulmussa confusion matrixin dagilimi o kadar diagonalinda toplaniyor.
Bu projeyle, verilen kisi bilgileri ve reklam id'si dogrultusunda bu kisinin bu reklama clickleyip clicklemeyecegini ongormeyi amaclayan
bir ml modeli yapmaya calistim. Boylelikle farkli kisiler icin en dogru sekilde reklam onerisi yapilabilir
