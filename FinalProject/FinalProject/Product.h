//
//  Product.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property (strong, nonatomic)NSString* productName;
@property (strong, nonatomic)NSString* productImageName;
@property (strong, nonatomic)UIImage * productImage;
@property (strong, nonatomic)NSString* productType;
@property (nonatomic)float productPrice;
@property (nonatomic)NSInteger productAmount;
@property (strong, nonatomic)NSDate* productBestBefore;
@property (nonatomic)NSInteger daysDifference;
@property (strong, nonatomic)NSString* productSuperMarket;
@property (nonatomic)BOOL isFavourite;
@property (strong,nonatomic)NSString* productMemo;

- (id)initWithProductName:(NSString*)productName productImageName:(NSString*)productImageName productImage:(UIImage*)productImage productType:(NSString*)productType productPrice:(float)productPrice productAmount:(NSInteger)productAmount productBestBefore:(NSDate*)productBestBefor daysDifference:(NSUInteger)daysDifference productSuperMaket:(NSString*)productSuperMarket isFavourite:(BOOL)isFavourite productMemo:(NSString*)productMemo;

@end
