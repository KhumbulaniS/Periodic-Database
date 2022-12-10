#!/bin/bash
#Search for an element
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if [[ $1 ]]
then
  #if not a number
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT=$($PSQL " SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements e FULL JOIN properties p USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")
    else
      ELEMENT=$($PSQL " SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements e FULL JOIN properties p USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $1;")
    fi

    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT" | while read NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING BAR BOILING
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
    fi
else
  echo "Please provide an element as an argument."
fi
