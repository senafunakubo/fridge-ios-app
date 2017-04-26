//
//  ViewController.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-23.
//  Copyright © 2017 CICCCa. All rights reserved.
//
//http://chilitsumo.com/application/iphone-uicollectionview-sample
 
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import FirebaseAuth;
@import Firebase;

@interface ViewController : UIViewController<FBSDKLoginButtonDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@end

