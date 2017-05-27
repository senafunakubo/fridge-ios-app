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
//#import "AddProductViewController.h"
#import "AddProductTableViewController.h"
#import "Fridge.h"
#import "HeaderView.h"

@protocol FavouriteVCDelegate

//-(NSMutableArray<Product*>*)fridgeItemCVDidCreate;

@end

@interface FavouriteViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate, UITableViewDataSource, AddProductTVDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *favouriteCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *favouriteTableView;
@property (nonatomic) int clickedIndex;
@property (nonatomic) int isEditFavouriteProduct;

- (IBAction)Swich:(id)sender;

@property(weak,nonatomic)id<FavouriteVCDelegate> fridgeVCDelegate;
@property (strong, nonatomic)Fridge* fridgeInCV;

@property (strong,nonatomic) NSMutableArray<Product*>* productArray;
@property (nonatomic) NSUInteger lastNumberOfproductArray;
@property (strong,nonatomic) NSMutableArray<Product*>* favouriteArray;
@property (strong,nonatomic) NSMutableArray* foodImageArray;

//for modal
@property (strong, nonatomic) IBOutlet UIView* modalBg;
@property (strong, nonatomic) UIView *subView;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (nonatomic)int uiButtonX;
@property (nonatomic)int uiButtonY;
@property (nonatomic)int countButton;
//@property (nonatomic)int clickedIndex;
@property (nonatomic)NSInteger amount;
@property (nonatomic) int isEditProduct;

//-(void)fridgeCVDidSelect;
-(void)addFavouriteArray:(NSMutableArray<Product*>*)productArray;

@end
