#!/bin/bash

# Bu script Zimbrada bulunan gruplara tanimlanmis kapali hesaplari (aliaslari) bagli oldugu gruplardan cikartmak icin yapilmistir

# Varsa eski dosyalar siliniyor
/bin/rm -f /tmp/gdlm2.txt
/bin/rm -f /tmp/closed_acct2.txt

# Bu script Zimbrada bulunan gruplara tanimlanmis kapali hesaplari (aliaslari) bagli oldugu gruplardan cikartmak icin yapilmistir

# Mail gruplarinda bulunan kullanici listesi aliniyor
for i in `zmprov gadl` ; do

        zmprov gdlm $i |grep \@ |grep -v \# | awk '{print $1}' >> /tmp/gdlm2.txt

done;

# Yukarida alinan kullanici listesinden closed olan mail hesaplari ayri bir dosyaya aliniyor
# Bu islem 3 saat kadar surmektedir
for k in `cat /tmp/gdlm2.txt` ; do

sonuc=`zmprov ga $k |grep -i zimbraAccountStatus |awk '{print $2}'`

if [[ $sonuc == "closed" ]] || [[ $sonuc == "Closed" ]]

  then

        echo $k >> /tmp/closed_acct2.txt
  fi

done;


# Kapali kullanicilarin bagli oldugu gruplar bulunup bu gruplardan cikartilma islemi yapiliyor
for j in `cat /tmp/closed_acct2.txt` ; do

        for x in `zmprov -l gam $j |awk '{print $1}'` ; do zmprov rdlm $x $j; done;

done;
