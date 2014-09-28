//
//  MQTCountryViewController.m
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/30/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import "MQTCountryViewController.h"

@interface MQTCountryViewController ()

@end

@implementation MQTCountryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.country.country_name;
    //NSNumber *areaNumber = [NSNumber numberWithInt:[self.country.area intValue]];
    
    NSNumber *areaNumberSqKm = [NSNumber numberWithInteger:self.country.area_sqkm];
    NSString *areaText = [NSNumberFormatter localizedStringFromNumber:areaNumberSqKm numberStyle:NSNumberFormatterDecimalStyle];
    NSString *areaSqKm = [NSString stringWithFormat:@"%@ km2",areaText];
    self.area.text = areaSqKm;
    
    NSNumber *areaNumberSqMi = [NSNumber numberWithInteger:self.country.area_sqmi];
    areaText = [NSNumberFormatter localizedStringFromNumber:areaNumberSqMi numberStyle:NSNumberFormatterDecimalStyle];
    NSString *areaSqMi = [NSString stringWithFormat:@"%@ mi2",areaText];
    self.area_sqmi.text = areaSqMi;
    
    self.capital.text = self.country.capital;
    NSNumber *popNumber = [NSNumber numberWithInteger:self.country.population];
    self.population.text = [NSNumberFormatter localizedStringFromNumber:popNumber numberStyle:NSNumberFormatterDecimalStyle];
    self.capital.text = self.country.capital;
    self.continent.text = self.country.continent;
    self.currency.text = self.country.currency;
    self.phone.text = self.country.phone;
    self.tld.text = self.country.tld;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
