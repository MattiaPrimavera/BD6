# BD6

## Synopsis

This project is a client program for an **Applications Store**, where the user has access to different functionnalities according to his rights:

* normal user
* developer
* system administrator

Considering the users already signed in to the store and the database correctly in place (check **Requirements** following this section), the normal user can list applications and filter them according to some criterias, modify his personal informations and look at the applications statistics, the developer can also add a new application he developped to the store, while the administrator gets some extra privilegies.

## Requirements

* JVM installed
* Postgresql correctly installed on the machine
* `store.psql` correctly uploaded to Postgresql Server

Once Postgresql installed on your machine, you can create a new
database through `store.psql` file, by using the command:

	psql -U username -d database_name -f mydb.psql

## Usage

To execute:

	sudo chmod +x start.sh
	./start.sh

The terminal will ask you for login, as an example of normal user you can use:

	Login: mattia@yahoo.it
	Password: passwd
	
To log as a Developer try with:
	
	Login: mattia@yahoo.com
	Password: diderot

To log as an Administrator try with:
	Login: b
	Password: b

Then just navigate through the menu showed by your terminal by inserting the number of the choice and pressing the `Enter` key.
The informations will be shown in a well organised table, and since the example database has been created from automatically generated data, it is normal if the applications names look strange to you.

To clean the project directory:

	chmod +x clean.sh
	./clean.sh
