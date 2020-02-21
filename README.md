# SoalShiftSisop20_Modul01_D01

1.  a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
    sedikit
    b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
    sedikit berdasarkan hasil poin a
    c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
    sedikit berdasarkan 2 negara bagian (state) hasil poin b
    
   
    # (a)
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


# (b)
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

# (c)
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

2.  (a) membuat sebuah script bash yang
    dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
    besar, huruf kecil, dan angka. 
    (b) Password acak tersebut disimpan pada file berekstensi
    .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
    (c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
    enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
    dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
    password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
    dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
    file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
    seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
    maka akan menjadi huruf b.) dan 
    (d) jangan lupa untuk membuat dekripsinya supaya
    nama file bisa kembali.
    
    if [[ $1 =~ ^[a-zA-Z]+$ ]]
then
random="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 28)" || true
echo $random > /home/linuxlite/$1.txt
else false
fi
© 2020 GitHub, Inc.

    
3.  [a] Maka dari
    itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
    "https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
    dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
    pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
    sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
    menjalankan script download gambar tersebut. Namun, script download tersebut hanya
    berjalan
    [b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
    gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
    gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
    sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
    identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
    antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
    Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
    selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
    kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. 
    [c] Maka dari itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
    gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
    sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
    dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
    Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
    dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
    Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
    ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
    merupakan hasil dari grep "Location".
    
    3a.
    #!/bin/bash
for n in $(seq 1 28)
do
wget -O pdkt_kusuma_$n https://loremflickr.com/320/240/cat -a wget.log
done

    3b.
    5 6-23/8 * * 0-5 /home/caca/soal3.sh

