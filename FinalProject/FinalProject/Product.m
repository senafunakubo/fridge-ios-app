//
//  Product.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithProductName:(NSString *)productName productImageName:(NSString*)productImageName productType:(NSString*)productType productPrice:(float)productPrice productAmount:(NSInteger)productAmount productBestBefore:(NSDate *)productBestBefor daysDifference:(NSUInteger)daysDifference productSuperMaket:(NSString *)productSuperMarket isFavourite:(BOOL)isFavourite productMemo:(NSString *)productMemo
{
    self= [super init];
    if(self)
    {
        self.productName = productName;
        self.productImageName = productImageName;
        self.productType = productType;
        self.productPrice = productPrice;
        self.productAmount = productAmount;
        self.productBestBefore = productBestBefor;
        self.daysDifference = daysDifference;
        self.productSuperMarket = productSuperMarket;
        self.isFavourite = isFavourite;
        self.productName = productName;
    }
    return self;
}

@end
