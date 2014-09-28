//
//  MQTCountriesDb.m
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/31/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import "CountriesDatabase.h"

#import "Country.h"

#import "sqlite3.h"
#import "FMDatabase.h"

#define DB_FILE_NAME @"countries.sqlite"

@implementation MQTCountriesDb


static MQTCountriesDb *s_db;

+ (MQTCountriesDb *) db
{
    if (s_db == nil)
    {
        s_db = [[MQTCountriesDb alloc] init];
    }
    return s_db;
}

- (NSString *) documentsDirectoryPath
{
    //http://iphonedevelopmentblog.blogspot.com/2011/03/documents-directory-file-path-iphone.html
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

- (NSString *) dbFilePath
{
    NSString *docDirPath = [self documentsDirectoryPath];
    return [docDirPath stringByAppendingPathComponent:DB_FILE_NAME];
}

- (id) init
{
    self = [super init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbFilePath = [self dbFilePath];
    NSError *error;
    NSString *sqliteDb = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_FILE_NAME];
    if (![fileManager fileExistsAtPath:dbFilePath])
    {
        NSLog(@"sqlite db source path: %@", sqliteDb);
        NSLog(@"    sqlite db to path: %@", dbFilePath);
        BOOL rc = [fileManager copyItemAtPath:sqliteDb toPath:dbFilePath error:&error];
        if (!rc)
        {
            NSAssert1(0,@"Failed to copy database to document dir'%@'.", [error localizedDescription]);
        }
    }
    else
    {
        // check if versions differ
        FMDatabase *database = [FMDatabase databaseWithPath:dbFilePath];
        [database open];
        FMResultSet *s = [database executeQuery:@"SELECT version_no FROM version"];
        int oldVersion = 1;
        if ([s next])
        {
            oldVersion = [s intForColumnIndex:0];
        }
        [database close];
        
        database = [FMDatabase databaseWithPath:sqliteDb];
        [database open];
        s = [database executeQuery:@"SELECT version_no FROM version"];
        int newVersion = 1;
        if ([s next])
        {
            newVersion = [s intForColumnIndex:0];
        }
        [database close];
        
        NSLog(@"Old DB version: %i", oldVersion);
        NSLog(@"New DB version: %i", newVersion);
        if (newVersion > oldVersion)
        {
            NSLog(@"Replace OLD database");
            BOOL rc = [fileManager removeItemAtPath:dbFilePath error:&error];
            if (!rc)
            {
                NSAssert1(0,@"Failed to remove existing database'%@'.", [error localizedDescription]);
            }
            rc = [fileManager copyItemAtPath:sqliteDb toPath:dbFilePath error:&error];
            if (!rc)
            {
                NSAssert1(0,@"Failed to replace database'%@'.", [error localizedDescription]);
            }
        }
        
        
    }
    return self;
}
/*
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
*/

- (NSArray *) fetchCountries
{
    NSMutableArray *countries = [NSMutableArray array];
    FMDatabase *database = [FMDatabase databaseWithPath:[self dbFilePath]];
    [database open];
    
    FMResultSet *resultSet = [database executeQuery:@"SELECT * from country order by country_name"];
    while ([resultSet next])
    {
        Country *country = [[Country alloc] init];
        country.country_id = [resultSet intForColumn:@"id"];
        country.country_name = [resultSet stringForColumn:@"country_name"];
        country.capital = [resultSet stringForColumn:@"capital"];
        country.area_sqkm = [resultSet intForColumn:@"area_sqkm"];
        country.area_sqmi = [resultSet intForColumn:@"area_sqmi"];
        country.population = [resultSet intForColumn:@"population"];
        country.continent = [resultSet stringForColumn:@"continent"];
        country.tld = [resultSet stringForColumn:@"tld"];
        country.currency = [resultSet stringForColumn:@"currency"];
        country.phone = [resultSet stringForColumn:@"phone"];
        
        [countries addObject:country];
    }
    [database close];
    return countries;
}

- (NSInteger) fetchDbVersion
{
    FMDatabase *database = [FMDatabase databaseWithPath:[self dbFilePath]];
    [database open];
    FMResultSet *s = [database executeQuery:@"SELECT version_no FROM version"];
    int dbVersion = 1;
    if ([s next])
    {
        dbVersion = [s intForColumnIndex:0];
    }
    [database close];
    return dbVersion;
}

@end
