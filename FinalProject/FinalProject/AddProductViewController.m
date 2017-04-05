//
//  AddFoodViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //when textfield is tapped datepicker show
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:86400*730]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.addProductBestBeforeTextField setInputView:datePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.addProductBestBeforeTextField.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.addProductBestBeforeTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

- (IBAction)doneButton:(id)sender {

    self.product = [[Product alloc]init];
    
    self.product.productName = self.addProductNameTextField.text;
    self.product.productType = self.addProductTypeTextField.text;
    self.product.productPrice = self.addProductPriceTextField.text.floatValue;
    self.product.productBestBefore = self.addProductBestBeforeTextField.text;
    self.product.productSuperMarket = self.addProductSuperMarketTextField.text;
    self.product.isFavourite = self.addProductIsFavouriteSwitch;
    self.product.productMemo = self.addProductMemoTextView.text;
    
    [self.addProductDelegate productDidCreate:self.product];
    self.addProductNameTextField.text = @"";
    self.addProductTypeTextField.text = @"";
    self.addProductPriceTextField.text = @"";
    self.addProductBestBeforeTextField.text = @"";
    self.addProductSuperMarketTextField.text = @"";
    //self.addProductIsFavouriteSwitch = ;
    self.addProductMemoTextView.text = @"";
}
//header delegate method
-(void)sortButtonPressed
{
    NSLog(@"sort!!!");
}
-(void)addButtonPressed
{
    NSLog(@"add!!!");
}

@end
