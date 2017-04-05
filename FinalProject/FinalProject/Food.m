//
//  Food.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "Food.h"

@implementation Food

-(id)initWithProductName:(NSString *)productName productType:(NSString *)productType productPrice:(float)productPrice ProductBestBefore:(NSDate *)productBestBefor productAmount:(NSInteger)productAmout productSuperMaket:(NSString *)productSuperMarket isFavourite:(BOOL)isFavourite productMemo:(NSString *)productMemo foodAmount:(NSInteger)foodAmout
{
    self= [super init];
    if(self)
    {
        self.foodAmout = foodAmout;
    }
    return self;
}

@end
