//
//  AddProductTableViewCell.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-05-14.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *addProductImage;
@property (weak, nonatomic) IBOutlet UITextField *addProductNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addProductAmoutTextField;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *addProductBestBeforeLabel;
@property (weak, nonatomic) IBOutlet UITextField *addProductBestBeforeTextField;
@property (weak, nonatomic) IBOutlet UILabel *daysDifference;
@property (weak, nonatomic) IBOutlet UITextField *addProductTypeTextField;
@property (weak, nonatomic) IBOutlet UILabel *addProductTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *addProductPriceTextField;

- (IBAction)valueChanged:(id)sender;

//todo
//- (IBAction)addProductImageViewButton:(id)sender;


@end
