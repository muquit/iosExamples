Create sql statements from countries.plist from the project WorldFacts

https://github.com/kharrison/CodeExamples/tree/master/WorldFacts
The original project uses CoreData. I am going to use SQLite and 
FmDb.

The sql statements can be used to create SQLite data base

 $ ruby plist2sql countries.plist > countries.sql
 $ sqlite3 countries.sqlite
sqlite> .read countries.sql
sqlite> .schema
sqlite> select * from country;
sqlite> select count(*) from country;
sqlite> .exit
--
muquit@muquit.com
Aug-30-2014