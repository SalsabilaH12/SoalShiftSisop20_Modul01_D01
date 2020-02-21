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
