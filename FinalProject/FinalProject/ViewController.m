//
//  ViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-23.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) UIView* inputsContainerView;
@property (strong, nonatomic) UIButton* addBasicRegisterButton;
@property (strong, nonatomic) UITextField* nameTextField;
@property (strong, nonatomic) UIView* nameSeparatorView;
@property (strong, nonatomic) UITextField* emailTextField;
@property (strong, nonatomic) UIView* emailSeparatorView;
@property (strong, nonatomic) UITextField* passwordTextField;

@end

@implementation ViewController

-(UIView *)inputsContainerView
{
    if(!_inputsContainerView)
    {
        _inputsContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _inputsContainerView.backgroundColor = [UIColor whiteColor];
        _inputsContainerView.translatesAutoresizingMaskIntoConstraints = false;
        _inputsContainerView.layer.cornerRadius = 5;
        _inputsContainerView.layer.masksToBounds = true;
        
    }
    return _inputsContainerView;
}


-(UIButton *)addBasicRegisterButton
{
    if(!_addBasicRegisterButton)
    {
        _addBasicRegisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addBasicRegisterButton.tintColor = [UIColor whiteColor];
        _addBasicRegisterButton.backgroundColor = [UIColor colorWithRed:7/255.0 green:160/255.0 blue:195/255.0 alpha:1.0];
        _addBasicRegisterButton.frame = CGRectMake(0,0,280,45);
        _addBasicRegisterButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    [_addBasicRegisterButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_addBasicRegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [_addBasicRegisterButton setExclusiveTouch:YES];
    
    return _addBasicRegisterButton;
}


-(UITextField *)addNameTextField
{
    if(!_nameTextField)
    {
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.placeholder = @"Name";
        _nameTextField.translatesAutoresizingMaskIntoConstraints = false;
        
    }
    return _nameTextField;
}

-(UIView *)addNameSeparatorView
{
       _nameSeparatorView = [[UIView alloc]init];
       _nameSeparatorView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
       _nameSeparatorView.translatesAutoresizingMaskIntoConstraints = false;
    
    return _nameSeparatorView;
}


-(UITextField *)addEmailTextField
{
    if(!_emailTextField)
    {
        _emailTextField = [[UITextField alloc]init];
        _emailTextField.placeholder = @"Email address";
        _emailTextField.translatesAutoresizingMaskIntoConstraints = false;
        
    }
    return _emailTextField;
}

-(UIView *)addEmailSeparatorView
{
        _emailSeparatorView = [[UIView alloc]init];
        _emailSeparatorView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        _emailSeparatorView.translatesAutoresizingMaskIntoConstraints = false;

    return _emailSeparatorView;
}

-(UITextField *)addPasswordTextField
{
    if(!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = false;
        _passwordTextField.secureTextEntry = true;
        
    }
    return _passwordTextField;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:219/255.0 green:217/255.0 blue:219/255.0 alpha:1.0];
    
    
    /*
        Basic Login
     */
    UIView *inputContainer = [self inputsContainerView];
    UIButton *button = [self addBasicRegisterButton];
    UITextField *nameTextField = [self addNameTextField];
    UIView *nameSeparatorView = [self addNameSeparatorView];
    UITextField *emailTextField = [self addEmailTextField];
    UIView *emailSeparatorView = [self addEmailSeparatorView];
    UITextField *passwordTextField = [self addPasswordTextField];

    [self.view addSubview:inputContainer];
    [self.view addSubview:button];
    
    [self.inputsContainerView addSubview:nameTextField];
    [self.inputsContainerView addSubview:nameSeparatorView];
    [self.inputsContainerView addSubview:emailTextField];
    [self.inputsContainerView addSubview:emailSeparatorView];
    [self.inputsContainerView addSubview:passwordTextField];
    
    [self setupInputsContainerView];
    [self setupLoginRegisterButton];
    
    
    /*
        Facebook
     */
    
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
             loginButton.backgroundColor = [UIColor darkGrayColor];
             loginButton.frame = CGRectMake(0,0,280,45);
             
             ////I need to think about Alignment later////
             loginButton.center = CGPointMake(185, 100);
             
             [loginButton setTitle: @"Facebook Login Button" forState: UIControlStateNormal];
             loginButton.delegate = self;
             loginButton.readPermissions =@[@"public_profile", @"email"];
             [self.view addSubview:loginButton];
             
             loginButton.hidden = false;
         }
     }];//The end of FIRAuth auth

}//The end of viewDidLoad



