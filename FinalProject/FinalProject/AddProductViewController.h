//
//  AddFoodViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "SelectFoodImageTableViewController.h"
#import "UIScrollViewBackground.h"

@protocol AddProductDelegate

-(void)productDidCreate:(Product*)product;
-(int)isEditProducts;
-(Product*)getEditProduct;
@end

@interface AddProductViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource,SelectFoodImageDelegate>

@property (weak, nonatomic) id<AddProductDelegate> addProductDelegate;
@property (strong,nonatomic) Product* product;
@property (weak, nonatomic) IBOutlet UIImageView *addProductImageView;
@property (weak, nonatomic) IBOutlet UITextField *addProductNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductBestBeforeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductAmoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductSuperMarketTextField;
@property (weak, nonatomic) IBOutlet UISwitch *addProductIsFavouriteSwitch;
@property (weak, nonatomic) IBOutlet UITextView *addProductMemoTextView;
@property (strong,nonatomic) NSString* foodImage;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerNames;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic) BOOL isSwichToggled;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;

- (IBAction)toggleSwich:(id)sender;
- (IBAction)doneButton:(id)sender;
-(void)showAlertForDoneButtone;


@end
