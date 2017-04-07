//
//  FridgeItemsTableViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "FridgeItemsTableViewCell.h"
#import "AddProductViewController.h"
#import "HeaderView.h"
#import "HeaderCollectionReusableView.h"

@protocol FridgeItemDelegate

-(NSMutableArray<Product*>*)fridgeItemsDidCreate;

@end

@interface FridgeItemsTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,HeaderDelegate>

@property(weak,nonatomic)id<FridgeItemDelegate> fridgeItemDelegate;
@property (weak, nonatomic) IBOutlet UITableView *fridgeItemsTableView;
@property (strong,nonatomic) NSMutableArray<Product*>* productArray;

-(void)fridgeListDidSelect;

@end
