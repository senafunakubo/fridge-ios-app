//
//  FoodTypeViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-19.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "FoodTypeViewController.h"

@interface FoodTypeViewController ()

@end

@implementation FoodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.pickerNames = @[@"Other", @"fruit", @"meet", @"fish"];
    self.pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:self.pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }
    
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [self.pickerNames count];
    }
    
    return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return self.pickerNames[row];
    }
    
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        self.typeLabel.text = self.pickerNames[row];
        [self.foodTypeViewDelegate typeSelected:self.pickerNames[row]];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
