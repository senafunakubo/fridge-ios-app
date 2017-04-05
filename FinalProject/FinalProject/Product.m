//
//  Product.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithProductName:(NSString *)productName productType:(NSString*)productType productPrice:(float)productPrice ProductBestBefore:(NSDate *)productBestBefor  productSuperMaket:(NSString *)productSuperMarket isFavourite:(BOOL)isFavourite productMemo:(NSString *)productMemo
{
    self= [super init];
    if(self)
    {
        self.productName = productName;
        self.productType = productType;
        self.productPrice = productPrice;
        self.productBestBefore = productBestBefor;
        self.productSuperMarket = productSuperMarket;
        self.isFavourite = isFavourite;
        self.productName = productName;
    }
    return self;
}

@end
