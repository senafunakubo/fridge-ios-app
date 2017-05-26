//
//  AddProductTableViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-14.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductTableViewCell.h"
#import "SelectFoodImageTableViewController.h"
#import "BestBeforeViewController.h"
#import "FoodTypeViewController.h"
#import "Product.h"
@protocol AddProductTVDelegate
-(void)productDidCreate:(Product*)product;
-(int)isEditProducts;
-(void)isDoneEditProducts;
-(Product*)getEditProduct;

@end

@interface AddProductTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,SelectFoodImageDelegate,BestBeforeViewDelegate,FoodTypeViewDelegate,NSXMLParserDelegate>
//@property (weak, nonatomic) IBOutlet UIImageView *addProductImageView;
@property (weak, nonatomic) id<AddProductTVDelegate> addProductTVDelegate;
@property (strong, nonatomic) IBOutlet UITableView *addProductTableView;
@property (strong, nonatomic) NSArray * tableViewIDArray;

@property (strong,nonatomic) Product* product;
@property (strong,nonatomic) NSString* foodImage;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerNames;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic) BOOL isSwichToggled;
//imageAPL
@property (strong,nonatomic) NSString* imageUrl;
@property (strong,nonatomic) NSString* result;
//for keyboard
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) NSString *currentDateString;
@property (strong,nonatomic) NSString *dateFromPicker;
@property (strong, nonatomic) NSDateFormatter *dateformatter;

@property (strong,nonatomic) NSString* typeFromPicker;
@property (strong, nonatomic) NSMutableArray<UITextField*>* cellTextFieldArray;

- (IBAction)getImage:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;


- (IBAction)toggleSwich:(id)sender;
- (IBAction)doneButton:(id)sender;
-(void)showAlertForDoneButtone;

- (IBAction)valueChanged:(id)sender;
- (NSString*)parseXML:(NSString*)productNameStr;
- (void)updateDate;

-(void)getCurrentDate;

@end
