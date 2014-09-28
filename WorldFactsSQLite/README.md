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


## Copyright
MIT

* The Icons are created with inkscape from the [AppIconTemplate.svg](http://kodira.de/2013/11/ios-7-app-icon-template-inkscape-svg-editor/). The globe is modified from [openclipart.org](https://openclipart.org/detail/121609/globe-by-jongo_jingaro-121609)