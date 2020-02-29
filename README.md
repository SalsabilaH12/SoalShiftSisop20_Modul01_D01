# SoalShiftSisop20_Modul01_D01

## SOAL 1
**A. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit)           paling sedikit**
    
Code :
```

printf ">> Nomor 1a:\n"
awk -F ',' '
FNR > 1 {a[$13] = a[$13] + $21}
END {
    max=9999999999;
    region="";
    for (var in a) {
        if (max > a[var]) {
            max = a[var];
            region=var;
        }
    }
    print region, max;
}' Sample-Superstore.csv

```
-	-F, adalah argumen untuk memberitahu awk bahwa pembatas tiap kolom dari data yang kita miliki adalah koma (,)
-	FNR > 1 agar tidak perlu menggunakan row paling atas
-	{a[$13]=a[$13]+$21} untuk membuat array berdasarkan Region dan menambahkan Profitnya
-	END { max=9999999999; region=""; for (var in a) { if (max > a[var]) { max = a[var]; region=var; } } print region, max; } perulangan yang membandingkan satu per satu lalu ambil yang paling kecil
-	Sample-Superstore.csv nama file yang dijadikan input
Pada intinya kode di atas bekerja dengan cara membuat array berdasarkan State dan menambahkan Profitnya. Setelah pencarian selesai, dicari region dengan profit terkecil pada blok END.

**B. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
    sedikit berdasarkan hasil poin a**

Code :
```

printf "\n>> Nomor 1b:\n"
awk -F ',' '{
    if($13 == "Central") { 
        state[$11] = state[$11] + $21;
    }
}
END {
    for (var in state) {
        print state[var] " " var;
    }
}' Sample-Superstore.csv | sort -n | awk 'NR <= 2 {print $2}'

```

- ($13 == ”Central”) memeriksa apakah dalam record-record di kolom tersebut terdapat record yang bernama Central
- { state[$11] = state[$11] + $21; } untuk membuat array berdasarkan State dan menambahkan Profitnya
- END { for (var in state) { print state[var] " " var; } }' Sample-Superstore.csv . Ini disimpan menggunakan array dengan indeks state.
- Untuk mengurutkan dapat menggunakan command sort -n (numerical) dan
- untuk mencetak hanya dua baris menggunakan awk NR <=2.
Setelah didapatkan region pada poin (a), selanjutnya adalah menjumlahkan state. Ini disimpan menggunakan array dengan indeks state. Kemudian hasilnya diurutkan berdasarkan print dua teratas.

**C. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
    sedikit berdasarkan 2 negara bagian (state) hasil poin b**
    
Code:
```

printf "\n>> Nomor 1c:\n"

printf "State Illinois : \n"
awk -F ',' '{
    if ($13 == "Central") {
        if ($11 == "Illinois") {
            product[$17] += $21;
        }
    }
}
END {
    for (var in product) {
        print product[var], var;
    }
}' Sample-Superstore.csv | sort -n | awk 'NR <=10 {print $2}'

printf "\nState Texas : \n"
awk -F ',' '{
    if ($13 == "Central") {
        if ($11 == "Texas") {
            product[$17] += $21;
        }
    }
}
END {
    for (var in product) {
        print product[var], var;
    }
}' Sample-Superstore.csv | sort -n | awk 'NR <=10 {print $2}'

```
- Prinsipnya sama dengan 1(b) tadi. Setelah didapatkan tiga state teratas, kemudian dicetak tiga Product teratas berdasarkan tiap state. Cara kerjanya mirip dengan Soal 1(b). -g sama seperti -n namun bukan string melainkan command.

## SOAL 2  
**A. membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.** 

**B. Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.**

 Code:
 ```
 
    if [[ $1 =~ ^[a-zA-Z]+$ ]]
then
random="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 28)" || true
echo $random > /home/linuxlite/$1.txt
else false
fi
© 2020 GitHub, Inc.

```

- /dev/urandom adalah file spesial dalam UNIX sebagai pseudo-RNG
- tr -dc 'a-zA-Z0-9'Perintah ini berfungsi untuk menseleksi hasil output random dengan  menghasilkan karakter alfanumerik yang menghapus semua karakter (-d) kecuali (-c) a-z, A-Z, dan 0-9.
- head -c28 membuat karakter yang dihasilkan sebatas 28 karakter.
- Perintah yang telah disebutkan diatas akan disimpan ke dalam file yang dimana setelah kita input namanya, akan disimpan sebagai argumen ($1) dan akan diproses.

 **C.  Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.) dan**
 
 Code:
 ```
 
 #!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")

if [ $input ]
then
	thisfolder=`pwd`
	this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
	arraya=({a..z})
	arrayA=({A..Z})
    hour=$(date +"%H")
		hour2=$(($hour-1))
	change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}

	filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})
	echo $this > "$filename".txt
	echo "random password telah disimpan ke dalam file bernama" $input".txt yang telah di enkripsi :)"
else
	echo "argumen yang diinputkan dan HANYA berupa alphabet."
fi

```

