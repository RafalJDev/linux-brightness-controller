displayNumber=$1; #1/2
brightness_direction=$2; #up/down

  #choosing display 
  var=$(xrandr --verbose | grep '.*\sconnected' | awk '{print $1}' ); 
  chooseGroupFromRegex () {
    gawk 'match($0,/'$1'/, ary) {print ary['${2:-'$displayNumber'}']}'; 
  }  
  displayName=$(echo $var | chooseGroupFromRegex '(.+)\s(.+)' $displayNumber) 


if [ $brightness_direction = "u" ]; then
	brightness_direction="up"
elif [ $brightness_direction = "d" ]; then
		brightness_direction="down"
fi

sed_line=$displayNumber"p";

echo "here"
echo $sed_line;

brightness_initial=$(xrandr --verbose | grep Brightness | sed -n $sed_line | grep -o '[0-9.]*');

echo $brightness_initial;

if [ $brightness_direction = "up" ]; then
	brightness_change=0.10;
	brightness_output=`echo $brightness_initial+$brightness_change | bc`;
elif [ $brightness_direction = "down" ]; then
	brightness_change=0.06;
	brightness_output=`echo $brightness_initial-$brightness_change | bc`;
else
	echo "Bad direction: " $brightness_direction;
fi

echo $brightness_output;

if [[ "$(echo "${brightness_output} > 1.00" | bc)" -eq 1 ]]; then
	brightness_output=1.00;
elif [[ "$(echo "${brightness_output} < 0.00" | bc)" -eq 1 ]]; then
	brightness_output=0.1;
fi

echo $brightness_output;


 gamma_current=$(xrandr --verbose | grep Gamma | grep -o '[0-9][0-9:.]*' | sed -n $sed_line)
 # gamma_current="1.0:1.0:1.0"

echo "gamma: "$gamma_current

xrandr --output $displayName --brightness $brightness_output --gamma 1.0:1.0:0.9;
# 1.0:1.0:0.8
