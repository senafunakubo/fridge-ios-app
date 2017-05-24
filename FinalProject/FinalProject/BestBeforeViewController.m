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

    self.dateFormatter = [[NSDateFormatter alloc]init];
    [self.dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    [self.BestBeforeDatePicker addTarget:self action:@selector(pickerDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSDate * selectedDate = [[NSDate alloc]init];
    selectedDate = [self.bestBeforeViewDelegate getSelectedDate];
    [self.BestBeforeDatePicker setDate:selectedDate];
    self.dateLabel.text = [self.dateFormatter stringFromDate:selectedDate];
}

-(void)pickerDidChange:(UIDatePicker*)datePicker
{
    NSString *dateString = [self.dateFormatter stringFromDate:datePicker.date];
    self.dateLabel.text = dateString;
    [self.bestBeforeViewDelegate dateSelected:datePicker.date];
}

@end
