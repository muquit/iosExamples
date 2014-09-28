## WorldFactsSQLite
A port of [WorldFacts](https://github.com/kharrison/CodeExamples/tree/master/WorldFacts)  to use SQLite and [FMDB](https://github.com/ccgus/fmdb). The original [WorldFacts](https://github.com/kharrison/CodeExamples/tree/master/WorldFacts) uses [Core Data](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/cdProgrammingGuide.html).

I converted data from countries.plist to SQL statements and created the
countries.sqlite.

From this app you can learn:

* Read data from SQLite with ease using FMDM.

* If version number is incremented in the the version table, the database in the document directory will be overwritten. A simple techique to update read only database with new version of app.

* UITableView with dynamic sections and indexes.

* Filtered search.

Tested with iOS 7.1 and 8.0

In order to run/play, please open **WorldFactsSQLite.xcworkspace** in xcode (NOT WorldFactsSQLite.xcodeproj, because this project uses FMDB as [CocoaPods](http://cocoapods.org/))

## Schema

    $ sqlite3 countries.sqlite 
    SQLite version 3.7.13 2012-07-17 17:46:21
    Enter ".help" for instructions
    Enter SQL statements terminated with a ";"
    sqlite> .schema
    CREATE TABLE country
    (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        country_name TEXT UNIQUE,
        capital TEXT,
        area_sqkm INTEGER,
        area_sqmi INTEGER,
        population INTEGER,
        continent TEXT,
        tld TEXT,
        currency TEXT,
        phone TEXT
    );
    CREATE TABLE version
    (
        id INTEGER PRIMARY KEY UNIQUE,
        version_no INTEGER,
        date DATE
    );

    sqlite> sqlite> select count(*) from country;
    252
    
    sqlite> select version_no from version;
    9
    
## Screenshots

### Main View
![main screen](screenshots/wf1.png)

### Search View
![search view](screenshots/wf2.png)

### Detail View
![detail view](screenshots/wf3.png)

## Copyright
MIT

* The Icons are created with [inkscape](http://www.inkscape.org/) from the [AppIconTemplate.svg](http://kodira.de/2013/11/ios-7-app-icon-template-inkscape-svg-editor/). The globe is modified from [openclipart.org](https://openclipart.org/detail/121609/globe-by-jongo_jingaro-121609)
