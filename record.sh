#!/bin/sh

arecord -D hw:1,0 -d 5 -f cd test.wav -c 2
wait
aplay test.wav

echo
echo "requesting IBM Watson for speech to text"
echo

KEY=$(cat apiKey)

RESULTS=$(curl -# -X POST -u "apikey:$KEY" \
   --header "Content-Type: audio/wav" \
   --data-binary @test.wav \
  "https://gateway-lon.watsonplatform.net/speech-to-text/api/v1/recognize" | \
jq -r '.results[]') 

echo $RESULTS | jq -r '.alternatives[]'

TRANSCRIPT=$(echo $RESULTS | jq -r '.alternatives[].transcript')

for word in $TRANSCRIPT
do
    if [ ${#word} -gt 3 ]; then
        echo "$word :: "$(ag -i $word commands.txt) >> temp 
    fi
done

cat temp
rm temp