-	input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$") 
- Membuat variabel input yang menyimpan argumen pertama yang hanya berupa alfabet sebelum tanda titik (.), argumen ini nantinya yang akan di enkripsi dan digunakan sebagai nama file.
-	thisfolder=`pwd`
	this=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
	arraya=({a..z})
	arrayA=({A..Z})
		hour=$(date +"%H")
		hour2=$(($hour-1))
	change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}
- Berdasarkan soal a, membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka. Lalu berdasarkan waktu file akan di enkripsi.
-	filename=$(echo "$input" | tr '[A-Z]' {$change3-ZA-$change4} | tr '[a-z]' {$change1-za-$change2})
- Berdasarkan soal c, mengenkripsi nama file yang diinputkan dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23). Dibuat sebuah variabel filename yang menyimpan isi dari variabel input yang telah dirubah menggunakan perintah tr. Perintah ini akan merubah susunan sebuah kata berdasarkan urutan huruf yang diinputkan setelahnya.
-	echo $this > "$filename".txt
Berdasarkan soal b, Password acak tersebut disimpan pada file berekstensi.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
-	echo "argumen yang diinputkan dan HANYA berupa alphabet."
Selain kondisi didalam if tersebut, akan meng output kalimat tersebut.

**D. jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.**

 Code:
 ```
 
 #!/bin/bash

input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$")

now=`pwd`
if [ $input ]
then

	for target in "${@}"; do
        inode=$(stat -c '%i' "${target}")
        fs=$(df  --output=source "${target}"  | tail -1)
        crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | awk '{print $4}' | awk -F ':' '{print $1}')
	done
  arraya=({a..z})
	arrayA=({A..Z})
    hour=$crtime
	  hour2=$(($hour-1))
  change1=${arraya[hour]}
	change2=${arraya[hour2]}
	change3=${arrayA[hour]}
	change4=${arrayA[hour2]}

  filename=$(echo "$input" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]')
	echo "apakah Anda ingin mendekripsi nama file yang telah dienkripsi" $input".txt ->" $filename.txt"?"  "Ya"

	read answer
	if [[ $answer == "Ya" ]]
	then
		mv "${now}/$input.txt" "${now}/$filename.txt"
		echo "Yeay.. file" $input".txt telah berhasil di-rename menjadi" $filename".txt"
	fi
else
	echo "argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi."
fi

```

-	input=$(echo $(echo $1 | awk -F '.' '{print $1}') | grep -i "^[a-z]\+$") 
Dibuat variabel input untuk mengecek argumen, sama seperti penjelasan pada soal A dan juga apabila tidak sesuai akan mengeluarkan argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi.
```
for target in "${@}"; do
       inode=$(stat -c '%i' "${target}")
       fs=$(df  --output=source "${target}"  | tail -1)
       crtime=$(sudo debugfs -R 'stat <'"${inode}"'>' "${fs}" 2>/dev/null | grep -oP 'crtime.*--\s*\K.*' | awk '{print $4}' | awk -F ':' '{print $1}')
```
-	Kemudian dibuat sebuah looping untuk menemukan waktu file dibuat, lebih tepatnya jam file yang akan di dekripsi dibuat. Di sini saya memanfaatkan inode dari file tersebut untuk mencari create time-nya. Akan tetapi untuk mendapatkannya, diperlukan password dari root karena perintahnya menggunakan sudo.
-	arraya=({a..z}) arrayA=({A..Z}) hour=$crtime hour2=$(($hour-1)) change1=${arraya[hour]} change2=${arraya[hour2]} change3=${arrayA[hour]} change4=${arrayA[hour2]} 
-	Membuat array alfabet, variabel hour dan variabel change seperti soal A yang sebelumya dijelaskan.
-	filename=$(echo "$input" | tr {$change3-ZA-$change4} '[A-Z]' | tr {$change1-za-$change2} '[a-z]') 
-	Kembali dibuat sebuah variabel filename yang menyimpan isi dari variabel input yang telah dirubah menggunakan perintah tr. Perintah ini akan merubah susunan sebuah kata berdasarkan urutan huruf yang diinputkan setelahnya. Ini akan membuat variabel filename berisi nama file yang telah didekripsi.
-	echo "apakah Anda ingin mendekripsi nama file yang telah dienkripsi" $input".txt ->" $filename.txt"?"  "Ya"
```	
    read answer
if [[ $answer == "Y" ]]
then
	mv "${now}/$input.txt" "${now}/$filename.txt"
	echo "Yeay.. file" $input".txt telah berhasil di-rename menjadi" $filename".txt"
fi
else
echo "argumen yang diinputkan dan HANYA berupa alphabet dari nama file yang telah di enkripsi."
Fi
```
-	Lalu ditampilkan sebuah pertanyaan apakah ingin mengubah nama file yang telah dienkripsi kembali ke aslinya. Jika menginput Ya maka nama file akan dirubah.

