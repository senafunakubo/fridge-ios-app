//
//  ShoppingListTableViewCell.h
//  FinalProject
//
//  Created by Sena Funakubo on 2017-04-10.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
//@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIImageView *storeLogo;

@end
