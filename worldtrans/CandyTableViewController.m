//
//  CandyTableViewController.m
//  worldtrans
//
//  Created by itdept on 2/12/14.
//  Copyright (c) 2014 itdept. All rights reserved.
//
#import "Candy.h"
#import "CandyTableViewController.h"
#import "DBTest.h"

@interface CandyTableViewController ()

@end

@implementation CandyTableViewController
@synthesize candyArray;
@synthesize filteredCandyArray;
@synthesize testArray;
@synthesize filteredTestArray;
@synthesize candySearchBar;


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
    int myCount = 0;
    
    while ( myCount < 100 )
    {
        [[DBTest getSharedInstance]saveData: @"1234" name:@"PETER" department: @"IT Depart" year:@"2011"];
        myCount++;
    }
    // Sample Data for candyArray
    candyArray = [NSArray arrayWithObjects:
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate bar"],
                  [Candy candyOfCategory:@"chocolate" name:@"chocolate chip"],
                  [Candy candyOfCategory:@"chocolate" name:@"dark chocolate"],
                  [Candy candyOfCategory:@"hard" name:@"lollipop"],
                  [Candy candyOfCategory:@"hard" name:@"candy cane"],
                  [Candy candyOfCategory:@"hard" name:@"jaw breaker"],
                  [Candy candyOfCategory:@"other" name:@"caramel"],
                  [Candy candyOfCategory:@"other" name:@"sour chew"],
                  [Candy candyOfCategory:@"other" name:@"peanut butter cup"],
                  [Candy candyOfCategory:@"other" name:@"gummi bear"], nil];
    
    testArray = [[DBTest getSharedInstance]getData];
    
    // Reload the table
    //self.filteredCandyArray = [NSMutableArray arrayWithCapacity:[candyArray count]];
    self.filteredTestArray = [NSMutableArray arrayWithCapacity:[testArray count]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredCandyArray count];
    } else {
        return [candyArray count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Create a new Candy Object
    // Candy *candy = nil;
     NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc] init];
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    //if (tableView == self.searchDisplayController.searchResultsTableView) {
    //    candy = [filteredCandyArray objectAtIndex:indexPath.row];
    
    //} else {
    //    candy = [candyArray objectAtIndex:indexPath.row];
    //}
    myDictionary = [testArray objectAtIndex:indexPath.row];    // Configure Cell
    UILabel *Title = (UILabel *)[cell.contentView viewWithTag:11];
    //Title.text = candy.name;
    Title.text = [myDictionary valueForKey:@"name"];
    
    // Configure Cell
    //UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
//[label setText:[NSString stringWithFormat:@"Row %i in Section %i", [indexPath row], [indexPath section]]];
 
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
/*
#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredCandyArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredCandyArray = [NSMutableArray arrayWithArray:[candyArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}*/
@end
