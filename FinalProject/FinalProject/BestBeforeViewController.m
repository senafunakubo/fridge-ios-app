 //
//  BestBeforeViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-19.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "BestBeforeViewController.h"

@interface BestBeforeViewController ()

@end

@implementation BestBeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.BestBeforeDatePicker addTarget:self action:@selector(pickerDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pickerDidChange:(UIDatePicker*)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:datePicker.date];
    
    self.dateLabel.text = dateString;
    
    [self.bestBeforeViewDelegate dateSelected:datePicker.date];
}
    
@end
