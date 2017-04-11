//
//  AddFoodViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-27.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@protocol AddProductDelegate

-(void)productDidCreate:(Product*)product;

@end

@interface AddProductViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;


- (IBAction)doneButton:(id)sender;



@end
