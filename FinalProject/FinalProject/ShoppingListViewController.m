//
//  ShoppingListViewController.m
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//
//  http://qiita.com/Night___/items/f2877236a4182c566eed
//  http://iphone-app-developer.seesaa.net/article/406225155.html

#import "ShoppingListViewController.h"

@interface ShoppingListViewController ()

@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shoppingListTableView.delegate = self;
    self.shoppingListTableView.dataSource = self;
    [self.shoppingListTableView reloadData];
    
    self.items = @[@{@"name" : @"Product",@"category" : @"Fridge"}].mutableCopy;
    self.categories = @[@"Fruits",@"Vegitables"];
    
    self.navigationItem.title = @"Shopping List";
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    
    //For a bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.84 green:0.97 blue:0.94 alpha:1.0];
    
    //For check marks
    self.shoppingListTableView.tintColor =  [UIColor colorWithRed:0.52 green:0.74 blue:0.65 alpha:1.0];
    
    //For an add button
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.34 green:0.66 blue:0.84 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfItemsInTheCategory:self.categories[section]];
}

#pragma mark - Datasourse helper method

-(NSArray *)ItemsInCategory:(NSString *)targetCategory
{
    NSPredicate *matchingPredicate = [NSPredicate predicateWithFormat:@"category == %@",targetCategory];
    NSArray *categoryItems = [self.items filteredArrayUsingPredicate:matchingPredicate];
    
    return categoryItems;
}

-(NSInteger)numberOfItemsInTheCategory:(NSString *)targetCategory
{
    return [self ItemsInCategory:targetCategory].count;
}

-(NSDictionary *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *category = self.categories[indexPath.section];
    NSArray *categoryItems = [self ItemsInCategory:category];
    NSDictionary *item = categoryItems[indexPath.row];
    
    return item;
}

-(NSInteger)itemIndexForIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self itemAtIndexPath:indexPath];
    NSInteger index = [self.items indexOfObjectIdenticalTo:item];
    
    return index;
}

-(void)removeItemsAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = [self itemIndexForIndexPath:indexPath];
    [self.items removeObjectAtIndex:index];
    
}


#pragma mark - TableView datasourse
                                
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingListTableView" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[ShoppingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingListTableView"];
    }
    
    NSDictionary *item = [self itemAtIndexPath:indexPath];
    cell.productName.text = @"Test";

    if([item[@"completed"]boolValue])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *item = [self.items[indexPath.row]mutableCopy];
    
    //For putting bool in a dictionary, we have to wrap it as a NSNumber.
    BOOL completed = [item[@"completed"]boolValue];
    
    //As it is the NSNumber, we will get some errors if we don't use @() here.
    item[@"completed"] = @(!completed);
    
    self.items[indexPath.row] = item;
    
    UITableViewCell *cell=[self.shoppingListTableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = ([item[@"completed"] boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    [self.shoppingListTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addShoppingListSegue"])
    {
        ((addShoppingListViewController*)segue.destinationViewController).addSHPDelegate = self;
    }
}


@end
