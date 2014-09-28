//
//  MQTCountryViewController.h
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/30/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface MQTCountryViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *area;
@property (nonatomic, weak) IBOutlet UILabel *area_sqmi;
@property (nonatomic, weak) IBOutlet UILabel *capital;
@property (nonatomic, weak) IBOutlet UILabel *continent;
@property (nonatomic, weak) IBOutlet UILabel *currency;
@property (nonatomic, weak) IBOutlet UILabel *phone;
@property (nonatomic, weak) IBOutlet UILabel *population;
@property (nonatomic, weak) IBOutlet UILabel *tld;

// will be passed from table view controller when the
// row is tapped
@property (nonatomic, strong) Country *country;

@end
