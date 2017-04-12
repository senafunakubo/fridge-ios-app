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

#import "addShoppingListViewController.h"

@interface addShoppingListViewController ()

@end

@implementation addShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AddSPLView.delegate = self;
    self.AddSPLView.dataSource = self;
    self.searchBar.delegate = self;
    
    //Datasource which I wanna show up at table but this is for test
    self.totalString = [[NSMutableArray alloc]initWithObjects:@"Udon",@"Milk",@"Spinach",@"Chickpea",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.AddSPLView resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length ==0)
    {
        self.isFilltered = NO;
    }
    else
    {
        self.isFilltered = YES;
        self.filteredString = [[NSMutableArray alloc]init];
        for(NSString *str in self.totalString)
        {
            // Partial match(doesn't matter if it's the capital or not)
            NSRange StringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if(StringRange.location != NSNotFound)
            {
                [self.filteredString addObject:str];
            }
        }
    }
    [self.AddSPLView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
      if(self.isFilltered)
      {
          // Only show up the concerted item when we search a word or words.
          return [self.filteredString count];
      }
   
    // We need to define the number of rows even there is no concerted item.
    return [self.totalString count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Defined a local variable to omit adding following stuff.
    static NSString *cellIdentifier = @"cell";
    
     UITableViewCell *cell = [self.AddSPLView dequeueReusableCellWithIdentifier:cellIdentifier];
    
     if(!cell)
     {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
     }
    
     if(!self.isFilltered) //searchText.length == 0
     {
        cell.textLabel.text = [self.totalString objectAtIndex:indexPath.row];
     }
     else
     {
        cell.textLabel.text = [self.filteredString objectAtIndex:indexPath.row];
     }
    return cell;
}

@end
