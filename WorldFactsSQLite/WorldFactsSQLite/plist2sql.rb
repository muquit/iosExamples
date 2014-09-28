#!/usr/bin/env ruby

########################################################################
# Create sql statements from countries.plist from the project
# https://github.com/kharrison/CodeExamples/tree/master/WorldFacts
#
# The original project uses Core Data, I am goig to use SQLite and Fmdb
# To insert data:
#
#   $ ruby plist2sql countries.plist > countries.sql
#   $ sqlite3 countries.sqlite
#   sqlite> .read countries.sql
#   sqlite> .exit
#
# muquit@muquit.com Aug-30-2014 
########################################################################
begin
  ME = $0
  if ARGV.length != 1
    puts <<EOF
    USAGE: #{ME} /path/countries.plist
EOF
    exit
  end
  countries_plist = ARGV[0]
  f = File.open(countries_plist)
    puts <<EOF
-- 
-- Created from countries.plist file of the project
-- WordFacts https://github.com/kharrison/CodeExamples/tree/master/WorldFacts
-- muquit@muquit.com Aug-30-2014 
---
DROP TABLE IF EXISTS version;
CREATE TABLE version
(
    id INTEGER PRIMARY KEY UNIQUE,
    version_no INTEGER,
    date DATE
);

DROP TABLE IF EXISTS country;
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
INSERT INTO version
( 
    version_no,
    date
)
VALUES
(
    1,
    date('now')
);
EOF

  while (line = f.gets)
    line.chomp! if line
    next if line == '('
    next if line == ')'
    line = line.gsub(/\{/,'')
    line = line.gsub(/\}/,'')
    a = line.split(";")
    name = a[0].split('=')[1]
    capital = a[1].split('=')[1]
    area = a[2].split('=')[1]
    population = a[3].split('=')[1]
    continent = a[4].split('=')[1]
    tld = a[5].split('=')[1]
    currency = a[6].split('=')[1]
    phone = a[7].split('=')[1]

    # do not convert to int right away, it will
    # truncate scientific numbers 
    area_sqkm = area.gsub(/"/,'').to_f.to_i
    area_sqmi = (area_sqkm * 0.38610).to_f.to_i

    puts <<EOF
INSERT INTO country
(
    country_name,
    capital,
    area_sqkm,
    area_sqmi,
    population,
    continent,
    tld,
    currency,
    phone
)
VALUES
(
  #{name},
  #{capital},
  #{area_sqkm},
  #{area_sqmi},
  #{population},
  #{continent},
  #{tld},
  #{currency},
  #{phone}
);
EOF
  end
    f.close
rescue => e
  puts "ERROR: #{e}"
end
