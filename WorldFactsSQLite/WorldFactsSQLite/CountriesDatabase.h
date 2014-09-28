//
//  MQTCountriesDb.h
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/31/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTCountriesDb : NSObject

+ (MQTCountriesDb *) db;
- (NSArray *) fetchCountries;
- (NSInteger) fetchDbVersion;

@end
