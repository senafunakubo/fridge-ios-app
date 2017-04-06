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

@protocol FridgeItemCVDelegate

-(NSMutableArray<Product*>*)fridgeItemCVDidCreate;

@end

@interface FridgeCollectionViewController : UICollectionViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *fridgeCollectionView;

@property(weak,nonatomic)id<FridgeItemCVDelegate> fridgeItemCVDelegate;

@property (strong,nonatomic) NSMutableArray<Product*>* productArray;

-(void)fridgeCVDidSelect;

@end
