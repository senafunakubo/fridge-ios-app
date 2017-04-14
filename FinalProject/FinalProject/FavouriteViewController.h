//
//  FavouriteViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-08.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavouriteCollectionViewCell.h"
#import "FavouriteTableViewCell.h"
#import "Product.h"
#import "MyTabBarViewController.h"

#import "HeaderCollectionReusableView.h"
#import "AddProductViewController.h"
#import "Fridge.h"
#import "HeaderView.h"

@protocol FavouriteVCDelegate

-(NSMutableArray<Product*>*)fridgeItemCVDidCreate;

@end

@interface FavouriteViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource,AddProductDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *favouriteCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *favouriteTableView;
- (IBAction)Swich:(id)sender;

@property(weak,nonatomic)id<FavouriteVCDelegate> fridgeVCDelegate;
@property (strong, nonatomic)Fridge* fridgeInCV;

@property (strong,nonatomic) NSMutableArray<Product*>* productArray;
@property (strong,nonatomic) NSMutableArray* foodImageArray;

-(void)fridgeCVDidSelect;

@end
