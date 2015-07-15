#!/bin/bash

cmd="CLASSPATH=$(pwd)/postgresql-9.1-901.jdbc4.jar:${CLASSPATH}"
export $cmd

mkdir Objects

javac ./Sources/*.java -d Objects
cd Objects
java Main
