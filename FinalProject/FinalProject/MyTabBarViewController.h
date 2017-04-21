//
//  MyTabBarViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FridgeCollectionViewController.h"
#import "FridgeItemsTableViewController.h"
#import "FavouriteViewController.h"
#import "ViewController.h"

#import "Fridge.h"
#import "Product.h"

@interface MyTabBarViewController : UITabBarController

@property (strong,nonatomic) NSMutableArray<Product*>* productArray;
-(void)addFood:(NSMutableArray<Product*>*)productArray;
@end
