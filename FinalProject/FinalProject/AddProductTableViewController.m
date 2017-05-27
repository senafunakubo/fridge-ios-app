//
//  AddProductTableViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-14.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "AddProductTableViewController.h"

@interface AddProductTableViewController ()

@end

@implementation AddProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addProductTableView.delegate = self;
    self.addProductTableView.dataSource = self;
    
    self.product = [[Product alloc]init];
    self.foodImage = @"noimage";
    self.tableViewIDArray = @[@"addProductImageTV", @"addProductNameTV", @"addProductAmountTV", @"addProductBestBeforeTV", @"addProductTypeTV", @"addProductPriceTV", @"addProductFavouriteTV"];
    self.amount = 1;
    self.cellTextFieldArray = [[NSMutableArray<UITextField*> alloc]init];
    self.dateformatter = [[NSDateFormatter alloc] init];
    [self.dateformatter setDateFormat:@"dd-MM-yyyy"];
    
    self.isSwichToggled = YES;
    [self getCurrentDate];
    self.dateFromPicker = self.currentDateString;
    self.typeFromPicker = @"Other";
 
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
    
    
    
    //for keyboard endEditing
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    int isEditProduct = [self.addProductTVDelegate isEditProducts];
    if(isEditProduct == 1)
    {
        self.product = [self.addProductTVDelegate getEditProduct];
        self.foodImage = self.product.productImageName;
        self.amount = self.product.productAmount;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        self.dateFromPicker = [dateFormatter stringFromDate:self.product.productBestBefore];
        self.typeFromPicker = self.product.productType;
    }
    [self.addProductTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductImageTV"];
        
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductImageTV"];
        }
        if([self.foodImage isEqualToString:@"noimage"])
        {
            cell.addProductImage.image = [UIImage imageNamed:@"noimage"];
        }
        else if([self.foodImage isEqualToString:@"photo"])
        {
            cell.addProductImage.image = self.chosenImage;
        }
        else if([self.foodImage containsString:@"https"])
        {
            NSURL *url = [NSURL URLWithString:self.foodImage];
            NSData *data = [NSData dataWithContentsOfURL:url];
            cell.addProductImage.image = [UIImage imageWithData:data];
        }
        self.cellTextFieldArray[indexPath.section] = [NSNull null];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductNameTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductNameTV"];
        }
        cell.addProductNameTextField.text = self.product.productName;
        self.cellTextFieldArray[indexPath.section] = cell.addProductNameTextField;
        return cell;
    }
    else if(indexPath.section == 2)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductAmountTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductAmountTV"];
        }
        
        //stepper
        if (![[cell.stepper allTargets] containsObject:self])
        {
            [cell.stepper addTarget:self action:@selector(stepperTapped:event:) forControlEvents:UIControlEventValueChanged];
        }
        
        cell.stepper.tag = indexPath.row + indexPath.section * 10000;
        
        cell.addProductAmoutTextField.text = [[NSNumber numberWithInt:self.amount] stringValue];
        
        self.cellTextFieldArray[indexPath.section] = cell.addProductAmoutTextField;
        return cell;
    }
    else if(indexPath.section == 3)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductBestBeforeTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductBestBeforeTV"];
        }
        
        cell.addProductBestBeforeLabel.text = self.dateFromPicker;

        NSInteger num = [self compairDate:self.dateFromPicker];
        NSString *daysDifference = [NSString stringWithFormat:@"%d", num];
        cell.daysDifference.text = daysDifference;
        
        self.cellTextFieldArray[indexPath.section] = [NSNull null];
        
        return cell;
    }
    else if(indexPath.section == 4)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductTypeTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductTypeTV"];
        }
        
        cell.addProductTypeLabel.text = self.typeFromPicker;
        self.cellTextFieldArray[indexPath.section] = [NSNull null];
        return cell;
    }
    else if(indexPath.section == 5)
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductPriceTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductPriceTV"];
        }
        
        cell.addProductPriceTextField.text = [[NSNumber numberWithFloat:self.product.productPrice] stringValue];
        self.cellTextFieldArray[indexPath.section] = cell.addProductPriceTextField;
        return cell;
    }
    else
    {
        AddProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addProductFavouriteTV"];
        if(!cell)
        {
            cell = [[AddProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addProductFavouriteTV"];
        }
        self.cellTextFieldArray[indexPath.section] = [NSNull null];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 75;
    }
    else
    {
        return 50;
    }
}

- (void)stepperTapped:(UIStepper*)stepper event:(UIEvent *)event{
    //    UITouch *touch = [[event allTouches] anyObject];
    //    CGPoint point = [touch locationInView:self.tableView];
    //    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    int row = stepper.tag % 10000;
    int section = stepper.tag / 10000;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    AddProductTableViewCell *cell = (AddProductTableViewCell*)[self.addProductTableView cellForRowAtIndexPath:indexPath];
    
    cell.addProductAmoutTextField.text = [[NSNumber numberWithInt:stepper.value] stringValue];
    
    self.amount = stepper.value;
}

//delegate
-(void)dateSelected:(NSString*)date
{
    self.dateFromPicker = date;
}
-(NSString*)getSelectedDateStr
{
    NSString * currentDateString = self.currentDateString;
    return currentDateString;
}
-(void)typeSelected:(NSString *)type
{
    self.typeFromPicker = type;
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

- (IBAction)getImage:(id)sender {
    
    NSString * imageUrlStr = [self parseXML:self.cellTextFieldArray[1].text];
    
    if(imageUrlStr.length == 0)
    {
        self.foodImage = @"noimage";
    }
    else
    {
        self.foodImage = imageUrlStr;
    }
    
    [self updateDate];
    
    [self.addProductTableView reloadData];
    [self.view endEditing:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    AddProductTableViewCell *cell = (AddProductTableViewCell*)[self.addProductTableView cellForRowAtIndexPath:indexPath];
    
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    self.foodImage = @"photo";
    cell.addProductImage.image = self.chosenImage;
    
//    self.addProductImageView.image = chosenImage;

    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//if it is canceled
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)doneButton:(id)sender {
    
    if(![self.cellTextFieldArray[1].text isEqualToString: @""])
    {
        [self updateDate];
        [self.addProductTVDelegate productDidCreate:self.product];
        //chenged to isEditProduct = 0
        [self.addProductTVDelegate isDoneEditProducts];
        //close
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showAlertForDoneButtone];
    }
    self.amount = 1;
    self.chosenImage = nil;
}



- (void)updateDate
{
    //image - 0
    self.product.productImageName = self.foodImage;
    //if foodImage is not selected
    if(self.product.productImageName.length == 0)
    {
        self.product.productImageName = @"noimage";
    }
    self.product.productImage = self.chosenImage;
    //name - 1
    self.product.productName = self.cellTextFieldArray[1].text;
    //amount - 2
    self.product.productAmount = self.cellTextFieldArray[2].text.integerValue;
    //bestbefore //difference - 3
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    self.product.productBestBefore = [dateFormatter dateFromString:self.dateFromPicker];
    self.product.daysDifference = [NSString stringWithFormat:@"%ld", (long)[self compairDate:self.dateFromPicker]].integerValue;
    //type - 4
    self.product.productType = self.typeFromPicker;
    //price - 5
    self.product.productPrice = self.cellTextFieldArray[5].text.floatValue;
    //favourite - 6
    if(self.isSwichToggled == YES)
    {
        self.product.isFavourite = YES;
    }
    else if(self.isSwichToggled == NO)
    {
        self.product.isFavourite = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"SelectFoodImageSegue"])
    {
        UIViewController* uvc = segue.destinationViewController;
        ((SelectFoodImageTableViewController*)uvc).selectFoodImageDelegate = self;
        [self updateDate];
    }
    if([[segue identifier] isEqualToString:@"bestBeforeViewID"])
    {
        UIViewController* uvc = segue.destinationViewController;
        ((BestBeforeViewController*)uvc).bestBeforeViewDelegate = self;
        [self updateDate];
    }
    if([[segue identifier] isEqualToString:@"foodTypeViewID"])
    {
        UIViewController* uvc = segue.destinationViewController;
        ((FoodTypeViewController*)uvc).foodTypeViewDelegate = self;
        [self updateDate];
    }
}

-(void)imageDidSelect:(NSString*)foodImage
{
    self.foodImage = foodImage;
}

-(void)showAlertForDoneButtone
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert"message:@"Please input name!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)toggleSwich:(UISwitch *)sender {
//    self.isSwichToggled = YES;
    if (sender.on) {
        //self.label.text = @"ON";
        self.isSwichToggled = YES;
//        self.product.isFavourite = YES;
    } else {
        //self.label.text = @"OFF";
        self.isSwichToggled = NO;
//        self.product.isFavourite = NO;
    }
}