## SOAL 3 
**A. Maka dari itu, kalian mencoba membuat script untuk mendownload 28 gambar dari "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2, pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk menjalankan script download gambar tersebut. Namun, script download tersebut hanya berjalan**

Code:
```

    #!/bin/bash
for n in $(seq 1 28)
do
wget -O pdkt_kusuma_$n https://loremflickr.com/320/240/cat -a wget.log
done

```
- -a untuk menambahkan 
- -o untuk mengubah nama file menjadi “pdkt_kusuma_$n” 
- $n adalah penomoran (iterasi) -> sebanyak 28 gambar saat mendownload gambar.
- Menggunakan fungsi wget untuk langsung mendownload file yang ada di website dan wget.log untuk menyimpan file yang sudah didownload


**B. Setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi.**
 
 Code:
 ```
 
    5 6-23/8 * * 0-5 /home/caca/soal3.sh
    
 ```
 
-	5 adalah menit ke-5
-	6-23/8 adalah setiap 8 jam dari pukul 06.00-23.00
-	0-5 adalah hari minggu - jumat (setiap hari kecuali hari sabtu)

 
**C. Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201). Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253). Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya merupakan hasil dari grep "Location".**
    
Code:
```

#!/bin/bash
now=`pwd`
for n in $(seq 1 28)
do
wget -O pdkt_kusuma_$n https://loremflickr.com/320/240/cat -a wget.log
nm=$(grep "Location" wget.log | tail -1 | awk '{print $2}')
 echo $nm

 if [[ ! $(ls ${now} | grep "Location.log") && ! $(ls ${now} | grep "duplicate") && ! $(ls ${now} | grep "kenangan") ]]
 then
  touch Location.log
  mkdir duplicate kenangan
 fi

if [[ $(grep "$nm" Location.log) ]]
 then
  echo tes1
  count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  if [[ $count1 ]]
  then
   mv "${now}/pdkt_kusuma_$n" "${now}/duplicate/duplicate_$(($count1+1))"
  else
   mv "${now}/pdkt_kusuma_$n" "${now}/duplicate/duplicate_1"
  fi
 else
  echo tes2
  count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1)

  if [[ $count2 ]]
                then
                        mv "${now}/pdkt_kusuma_$n" "${now}/kenangan/kenangan_$(($count2+1))"
  else
                        mv "${now}/pdkt_kusuma_$n" "${now}/kenangan/kenangan_1"
  fi

  echo $tes1 >> Location.log
 fi


done

```

-	if [[ $(grep "$name1" Location.log) ]] Mengecek jika ditemukan lokasi yang sama antara wget.log dengan Location.log 
-	count1=$(ls duplicate/ |awk -F '_' '{print $2}' | sort -rn | head -1) membuat variabel count1 yang berisi angka terakhir pada gambar file duplicate.
-	if [[ $count1 ]] Jika tidak memiliki nilai maka nama filenya berubah menjadi duplicate_1 dan dipindahkan juga ke folder duplicate.
-	count2=$(ls kenangan/ |awk -F '_' '{print $2}' | sort -rn | head -1) menyimpan angka terakhir pada gambar file kenangan.
-	if [[ $count2 ]] jika tidak memiliki nilai maka nama filenya berubah menjadi kenangan_1 dan dipindahkan juga ke folder kenangan.
-	cat wget.log >> wget.log.bak Memindahkan isi file wget.log ke file wget.log.bak tanpa menghapus data pada file wget.log.bak.
-	 wget.log Menghapus isi file wget.log


