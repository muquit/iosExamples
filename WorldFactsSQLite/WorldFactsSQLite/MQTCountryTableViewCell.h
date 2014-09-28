//
//  MQTCountryTableViewCell.h
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 9/1/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQTCountryTableViewCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UILabel *countryNameLabel;
@property(weak,nonatomic) IBOutlet UILabel *countryCapitalLabel;
@property(weak,nonatomic) IBOutlet UILabel *countryPopulationLabel;


@end
