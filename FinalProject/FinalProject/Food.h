//
//  Food.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Food : Product

@property (nonatomic)NSInteger foodAmout;

- (id)initWithProductName:(NSString *)productName productType:(NSString *)productType productPrice:(float)productPrice ProductBestBefore:(NSDate *)productBestBefor productAmount:(NSInteger)productAmout productSuperMaket:(NSString *)productSuperMarket isFavourite:(BOOL)isFavourite productMemo:(NSString *)productMemo foodAmount:(NSInteger)foodAmout;

@end
