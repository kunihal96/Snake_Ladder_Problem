# !/bin/bash

echo snake ladder problem solved here


function rollDice()
{
  return $(( ( RANDOM % 6 )  + 1 ))
}

Player1Position=0
