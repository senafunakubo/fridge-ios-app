//
//  addShoppingListViewController.h
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addSHPDelegate <NSObject>

@end


@interface addShoppingListViewController : UIViewController

@property(weak,nonatomic)id<addSHPDelegate>addSHPDelegate;

@end
