#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
# For restarting again the data
  echo "$($PSQL "TRUNCATE games, teams RESTART IDENTITY;")"

# For opening games.csv file, IFS=',' tells bash to seperate comma values, read is to assign each column to variables
  cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WGOALS OGOALS
  do
    if [[ $YEAR != "year" ]] # For skipping header at games.csv file
    then

      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'") # To check if winner is already existing

      if [[ -z $WINNER_ID ]]
      then
        $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
      fi

      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name ='$OPPONENT'") # To check if opponent is already existing

      if [[ -z $OPPONENT_ID ]]
      then
        $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi

      # Insert to games table
        $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
        VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WGOALS, $OGOALS)"
    
    fi
  done