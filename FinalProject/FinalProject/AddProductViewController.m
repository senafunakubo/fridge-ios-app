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
    
    //Done button of picker
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(showSelectedDate)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneButton,nil]];
    [self.addProductBestBeforeTextField setInputAccessoryView:toolbar];
    
    
    //Done button for Type
//    UIToolbar *toolbarForType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [toolbarForType setTintColor:[UIColor grayColor]];
//    UIBarButtonItem *doneButtonForType = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(showSelectedType)];
//    UIBarButtonItem *spaceForType = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolbarForType setItems:[NSArray arrayWithObjects:spaceForType,doneButtonForType,nil]];
//    [self.addProductTypeTextField setInputAccessoryView:toolbarForType];
// ほぼ上と同じコード、最初のfruitsを選んでもFieldに表示されない、もう一度picker開くと何も表示されなくなる、多分DatePickerにも影響？
    
    
    //when typetextfield is tapped picker view show
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.addProductTypeTextField.inputView = self.pickerView;
    
    self.pickerNames = @[ @"fruit", @"meet", @"fish", @"Other"];
    
    [self.view addSubview:self.addProductTypeTextField];
    
    //for take photo
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                        message:@"'Take Photo' button doesn't work."
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

-(void)showSelectedType
{
    self.pickerView = [[UIPickerView alloc] init];
    self.addProductTypeTextField.inputView = self.pickerView;
    [self.addProductTypeTextField resignFirstResponder];
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
- (IBAction)selectFoodImage:(id)sender {
}

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
    
    [self.addProductDelegate imageDidChoice:self.foodImage];
    
    self.product.productName = self.addProductNameTextField.text;
    self.product.productType = self.addProductTypeTextField.text;
    self.product.productPrice = self.addProductPriceTextField.text.floatValue;
    self.product.productAmount = self.addProductAmoutTextField.text.integerValue;
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

//textfield to pickerview
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
        self.addProductTypeTextField.text = self.pickerNames[row];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"SelectFoodImageSegue"])
    {
        UIViewController* uvc = segue.destinationViewController;
        
        ((SelectFoodImageTableViewController*)uvc).selectFoodImageDelegate = self;
    }
}

-(void)imageDidSelect:(NSString*)foodImage
{
    self.foodImage = foodImage;
    self.addProductImageView.image = [UIImage imageNamed:foodImage];
}
@end
