//
//  Fridge.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "Fridge.h"

@implementation Fridge

-(id)initWithFridgeItemsArray:(NSMutableArray<Product*>*) fridgeItemsArrayinFridge
{
    self = [super init];
    if(self)
    {
        self.fridgeItemsArrayinFridge = fridgeItemsArrayinFridge;
    }
    return self;
}

-(NSMutableArray<Product*>*)addFridge:(Product *)product
{
    [self.fridgeItemsArrayinFridge addObject:product];
    return self.fridgeItemsArrayinFridge;
}

@end
