//
//  BestBeforeViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-19.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BestBeforeViewDelegate
-(void)dateSelected:(NSDate*)date;
@end

@interface BestBeforeViewController : UIViewController
@property (weak,nonatomic) id<BestBeforeViewDelegate>bestBeforeViewDelegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *BestBeforeDatePicker;
//@property (strong,nonatomic) UIDatePicker* datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//- (IBAction)DateChanged:(id)sender;
-(NSDate*)getDateWithTimeZone:(NSString*)date;

@end
