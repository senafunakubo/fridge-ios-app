//
//  ViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-23.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // For putting Facebook login
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.hidden = true;
    
    // For getting the currently signed-in user
    [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user)
     {
         if ([FIRAuth auth].currentUser)
         {
            // Move the User to the home screen
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             UIViewController *homeView = [storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
             [self presentViewController:homeView animated:YES completion:NULL];
             [self.loadingSpinner stopAnimating];
         }
         else
         {
            // Show the User the login button
            //// About where to put the button
             loginButton.center = self.view.center;
             loginButton.delegate = self;
             loginButton.readPermissions =
             @[@"public_profile", @"email"];
             [self.view addSubview:loginButton];
             
             loginButton.hidden = false;
         }
     }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"Did log out of Facebook.");
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    
    loginButton.hidden = true;
    [self.loadingSpinner startAnimating];
    
    if(error!=nil)
    {
        //handle errors here
        loginButton.hidden = false;
        [self.loadingSpinner stopAnimating];
        NSLog(@"Error");
    }
    else if(result.isCancelled)
    {
        //if User click the cancel button while they try to login
        loginButton.hidden = false;
        [self.loadingSpinner stopAnimating];
    }
    else
    {
        NSLog(@"Successfully logged in with facebook.");
        [self getFacebookData];
    }
}


-(void)getFacebookData
{
    FBSDKAccessToken *accessToken = [FBSDKAccessToken currentAccessToken];
    
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:accessToken
                                     .tokenString];
    
    //For adding data to Firebase App
    [[FIRAuth auth] signInWithCredential:credential completion:^(FIRUser *user, NSError *error)
     {
         if (error!=nil)
         {
             NSLog(@"Something went wrong with our FB user: %@",error);
             return;
         }
         else
         {
             NSLog(@"Successfully logged in to Firebase App with our user: %@",user);
         }
     }];
    
    //For getting detail data from User
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
     {
         if (error!=nil)
         {
             NSLog(@"Failed to start graph request: %@",error);
         }
         else
         {
             NSLog(@"fetched user: %@", result);
         }
         
     }];
    
}



@end
