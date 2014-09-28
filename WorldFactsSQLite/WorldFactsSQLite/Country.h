//
//  Country.h
//  MyWorldFacts
//
//  Created by Muhammad Muquit on 8/30/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property(nonatomic)        NSUInteger country_id;
@property(strong,nonatomic) NSString *country_name;
@property(strong,nonatomic) NSString *capital;
@property(nonatomic)        NSUInteger area_sqkm;
@property(nonatomic)        NSUInteger area_sqmi;
@property(nonatomic)        NSUInteger population;
@property(strong,nonatomic) NSString *continent;
@property(strong,nonatomic) NSString *tld;
@property(strong,nonatomic) NSString *currency;
@property(strong,nonatomic) NSString *phone;

@end
