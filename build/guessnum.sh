#!/bin/sh
number=$(( RANDOM % 100 + 1 ))
tries=0
echo "Guess a number between 1 and 100"

while true; do
  read -p "Your guess: " guess
  tries=$((tries + 1))
  if [ "$guess" -lt "$number" ]; then
    echo "Too low!"
  elif [ "$guess" -gt "$number" ]; then
    echo "Too high!"
  else
    echo "Correct! You guessed it in $tries tries."
    break
  fi
done
