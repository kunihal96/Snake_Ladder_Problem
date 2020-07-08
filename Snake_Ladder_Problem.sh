#! /bin/bash

function rollDice()
{
   return $(( ( RANDOM % 6 )  + 1 ))
}

function getPlayOption()
{
    return $(( ( RANDOM % 3 )  + 1 ))
}

function playChance() #Take the current position input and roll dice and increment and decremnt poition accordingly
{
    currentPosition=$1  #current Position
   
    rollDice
    diceValue=$?
    #echo diceValue $diceValue
   
    getPlayOption
    playOption=$?
    #echo playOption $playOption
   
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

function announceWinner()
{
    gameEnd=0
    if (($player1Position == $WinningPosition))
    then
        echo Player 1 won
        ((gameEnd=1))
    fi
   
    if (($player2Position == $WinningPosition))
    then
        echo Player 2 won
        ((gameEnd=1))
    fi
   
    return $gameEnd
}

Player1Position=0
Player2Position=0
WinningPosition=10 #constant
noOfMoves=0
endgame=0

while [[ $endgame -lt 1 ]]
do
    ((noOfMoves++))  #increment moves
   
    playChance $player1Position #play the chance
    player1Position=$?  #overwrite with new position
   
    playChance $player2Position #play the chance
    player2Position=$?  #overwrite with new position
   
    echo Player Postions after move $noOfMoves : Player1 $player1Position - Player2 $player2Position
   
    announceWinner
    endgame=$?
done
