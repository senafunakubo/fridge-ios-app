//
//  FridgeCollectionViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-30.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FridgeCollectionViewCell.h"
#import "Product.h"
#import "HeaderCollectionReusableView.h"
#import "AddProductTableViewController.h"
#import "Fridge.h"
#import "MyTabBarViewController.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import FirebaseAuth;
@import Firebase;

#import "UIView+MGBadgeView.h"

@protocol FridgeItemCVDelegate

//-(NSMutableArray<Product*>*)fridgeItemCVDidCreate;

@end

@interface FridgeCollectionViewController : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource,AddProductTVDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *fridgeCollectionView;

@property(weak,nonatomic)id<FridgeItemCVDelegate> fridgeItemCVDelegate;
@property (strong, nonatomic)Fridge* fridgeInCV;

@property (strong,nonatomic) NSMutableArray<Product*>* productArray;
@property (strong, nonatomic) IBOutlet UIView* modalBg;


//for modal
@property (strong, nonatomic) UIView *subView;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (nonatomic)int uiButtonX;
@property (nonatomic)int uiButtonY;
@property (nonatomic)int countButton;
@property (nonatomic)int clickedIndex;
@property (nonatomic)NSInteger amount;

@property (nonatomic) int isEditProduct;

@end
