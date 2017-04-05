//
//  MyTabBarViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "MyTabBarViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    NSMutableArray<Product*>* fridgeItemsArray = [[NSMutableArray alloc]init];
    self.fridgeInTabbar = [[Fridge alloc]initWithFridgeItemsArray:fridgeItemsArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray<Product*>*)fridgeItemsDidCreate
{
    return self.fridgeInTabbar.fridgeItemsArrayinFridge;
}

-(NSMutableArray<Product*>*)fridgeItemCVDidCreate
{
    return self.fridgeInTabbar.fridgeItemsArrayinFridge;
}

-(void)productDidCreate:(Product*)product
{
    [self.fridgeInTabbar addFridge:product];
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // setting delegate
    if([viewController isMemberOfClass:[FridgeItemsTableViewController class]]) {
        ((FridgeItemsTableViewController*)viewController).fridgeItemDelegate = self;
        
        [(FridgeItemsTableViewController*)viewController fridgeListDidSelect];
    }
    else if([viewController isMemberOfClass:[AddProductViewController class]]) {
        ((AddProductViewController*)viewController).addProductDelegate = self;
    }
    else if([viewController isMemberOfClass:[FridgeCollectionViewController class]]) {
        ((FridgeCollectionViewController*)viewController).fridgeItemCVDelegate = self;
        ((FridgeCollectionViewController*)viewController).fridgeItemCVDelegate = self;
        
        [(FridgeCollectionViewController*)viewController fridgeCVDidSelect];
    }
}


@end