////Basic Login////

//container
-(void)setupInputsContainerView
{
    // InputsContainer need to declare x,y,width,height
    [self.inputsContainerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.inputsContainerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    [self.inputsContainerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor constant:-24].active = true;
    [self.inputsContainerView.heightAnchor constraintEqualToConstant:120].active = true;
    
    
    // NametextField need to declare x,y,width,height
    [self.nameTextField.leftAnchor constraintEqualToAnchor:self.inputsContainerView.leftAnchor constant:12].active = true;
    [self.nameTextField.topAnchor constraintEqualToAnchor:self.inputsContainerView.topAnchor constant:20].active = true;
    [self.nameTextField.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [self.nameTextField.heightAnchor constraintEqualToAnchor:self.inputsContainerView.heightAnchor multiplier:1/3].active = true;
    
    // NametextField need to declare x,y,width,height
    [_nameSeparatorView.leftAnchor constraintEqualToAnchor:self.inputsContainerView.leftAnchor].active = true;
    [_nameSeparatorView.topAnchor constraintEqualToAnchor:self.nameTextField.bottomAnchor constant:20].active = true;
    [_nameSeparatorView.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [_nameSeparatorView.heightAnchor constraintEqualToConstant:1].active = self;
    
    // EmailtextField need to declare x,y,width,height
    [self.emailTextField.leftAnchor constraintEqualToAnchor:self.inputsContainerView.leftAnchor constant:12].active = true;
    [self.emailTextField.topAnchor constraintEqualToAnchor:self.nameSeparatorView.bottomAnchor constant:20].active = true;
    [self.emailTextField.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [self.emailTextField.heightAnchor constraintEqualToAnchor:self.inputsContainerView.heightAnchor multiplier:1/3].active = true;
    
    // EmailtextField need to declare x,y,width,height
    [_emailSeparatorView.leftAnchor constraintEqualToAnchor:self.inputsContainerView.leftAnchor].active = true;
    [_emailSeparatorView.topAnchor constraintEqualToAnchor:self.emailTextField.bottomAnchor constant:20].active = true;
    [_emailSeparatorView.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [_emailSeparatorView.heightAnchor constraintEqualToConstant:1].active = self;
    
    // PasswordtextField need to declare x,y,width,height
    [self.passwordTextField.leftAnchor constraintEqualToAnchor:self.inputsContainerView.leftAnchor constant:12].active = true;
    [self.passwordTextField.topAnchor constraintEqualToAnchor:self.emailSeparatorView.bottomAnchor constant:20].active = true;
    [self.passwordTextField.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [self.passwordTextField.heightAnchor constraintEqualToAnchor:self.inputsContainerView.heightAnchor multiplier:1/3].active = true;
    
}


//button
-(void)setupLoginRegisterButton
{
    // need to declare x,y,width,height
    [self.addBasicRegisterButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.addBasicRegisterButton.topAnchor constraintEqualToAnchor:self.inputsContainerView.bottomAnchor constant:12].active = true;
    [self.addBasicRegisterButton.widthAnchor constraintEqualToAnchor:self.inputsContainerView.widthAnchor].active = true;
    [self.addBasicRegisterButton.heightAnchor constraintEqualToConstant:40].active = true;
}


-(void)buttonClicked:(UIButton*)sender
{
    NSLog(@"you clicked on button: %@", sender);
}



////Facebook////
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
