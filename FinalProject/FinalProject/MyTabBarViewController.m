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
    self.productArray = [[NSMutableArray<Product*> alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    // setting delegate
//    if([viewController isMemberOfClass:[FridgeItemsTableViewController class]]) {
//        ((FridgeItemsTableViewController*)viewController).fridgeItemDelegate = self;
//        [(FridgeItemsTableViewController*)viewController fridgeListDidSelect];
//    }
//    else if([viewController isMemberOfClass:[FridgeCollectionViewController class]]) {
//        ((FridgeCollectionViewController*)viewController).fridgeItemCVDelegate = self;
//        ((FridgeCollectionViewController*)viewController).fridgeItemCVDelegate = self;
//    }
//}

-(void)addFood:(NSMutableArray<Product*>*)productArray
{
    self.productArray = productArray;
}

@end
