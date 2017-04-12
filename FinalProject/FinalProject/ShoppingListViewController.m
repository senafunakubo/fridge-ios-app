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
    
    self.items = @[@{@"name" : @"Product",@"category" : @"Home"}].mutableCopy;
    
    self.navigationItem.title = @"Shopping List";
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
//    UIView *navBorder = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.width, 2)];
//    
//    NSString *pathline = [[NSBundle mainBundle] pathForResource:@"separate_ip6" ofType:@"png"];
 
    
// add button
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
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
//    return self.items.count;
    return 3;
}

#pragma mark - Adding Items

-(void)addNewItem:(UIBarButtonItem *)sender
{
    
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"New item" message:@"Please enter the name of the item" preferredStyle:UIAlertControllerStyleAlert];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
//    {
//        [self doneButtonPushed];
//    }
//                                ]];
//                                
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self cancelButtonPushed];
//    }
//                                ]];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"text";
//    }];
//  [self presentViewController:alertController animated:YES completion:nil];
}

                                
- (void)doneButtonPushed
{

}

- (void)cancelButtonPushed {}
                                
                                
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingListTableView"];
    
    if(!cell)
    {
        cell = [[ShoppingListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingListTableView"];
    }
    
//    NSDictionary *items = self.items[indexPath.row];
    cell.productName.text = @"abc";
    
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"addShoppingListSegue"])
    {
        ((addShoppingListViewController*)segue.destinationViewController).addSHPDelegate = self;
    }
}


@end
