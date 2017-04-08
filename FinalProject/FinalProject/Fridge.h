//
//  Fridge.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
//#import "Food.h"
//#import "Drink.h"

@interface Fridge : NSObject

@property (strong, nonatomic)NSMutableArray<Product*>* fridgeItemsArrayinFridge;

-(id)initWithFridgeItemsArray:(NSMutableArray<Product*>*) fridgeItemsArrayinFridge;

-(NSMutableArray<Product*>*)addFridge:(Product*)product;

@end
