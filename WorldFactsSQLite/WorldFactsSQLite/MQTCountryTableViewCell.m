//
//  MQTCountryTableViewCell.m
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 9/1/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import "MQTCountryTableViewCell.h"

@implementation MQTCountryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
