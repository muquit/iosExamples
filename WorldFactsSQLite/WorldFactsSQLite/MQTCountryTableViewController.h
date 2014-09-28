//
//  MQTCountryTableViewController.h
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/30/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountriesDatabase.h"

@interface MQTCountryTableViewController : UITableViewController

@property(strong,nonatomic) MQTCountriesDb *db;
@property(strong,nonatomic) NSArray *countries;
@property(strong,nonatomic) NSMutableDictionary *sections;
@property(nonatomic) NSInteger dbVersion;

@end
