#!/bin/bash
# db_init.sh - Initializes or reinitializes the exercise database.

init_db() {
	echo "Initializing Database:"
	sqlite3 "$name.db" < "$name.sql" -echo
	if [ ! "$?" -eq 0 ] ; then
		echo "ERROR - Unable to initialize $name.db with $name.sql"
		return -1
	fi
	echo "Done"
}

reinit_db() {
	rm -f "$db"
	init_db
	if [ ! "$?" -eq 0 ] ; then
		return -1
	fi
}

name="${PWD##*/}"
usage="Usage: $(basename $0)"
db="$name.db"

if [ ! -f "$name.sql" ] ; then
	echo "ERROR - Could not find $name.sql"
	exit -1
fi

loop=1
if [ -a "$db" ] ; then
	while [ "$loop" -eq 1 ] ; do
		read -p "Database $db exists; Do you want to reinitialize? Type Y/n: " answer
		if [ "$answer" == "Y" ] ; then
			reinit_db
			loop=0
		elif [ "$answer" == "n" ] ; then
			loop=0
			echo "You chose not to reinitialize the database."
		else
			echo "ERROR - Invalid Input. Please enter Y or n."
		fi
	done
else
	init_db
fi
