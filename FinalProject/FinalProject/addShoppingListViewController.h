//
//  addShoppingListViewController.h
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//
// About bool
// http://stackoverflow.com/questions/4864239/using-a-bool-property

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@class ShoppingListViewController;

@protocol addSHPDelegate <NSObject>

@end


@interface addShoppingListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>


@property (weak,nonatomic)id<addSHPDelegate>addSHPDelegate;

@property (weak, nonatomic) IBOutlet UITableView *AddSPLView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchController *searchController;


//For A-Z index
@property (copy,nonatomic)NSDictionary *groceryList;
@property (copy,nonatomic)NSArray *keys;


//This code is to put the result of reserching
@property (strong,nonatomic) NSMutableArray *filteredString;
@property (nonatomic, assign) BOOL isFilltered;

@end
