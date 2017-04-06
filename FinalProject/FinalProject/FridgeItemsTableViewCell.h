//
//  FridgeItemsTableViewCell.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FridgeItemsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *fridgeItemImageView;
@property (weak, nonatomic) IBOutlet UILabel *fridgeItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridgeBestBefore;
@property (weak, nonatomic) IBOutlet UILabel *fridgeWeastOrNot;

@end
