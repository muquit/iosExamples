//
//  MQTAboutViewController.h
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 9/1/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface MQTAboutViewController : UIViewController

@property(weak,nonatomic) IBOutlet UILabel *dbVersionLabel;
@property (strong,nonatomic) NSString *dbVersion;

@end
