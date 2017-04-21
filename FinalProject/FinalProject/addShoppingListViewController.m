//
//  addShoppingListViewController.m
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//
// How to make a search bar
// http://kohei0410.hatenablog.com/entry/2015/05/05/220328
// http://dev.classmethod.jp/smartphone/iphone/search_uitableview/

// NSString comparison
// http://qiita.com/ktysne/items/bfb313df8c7e3d62f688
//
// NSBundle
// http://iphone-tora.sakura.ne.jp/nsbundle.html

//When we cannnot find the result of the search, I wanna use the table which we can write by ourselves

#import "addShoppingListViewController.h"
#import "ShoppingListViewController.h"

@interface addShoppingListViewController ()

@end

@implementation addShoppingListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.AddSPLView.delegate = self;
    self.AddSPLView.dataSource = self;
    self.searchBar.delegate = self;
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    
    //For changing the color of a section index
    UIColor *tintColor = [UIColor colorWithRed:0.28 green:0.64 blue:0.91 alpha:1.0];
    UIColor *trakingBackgroundColor = [UIColor colorWithRed:206.f/255.f green:203.f/255.f blue:198.f/255.f alpha:1.f];
    
    self.tableView.sectionIndexColor = tintColor;
    self.tableView.sectionIndexBackgroundColor = [UIColor whiteColor];
    self.tableView.sectionIndexTrackingBackgroundColor = trakingBackgroundColor;
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    //To read the plist file
    NSString *path = [bundle pathForResource:@"groceryList" ofType:@"plist"];
    
    self.groceryList = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //sorted
    self.keys = [[self.groceryList allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag ==1)
    {
      return [self.groceryList count];
    }
    else
    {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1)
    {

        NSString *key =self.keys[section];
        
        NSArray *keyValues = self.groceryList[key];
        
        return [keyValues count];
    }
    else
    {
        return [self.filteredString count];
    }
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    if(tableView.tag == 1)
    {
        if(!self.isFilltered) //searchText.length == 0
        {
            cell.textLabel.text = [self.keys objectAtIndex:indexPath.row];
        }
        
        NSString *key = self.keys[indexPath.section];
        
        NSArray *keyValues = self.groceryList[key];
        
        cell.textLabel.text = keyValues[indexPath.row];
    }
    else
    {
        cell.textLabel.text = [self.filteredString objectAtIndex:indexPath.row];
    }
    return cell;

}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView.tag ==1)
    {
      return self.keys;
    }
    else
    {
        return  nil;
    }
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView.tag == 1)
    {
        return self.keys[section];
    }
    else
    {
        return nil;
    }
}


#pragma mark Search Display Delegate Methods

-(void)searchController:(UISearchController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.tableView resignFirstResponder];
}


//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if(searchText.length ==0)
//    {
//        self.isFilltered = NO;
//    }
//    else
//    {
//        self.isFilltered = YES;
//        self.filteredString = [[NSMutableArray alloc]init];
//        
//        for(NSString *key in self.keys)
//        {
//            // Partial match(doesn't matter if it's the capital or not)
//            NSRange StringRange = [key rangeOfString:searchText options:NSCaseInsensitiveSearch];
//
//            if(StringRange.location != NSNotFound)
//            {
//                [self.filteredString addObject:key];
//            }
//        }
//    }
//    [self.AddSPLView reloadData];
//}


-(BOOL)searchDisplayController:(UISearchController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [self.filteredString removeAllObjects];
    
    if (searchString.length > 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [search] %@", self.searchBar.text];
        
       for(NSString *key in self.keys)
       {
         NSArray *matches = [self.groceryList[key]filteredArrayUsingPredicate:predicate];
        
         [self.filteredString addObjectsFromArray:matches];
        
       }
    }
    return YES;
}


#pragma mark For Seque

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    AppDelegate *ap = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    ShoppingListViewController *shoppingListView = [self.storyboard instantiateViewControllerWithIdentifier:@"shoppingList"];
    
    [self.navigationController pushViewController:shoppingListView animated:YES];
}



@end
