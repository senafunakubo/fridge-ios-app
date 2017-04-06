//
//  HeaderView.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-04-03.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HeaderDelegate
-(void)sortButtonPressed;
-(void)addButtonPressed;
@end

@interface HeaderView : UIView
@property (weak,nonatomic)id<HeaderDelegate>headerDelegate;
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (IBAction)sortFoodButton:(id)sender;
- (IBAction)addFoodButton:(id)sender;


@end
