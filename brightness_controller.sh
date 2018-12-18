#!/bin/bash

#this are parameters !
displayNumber=$1; #1/2
brightnessDirection=$2; #up/down
yellowLevel=$3; #0.0 to 1.0

if [ -z $yellowLevel ]; then
	yellowLevel=0.5;
fi

if [ $brightnessDirection = "u" ]; then
	brightnessDirection="up"
elif [ $brightnessDirection = "d" ]; then
	brightnessDirection="down"
fi

sed_line=$displayNumber"p";

brightness_initial=$(xrandr --verbose | grep Brightness | sed -n $sed_line | grep -o '[0-9.]*');

if [ $brightnessDirection = "up" ]; then
	brightness_change=0.10;
	brightness_output=`echo $brightness_initial+$brightness_change | bc`;
elif [ $brightnessDirection = "down" ]; then
	brightness_change=0.07;
	brightness_output=`echo $brightness_initial-$brightness_change | bc`;
else
	echo "Bad direction: " $brightnessDirection;
fi


if [[ "$(echo "${brightness_output} > 1.00" | bc)" -eq 1 ]]; then
	brightness_output=1.00;
elif [[ "$(echo "${brightness_output} < 0.00" | bc)" -eq 1 ]]; then
	brightness_output=0.1;
fi

gamma_current=$(xrandr --verbose | grep Gamma | grep -o '[0-9][0-9:.]*' | sed -n $sed_line)
# gamma_current="1.0:1.0:1.0"

echo "gamma: "$gamma_current

var=$(xrandr --verbose | grep '.*\sconnected' | awk '{print $1}' ); 
chooseGroupFromRegex () {
	gawk 'match($0,/'$1'/, ary) {print ary['${2:-'$displayNumber'}']}'; 
}
displayName=$(echo $var | chooseGroupFromRegex '(.+)\s(.+)' $displayNumber) 

xrandr --output $displayName --brightness $brightness_output --gamma 1.0:1.0:$yellowLevel;
# 1.0:1.0:0.8
