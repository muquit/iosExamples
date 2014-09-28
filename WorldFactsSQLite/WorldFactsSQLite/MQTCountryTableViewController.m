//
//  MQTCountryTableViewController.m
//  WorldFactsSQLite
//
//  Created by Muhammad Muquit on 8/30/14.
//  Copyright (c) 2014 muquit.com. All rights reserved.
//

#import "MQTCountryTableViewController.h"
#import "MQTCountryViewController.h"
#import "MQTCountryTableViewCell.h"
#import "MQTAboutViewController.h"
#import "CountriesDatabase.h"
#import "Country.h"

@interface MQTCountryTableViewController () <UISearchBarDelegate,UISearchDisplayDelegate>

@property(strong,nonatomic) NSNumberFormatter *decimalFormatter;

@end

@implementation MQTCountryTableViewController
{
    NSArray *searchResults;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = NSLocalizedString(@"World", @"World");
    
    // load all the countries from SQLite database
    self.countries = [[MQTCountriesDb db] fetchCountries];
    self.dbVersion = [[MQTCountriesDb db] fetchDbVersion];
    
    self.sections = [[NSMutableDictionary alloc] init];
    
    // construct sections.
    // key is the first character of the countries
    // values are the array of countries starting with the first character
    // can be explained easily with ruby hash:
    // sections = {}
    // sections["B"] = ["Bahamas","Bahrain","Bangladesh"]
    // sections["Z"] = ["Zambia", "Zimbabwe"]
    
    // first create the dictionary with key as first character of each country
    // value is an empty array
    for (id element in self.countries)
    {
        
        Country *c = element;
        NSString *country_name = c.country_name;
        NSString *firstChar = [country_name substringToIndex:1];
        if ([self.sections objectForKey:firstChar] != nil)
        {
            // key found
        }
        else
        {
            // add the key. value is an array which will have the countries
            // starting with the same chaharacter
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:firstChar];
        }
    }
    
    // for each key, add the countries as array
    for (id element in self.countries)
    {
        Country *c = element;
        NSString *country_name = c.country_name;
        NSString *x = [country_name substringToIndex:1];
        [[self.sections objectForKey:x] addObject:element];
    }
    /*
    for (NSString *key in [self.sections allKeys])
    {
        NSLog(@"key: %@", key);
        NSArray *countries = [self.sections objectForKey:key];
        for (id element in countries)
        {
            Country *c = element;
            NSString *country_name = c.country_name;
            NSLog(@"   %@",country_name);
        }
        
    }
     */
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MQTSegueShowCountry"])
    {
        Country *country = nil;
        if (self.searchDisplayController.isActive)
        {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:sender];
            country = [searchResults objectAtIndex:indexPath.row];
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            NSDictionary *dict = [[self.sections valueForKey:[[[self.sections allKeys]                         sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.         section]] objectAtIndex:indexPath.row];
            country = (Country *) dict;
        }
        MQTCountryViewController *viewController = segue.destinationViewController;
        viewController.country = country;
    }
    else if ([segue.identifier isEqualToString:@"MQTSegueShowAboutView"])
    {
        NSLog(@"Info button pressed");
        MQTAboutViewController *aboutViewController = segue.destinationViewController;
        aboutViewController.dbVersion = [NSString stringWithFormat:@"Database version: %d", self.dbVersion];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -
- (NSNumberFormatter *) decimalFormatter
{
    if (!_decimalFormatter)
    {
        _decimalFormatter = [[NSNumberFormatter alloc] init];
        [_decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return _decimalFormatter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return [self.sections count];
    }
    else
    {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
    }
    else
    {
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
    }
    else
    {
        //NSLog(@" Y Number of sections: %i", (int) [searchResults count]);
        return [searchResults count];
    }
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    else
    {
        return nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellItentifier = @"MQTCountryCellIdentifier";
    MQTCountryTableViewCell *cell = (MQTCountryTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellItentifier];
    if (cell == nil)
    {
        cell = [[MQTCountryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellItentifier];
    }
    
    Country *country = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        country = [searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        NSDictionary *dict = [[self.sections valueForKey:[[[self.sections allKeys]
             sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        country = (Country *) dict;
    }
    
    cell.countryNameLabel.text = country.country_name;
    
    cell.countryCapitalLabel.text = country.capital;

    NSNumber *popNumber = [NSNumber numberWithInteger:country.population];
    NSString *population = [self.decimalFormatter stringFromNumber:popNumber];
    cell.countryPopulationLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Pop: %@", @"Pop:"), population];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.restorationIdentifier isEqualToString:@"MQTCountryCellIdentifier"])
    {
        [self performSegueWithIdentifier:@"MQTSegueShowCountry" sender:cell];
    }
}

#pragma mark -
#pragma mark === UISearchDisplayDelegate ===
#pragma mark -

// populate searchResults
// if scopeIndex == 0, seach country_name
// else seach capital
- (void)filterContentForSearchText:(NSString*)searchText scopeIndex:(NSInteger)scopeIndex
{
    //NSLog(@"Scope index: %i", scopeIndex);
    NSString *predicateFormat = @"%K BEGINSWITH[cd] %@";
    NSString *searchAttribute = @"country_name";
    if (scopeIndex == 0)
    {
        searchAttribute = @"country_name";
    }
    else
    {
        searchAttribute = @"capital";
    }
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:predicateFormat, searchAttribute, searchText];
    searchResults = [self.countries filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scopeIndex:controller.searchBar.selectedScopeButtonIndex];
    return YES;
}
- (void) searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 64;
}

@end
