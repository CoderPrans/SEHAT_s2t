#!/bin/bash

arecord -D hw:1,0 -d 5 -f cd test.wav -c 1
wait
aplay test.wav

echo
echo "requesting IBM Watson for speech to text"
echo

KEY=$(cat apiKey)

RESULTS=$(curl -X POST -u "apikey:$KEY" \
   --header "Content-Type: audio/wav" \
   --data-binary @test.wav \
   "https://gateway-lon.watsonplatform.net/speech-to-text/api/v1/recognize" | \
jq -r '.results[]') 

echo $RESULTS | jq -r '.alternatives[]'

TRANSCRIPT=$(echo $RESULTS | jq -r '.alternatives[].transcript')

for word in $TRANSCRIPT
do
    #if [ ${#word} -gt 3 ]; then
    #    echo "$word :: "$(ag -i $word commands.txt) >> temp 
    if [ $word == "forward" ]; then
	echo "going forward"
	python3 motor_forward.py
    elif [ $word == "backward" ]; then
	echo "going backward"
	python3 motor_backward.py
    elif [ $word == "turn right" ]; then
	echo "turning right"
	python3 motor_clockwise.py
    elif [ $word == "turn left" ]; then
	echo "turning left"
	python3 motor_anticlockwise.py
    fi
done

#cat temp
#rm temp
