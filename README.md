# BD6

A Client program for an application store.

## Synopsis

This project is a client program for an **Applications Store**, where the user has access to different functionnalities according to his rights: 

* normal user 
* developer 
* system administrator 

Considering the users already signed in and the database correctly in place (check **Requirements** following this section), the normal user can list applications and filter them according to some criterias, modify his personal information and look at the applications statistics, the developper can also add a new application he developped into the store, while the administrator gets some extra privilegies. 

## Requirements

* JVM installed
* Postgresql correctly installed on the machine
* `store.psql` correctly uploaded to Postgresql Server

Once Postgresql installed on your machine, you can create a new
database through `store.psql` file, by using the command:

    psql -U username -d database_name -f mydb.psql

## Usage

To Execute :

    chmod +x start.sh
    ./start.sh

The Terminal will ask you for login, as an example of normal user you can use

    Login: mattia@yahoo.it
    Password: passwd

Then just navigate through the menu showed by your terminal by
inserting the number of the choice and pressing the `Enter` key.
The informations will be shown in a well organised "tableau", and since the example database has been created from automatically generated data, it is normal if the applications names look strange to you.

To clean the project directory:

    chmod +x clean.sh
    ./clean.sh

## Output Example:


