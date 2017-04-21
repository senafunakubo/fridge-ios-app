//
//  ShoppingListViewController.m
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//
//  About NSDictionary
//  http://qiita.com/satoshi0212/items/d67058bcf252f4c840ed
//  http://iphone-tora.sakura.ne.jp/nsdictionary.html
//
//  UIColor-Picker
//  https://briangrinstead.com/blog/ios-uicolor-picker/


#import "ShoppingListViewController.h"
#import "ShoppingListTableViewCell.h"

@interface ShoppingListViewController ()

@end

@implementation ShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shoppingListTableView.delegate = self;
    self.shoppingListTableView.dataSource = self;
    [self.shoppingListTableView reloadData];
    
    self.items = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"Shopping List";
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    //For a bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.76 green:0.89 blue:1.00 alpha:1.0];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


#pragma mark - TableView datasourse
                                
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingListTableView" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[ShoppingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingListTableView"];
    }
    
    NSDictionary *item = self.items[indexPath.row];
    cell.productName.text = [item objectForKey:@"ProductName"];

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


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   if(editingStyle == UITableViewCellEditingStyleDelete)
   {
       [self.items removeObjectAtIndex:indexPath.row];
       [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
   }
}


@end
