//
//  FridgeCollectionViewCell.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-30.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FridgeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodDaysLabel;

@end
