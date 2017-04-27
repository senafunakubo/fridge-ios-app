//
//  AddFoodViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController ()

@property (strong, nonatomic) UIScrollView* scollView;

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isSwichToggled = NO;
    
    
    self.addProductImageView.image = [UIImage imageNamed:@"noimage"];
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
    
    
    self.view.backgroundColor = [UIColor clearColor];
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
    
    
    [self setupBackgroundScollView];

}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int isEditProduct = [self.addProductDelegate isEditProducts];
    self.product = [[Product alloc]init];
    if(isEditProduct == 1)
    {
        self.product = [self.addProductDelegate getEditProduct];
        
        self.addProductNameTextField.text = self.product.productName;
        self.addProductImageView.image = [UIImage imageNamed:self.product.productImageName];
        self.foodImage = self.product.productImageName;
        self.addProductTypeTextField.text = self.product.productType;
        self.addProductPriceTextField.text = [NSString stringWithFormat:@"%f", self.product.productPrice];
        self.addProductAmoutTextField.text = [NSString stringWithFormat:@"%ld", (long)self.product.productAmount ];
        self.addProductBestBeforeTextField.text = [NSString stringWithFormat:@"%@", self.product.productBestBefore];
        self.addProductSuperMarketTextField.text = self.product.productSuperMarket;
        self.addProductMemoTextView.text = self.product.productMemo;
        //TODO
        //self.isSwichToggled = self.product.isFavourite;
    }
}

-(void) setupBackgroundScollView
{
   
    ((UIScrollViewBackground*)self.view).backgroundColor = [UIColor whiteColor];
    ((UIScrollViewBackground*)self.view).scrollEnabled = YES;
    ((UIScrollViewBackground*)self.view).pagingEnabled = YES;
    ((UIScrollViewBackground*)self.view).showsVerticalScrollIndicator = YES;
    ((UIScrollViewBackground*)self.view).showsHorizontalScrollIndicator = YES;
    ((UIScrollViewBackground*)self.view).contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height+200);
}
//-(UIScrollView*) scollView
//{
//    
//    if(!_scollView)
//    {
//        _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//        _scollView.backgroundColor = [UIColor redColor];
//        _scollView.scrollEnabled = YES;
//        _scollView.pagingEnabled = YES;
//        _scollView.showsVerticalScrollIndicator = YES;
//        _scollView.showsHorizontalScrollIndicator = YES;
//        _scollView.contentSize = CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height*2);
//        
//    }
//
//    
//    return _scollView;
//}


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

    //if foodName is not empty done button is enabled
    if(!(self.addProductNameTextField.text.length == 0))
    {
    self.product.productName = self.addProductNameTextField.text;
    self.product.productImageName = self.foodImage;
    self.product.productType = self.addProductTypeTextField.text;
    self.product.productPrice = self.addProductPriceTextField.text.floatValue;
    self.product.productAmount = self.addProductAmoutTextField.text.integerValue;
    self.product.productBestBefore = self.addProductBestBeforeTextField.text;
    self.product.productSuperMarket = self.addProductSuperMarketTextField.text;
        
    if(!self.isSwichToggled)
    {
        self.product.isFavourite = YES;
    }
    self.product.productMemo = self.addProductMemoTextView.text;
    
    //if foodImage is not selected
    if(self.product.productImageName.length == 0)
    {
        self.product.productImageName = @"noimage";
    }
    
    [self.addProductDelegate productDidCreate:self.product];
    
    //chenged to isEditProduct = 0
    [self.addProductDelegate isDoneEditProducts];
        
    //close
    [self.navigationController popViewControllerAnimated:YES];
    }
    //if foodName is empty show alert
    else
    {
        [self showAlertForDoneButtone];
    }
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

-(void)showAlertForDoneButtone
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert"message:@"Please input name!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)toggleSwich:(UISwitch *)sender {
    self.isSwichToggled = YES;
    if (sender.on) {
        //self.label.text = @"ON";
        self.product.isFavourite = YES;
    } else {
        //self.label.text = @"OFF";
        self.product.isFavourite = NO;
    }
}


@end
