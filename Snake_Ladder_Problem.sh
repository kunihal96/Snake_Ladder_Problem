#! /bin/bash

function rollDice()
{
   return $(( ( RANDOM % 6 )  + 1 ))
}

function getPlayOption()
{
    return $(( ( RANDOM % 3 )  + 1 ))
}

function playChance()
{
    currentPosition=$1  #current Position
   
    rollDice
    diceValue=$?
    echo diceValue $diceValue
   
    getPlayOption
    playOption=$?
    echo playOption $playOption
   
    case "$playOption" in  #When NoPlay(1) - Do nothing
    2)  ((currentPosition+=$diceValue)) #Ladder(2)
        if((currentPosition>$WinningPosition))
        then
            ((currentPosition-=$diceValue))
        fi
        ;;
    3)  ((currentPosition-=$diceValue)) #Snake(3)
        if((currentPosition<0))
        then
            currentPosition=0
        fi
        ;;
    esac
   
    return $currentPosition
}

Player1Position=0
WinningPosition=10
noOfMoves=0
while(true)
do
    ((noOfMoves++))
    playChance $Player1Position
    Player1Position=$?

    echo Position after Dice Roll $Player1Position
    if ((Player1Position >= $WinningPosition))
    then
        echo No of moves taken to win $noOfMoves
        break
    fi    
done
