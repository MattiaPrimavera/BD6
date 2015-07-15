# BD6

A client program for an Online Store

## Requirements

* JVM installed
* Postgresql correctly installed on the machine
* `store.psql` correctly uploaded to Postgresql Server

## Usage

Démarrage :

    chmod +x start.sh
    ./start.sh

Nettoyage :

    chmod +x clean.sh
    ./clean.sh

## Remarks

The Terminal will ask you for login, as an example you can use

    Login: mattia@yahoo.it
    Password: passwd

Then just navigate through the menu showed by your terminal by
inserting the number of the choice and pressing the `Enter` key.


Once Postgresql installed on your machine, you can create a new
database through `store.psql` file, by using the command:

    psql -U username -d database_name -f mydb.psql
