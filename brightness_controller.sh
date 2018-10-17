display_number=$1; #1/2
brightness_direction=$2; #up/down


if [ $brightness_direction = "u" ]; then
	brightness_direction="up"
elif [ $brightness_direction = "d" ]; then
		brightness_direction="down"
fi

sed_line=$display_number"p";

echo "here"
echo $sed_line;

brightness_initial=$(xrandr --verbose | grep Brightness | sed -n $sed_line | grep -o '[0-9.]*');

echo $brightness_initial;

brightness_change=0.10;
if [ $brightness_direction = "up" ]; then
	brightness_output=`echo $brightness_initial+$brightness_change | bc`;
elif [ $brightness_direction = "down" ]; then
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


# gamma_current=$(xrandr --verbose | grep Gamma | grep -o '[0-9][0-9:.]*' | sed -n $sed_line)
# gamma_current="1.0:1.0:1.0"

# echo "gamma: " $gamma_current

display_name=DP-$display_number
xrandr --output $display_name --brightness $brightness_output --gamma 1.0:1.0:0.8;
