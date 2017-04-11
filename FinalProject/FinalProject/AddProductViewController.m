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
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.addProductBestBeforeTextField setInputView:datePicker];

    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(showSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneButton,nil]];
    [self.addProductBestBeforeTextField setInputAccessoryView:toolbar];
    
    //for take photo
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                              message:@"This is an alert."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showSelectedDate
{
    UIDatePicker *picker = (UIDatePicker*)self.addProductBestBeforeTextField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    self.addProductBestBeforeTextField.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:picker.date]];
    [self.addProductBestBeforeTextField resignFirstResponder];
    
}

- (void)dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.addProductBestBeforeTextField.inputView;
    [picker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:86400*730]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.addProductBestBeforeTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

//take photo (only for Using a Physical Device with a camera)
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.addProductImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//if it is canceled
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
    
    //TODO have to change
    [self.addProductDelegate productDidCreate:self.product];
    self.addProductNameTextField.text = @"";
    self.addProductTypeTextField.text = @"";
    self.addProductPriceTextField.text = @"";
    self.addProductBestBeforeTextField.text = @"";
    self.addProductSuperMarketTextField.text = @"";
    //self.addProductIsFavouriteSwitch = ;
    self.addProductMemoTextView.text = @"";
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
