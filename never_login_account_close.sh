#!/bin/bash

#Bu script hic login olmamis kullanici hesaplarini kapatir.

#Onceden olusturulmus dosya siliniyor.

/usr/bin/rm -f /tmp/never_login_accts.txt

#Sistem kullanicilari haric hic login olmamis kullanici hesaplari aliniyor
zmaccts | grep @ | grep never |awk '{print $1}' |grep -v "admin" |grep -v "galsync" |grep -v "ham." |grep -v "spam." |grep -v "virus-quarantine." >> /tmp/never_login_accts.txt

for i in `cat /tmp/never_login_accts.txt` ; do

#İlgili hesaplar kapatiliyor.
  zmprov ma $i zimbraAccountStatus closed

done;

#Durum ozet bilgisi yazdiriliyor
echo `wc -l /tmp/never_login_accts.txt | awk '{print $1}'` tane hesap kapatildi.