//imageAPI
- (NSString*)parseXML:productNameStr
{
    //NSXMLPerser inisialize
    NSString *url = [NSString stringWithFormat:@"https://api.icons8.com/api/iconsets/search?amount=1&term="];
    NSString *urlWithProductName = [NSString stringWithFormat:@"%@%@", url, productNameStr];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:urlWithProductName]];
    self.result = @"";
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    return self.result;
}

//1 delegate method (start)
-(void) parserDidStartDocument:(NSXMLParser *)parser{
    
    NSLog(@"start");
}

//2 delegate method (when first tag was read)
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    NSLog(@"%@",elementName);
    
    if ([elementName isEqualToString:@"png"]) {
        
        if([[attributeDict objectForKey:@"width"] isEqualToString:@"104"])
        {
            //get image url
            self.result = [attributeDict objectForKey:@"link"];
        }
    }
}

//3 delegate method (when string was read exept tag)
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    NSLog(@"%@", string);
}

//4 delegate method(when end tag was read)
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    NSLog(@"%@",elementName);
}

//5 delegate method(done)
-(void) parserDidEndDocument:(NSXMLParser *)parser{
    
    NSLog(@"done");
    
}

//for keyboard endEditing
- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)getCurrentDate
{
    NSDate* date = [NSDate date];
    
    NSTimeZone* worldTimeZone = [NSTimeZone timeZoneWithName:@"PST"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setTimeZone:worldTimeZone];
    [dateFormatter1 setDateFormat:@"dd-MM-yyyy"];
    
    NSString *currentPSTDateString = [dateFormatter1 stringFromDate:date];
    
    //NSString to NSDate
    NSDateFormatter* dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd-MM-yyyy"];
    //for timezone
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *currentPSTDate = [dateFormatter2 dateFromString:currentPSTDateString];
    self.currentDate = currentPSTDate;
    self.currentDateString = currentPSTDateString;
}

//How many days left from today until productBestBefore
-(NSInteger)compairDate:(NSString*)date
{
    //productBestBefore String -> NSDate
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *productBestBefore = [[NSDate alloc]init];
    productBestBefore = [formatter dateFromString:date];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self.currentDate toDate:productBestBefore options:0];
    NSInteger difference = [components day];
    
    return difference;
}

@end
