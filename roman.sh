#/bin/bash
# roman.sh

echo Giorgos Tsichlakis E14195 
echo INSERT 1 FOR ROMAN TO NUMERALS/INSERT 2 FOR NUMERALS TO ROMAN   
read option  # Η μεταβλητη option λαμβάνει δύο τιμές απο το χρήστη,
             # 1 ή 2 ώστε να επιλεχθέι η ανάλογη μετατροπή που θέλουμε,
             # πληκτρολογούμε τον αριθμό 1 για το αν θέλουμε μετατροπή
             # από ROMAN σε NUMERALS, πληκτρολογούμε τον αριθμό 2 για
             # μετατροπή από NUMERALS σε ROMAN
            

if [ $option == 1 ]  # Εφόσον ο χρήστης πληκτρολογήσει τον αριθμό 1,
then                 # επιθμεί μετατροπή από ROMAN σε NUMERALS 
     echo CONVERT ROMAN TO NUMERALS 
     echo INSERT THE VALUE,roman letters only
     read roman_mikra  # η τιμη που πληκτρολόγησε ο χρήστης,αποθηκεύεται στη
                       # μεταβλητή roman
                    
     roman=$(echo $roman_mikra | tr a-z A-Z) # Μεταρέπει τα γράμματα σε κεφαλαία

     decimal=$( # Υπολογίζει τους χαρακτήρες
         echo ${roman} |
         sed 's/CM/DCD/g' |
         sed 's/M/DD/g' |
         sed 's/CD/CCCC/g' |
         sed 's/D/CCCCC/g' |
         sed 's/XC/LXL/g' |
         sed 's/C/LL/g' |
         sed 's/XL/XXXX/g' |
         sed 's/L/XXXXX/g' |
         sed 's/IX/VIV/g' |
         sed 's/X/VV/g' |
         sed 's/IV/IIII/g' |
         sed 's/V/IIIII/g' |
         tr -d '\n' |
         wc -m
     )
	 # π.χ. MMXXI = M+M+X+X+I = 1000+1000+10+10+1 = 2021
	 

echo -----RESULT-----
echo ${roman} = ${decimal} # Το αποτέλεσμα της μετατροπής
fi 

if [ $option == 2 ] # Εφόσον ο χρήστης πληκτρολογήσει τον αριθμό 2,
then                # επιθμεί μετατροπή από NUMERALS σε ROMAN 
     echo CONVERT NUMERALS TO ROMAN 
     echo INSERT THE VALUE
     read decimal

	 num2roman() { # NUM
	 # Επιστρέφει τον αριθμό σε roman μορφή
			# input num
		output=""	# Clear output 
		len=${#decimal}	# Αρχικό μήκος-Αντίστροφη μέτρηση 
		
		roman_val() { # NUM one five ten
		# roman αλγόριθμος
			N=$1
			one=$2
			five=$3
			ten=$4
			out=""
			
			case $N in
			0)	out+=""	;;
			[123])	while [[ $N -gt 0 ]]
				do	out+="$one"
					N=$(($N-1))
				done
				;;
			4)	out+="$one$five"	;;
			5)	out+="$five"	;;
			[678])	out+="$five"
				N=$(($N-5))
				while [[ $N -gt 0 ]]
				do	out+="$one"
					N=$(($N-1))
				done
				;;
			9)	while [[ $N -lt 10 ]]
				do	out+="$one"
					N=$(($N+1))
				done
				out+="$ten"
				;;
			esac
			echo $out
		}
		
		while [[ $len -gt 0  ]]
		do	# 
			num=${decimal:0:1}
			# Προσθέτω τα γράμματα,ανάλογα με τη περίπτωση 
			case $len in
			1)	# 1
				output+="$(roman_val $num I V X)"
				;;
			2)	# 10
				output+="$(roman_val $num X L C)"
				;;
			3)	# 100
				output+="$(roman_val $num C D M)"
				;;
			*)	# 1000+
			
				num=${decimal:0:(-3)}
				while [[ $num -gt 0 ]]
				do	output+="M"
					num=$(($num-1))
				done
				# π.χ. 2021 = 1000+1000+10+10+1 = M+M+X+X+I = MMXXI
				;;
			esac
			decimal=${decimal:1} ; len=${#decimal}
		done
		echo $decimal=$output
	}
	num2roman $1
fi 