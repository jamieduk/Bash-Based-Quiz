#!/bin/sh
# (c)J~Net 2022
# jnet.sytes.net
# 
# ./quiz.sh
#
echo "Welcome To J~Net Quiz 2022"
sleep 1;
trap '' 2 3 6 15 18 20

# center() {
#   termwidth="$(tput cols)"
#   padding="$(printf '%0.1s' ={1..500})"
#   printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
# }

[ $(awk -F# '!(NF == 3)' <quiz.txt | wc -l) -gt 0 ] && printf "\nPlease maintain the # separator between your question, choices and answer fields in the quiz.txt file for the following line(s) : \n\n" && awk -F# '!(NF == 3)' <quiz.txt && echo && exit 1

[ -n "$(tail -c1 quiz.txt)" ] && printf '\n' >>quiz.txt

while true
do
clear
	echo
	printf "Type Your Full Name Please ( or Close Window to QUIT ) : "
	read Full_Name </dev/tty
	echo

# cnt=10;until (( $cnt == 0 )); do echo -ne "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bYour Quiz will start in $cnt seconds.... ";sleep 1;cnt=$(expr $cnt - 1);done;

cnt=5;until [ $cnt -eq 0 ]; do printf "\rYour Quiz will start in $cnt seconds.... ";sleep 1;cnt=$(expr $cnt - 1);done;

echo

clear
fin=0
score=0
total_questions=0
Quiz_Start_Time=$(date +"%s")
while IFS='#' read -r question choices answer
do 
    echo
    echo "==================================== QUIZ  ====================================" 
    echo
    echo $question
	echo
    echo $choices
	echo
	printf "Your Answer:"
	read student_answer </dev/tty
        answer=$(echo $answer | awk '{$1=$1;print}')
	if [ "$student_answer" = "$answer" ]; then
		score=`expr $score + 1`
	fi
	clear
		total_questions=`expr $total_questions + 1`
done <quiz.txt
Quiz_End_Time=$(date +"%s")
DIFF=$(($Quiz_End_Time-$Quiz_Start_Time))
Time_Taken="$(($DIFF / 3600 )) : $((($DIFF % 3600) / 60)) : $(($DIFF % 60))"
echo    
echo "Hi" $Full_Name","
echo    
echo "Your Score is               :  $score out of $total_questions"
echo "Your Score Percentage is    : " $(awk "BEGIN { printf \"%.2f\", $score/$total_questions*100 }")
echo "Time Taken By You (HH:MI:SS): " $Time_Taken
echo
printf "%-30s %-20s %-10s %-10s \n" "$Full_Name" "$score "/" $total_questions" $(awk "BEGIN { printf \"%.2f\", $score/$total_questions*100 }") "$Time_Taken" >> Students_Score.txt 
fin=1
        printf "Press Enter Key to Continue"
	read Enter_Key </dev/tty
# echo $Full_Name '\t' '\t' $score "/" $total_questions '\t' '\t' $(echo "scale=2; $score/$total_questions*100"|bc -l) "%" '\t' $Quiz_Start_Time '\t' $Quiz_End_Time >> Students_Score.txt

#fin=0
while [ $fin !=1 ]
do
 printf "%-30s %-20s %-10s %-10s \n" "$Full_Name" "$score "/" $total_questions" $(awk "BEGIN { printf \"%.2f\", $score/$total_questions*100 }") "$Time_Taken" >> Students_Score.txt 
 fin=1
done
done
