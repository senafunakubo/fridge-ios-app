//
//  FoodTypeViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-19.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FoodTypeViewDelegate

-(void)typeSelected:(NSString*)type;

@end

@interface FoodTypeViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak,nonatomic) id<FoodTypeViewDelegate>foodTypeViewDelegate;
@property (weak, nonatomic) IBOutlet UIPickerView *FoodTypePickerView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerNames;

@end
