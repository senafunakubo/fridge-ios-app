//
//  ViewController.m
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-23.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) UIButton* addLoginRegisterButton;
@property (strong, nonatomic) UITextField* nameTextField;
@property (strong, nonatomic) UIView* nameSeparatorView;
@property (strong, nonatomic) UITextField* emailTextField;
@property (strong, nonatomic) UIView* emailSeparatorView;
@property (strong, nonatomic) UITextField* passwordTextField;
@property (strong, nonatomic) UISegmentedControl* loginRegisterSegmentedControl;
//@property (strong, nonatomic) UIActivityIndicatorView* indicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:219/255.0 green:217/255.0 blue:219/255.0 alpha:1.0];
    
//// If I have time, I'll set it.
//    UIActivityIndicatorView  *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(100.0, 100.0, 50.0, 50.0);
//    [self.view addSubview:indicator];
    
    /*
     
     Basic Login
     
     */

    UITextField *emailTextField = [self addEmailTextField];
    UITextField *passwordTextField = [self addPasswordTextField];
    UIButton *button = [self addLoginRegisterButton];
    UISegmentedControl *loginRegisterSeg = [self loginRegisterSegmentedControl];
    
    [self.view addSubview:button];
    [self.view addSubview:emailTextField];
    [self.view addSubview:passwordTextField];
    [self.view addSubview:loginRegisterSeg];
    
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
//             [indicator startAnimating];
             [self presentViewController:homeView animated:YES completion:NULL];

         }
         else
         {
             // Show the User the login button
             //// About where to put the button
             loginButton.backgroundColor = [UIColor darkGrayColor];
             loginButton.frame = CGRectMake(16,445,self.view.frame.size.width-32,50);
             
             [loginButton setTitle: @"Facebook Login Button" forState: UIControlStateNormal];
             loginButton.delegate = self;
             loginButton.readPermissions =@[@"public_profile", @"email"];
             [self.view addSubview:loginButton];
             
             loginButton.hidden = false;
         }
     }];//The end of FIRAuth auth

    
}//The end of viewDidLoad



//SegmentedControl
-(UISegmentedControl *)loginRegisterSegmentedControl
{
    
    if(!_loginRegisterSegmentedControl){
        _loginRegisterSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Login",@"Register"]];
        _loginRegisterSegmentedControl.tintColor = [UIColor colorWithRed:7/255.0 green:160/255.0 blue:195/255.0 alpha:1.0];
        _loginRegisterSegmentedControl.backgroundColor = [UIColor colorWithRed:219/255.0 green:217/255.0 blue:219/255.0 alpha:1.0];
        _loginRegisterSegmentedControl.frame = CGRectMake(23,130,self.view.frame.size.width-50,30);
       [_loginRegisterSegmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
        _loginRegisterSegmentedControl.translatesAutoresizingMaskIntoConstraints = true;
        _loginRegisterSegmentedControl.selectedSegmentIndex = 0;
    }
    return _loginRegisterSegmentedControl;
}

- (void)segmentAction:(UISegmentedControl *)segment
{
    switch (segment.selectedSegmentIndex) {
        case 0:
        // login
            [_addLoginRegisterButton setTitle:@"Login" forState:normal];
            [_nameTextField removeFromSuperview];
            break;
        case 1:
        // register
            [_addLoginRegisterButton setTitle:@"Register" forState:normal];
            UITextField *nameTextField = [self addNameTextField];
            [self.view addSubview:nameTextField];
            break;
    }
}



-(UIButton *)addLoginRegisterButton
{
    if(!_addLoginRegisterButton)
    {
        _addLoginRegisterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addLoginRegisterButton.tintColor = [UIColor whiteColor];
        _addLoginRegisterButton.backgroundColor = [UIColor colorWithRed:7/255.0 green:160/255.0 blue:195/255.0 alpha:1.0];
        _addLoginRegisterButton.frame = CGRectMake(0,0,280,45);
        _addLoginRegisterButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    [_addLoginRegisterButton addTarget:self action:@selector(handleLoginRegister:) forControlEvents:UIControlEventTouchUpInside];
    [_addLoginRegisterButton setTitle:@"Login" forState:UIControlStateNormal];
    [_addLoginRegisterButton setExclusiveTouch:YES];
    
    return _addLoginRegisterButton;
}


-(UITextField *)addNameTextField
{
    if(!_nameTextField)
    {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(16, 186, self.view.frame.size.width-32, 40)];
        _nameTextField.placeholder = @"Name";
        _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _nameTextField.font = [UIFont systemFontOfSize:15];
        _nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _nameTextField.keyboardType = UIKeyboardTypeDefault;
        _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTextField.translatesAutoresizingMaskIntoConstraints = true;
        _nameTextField.clearsOnBeginEditing = NO;
        _nameTextField.returnKeyType = UIReturnKeyDone;
        _nameTextField.delegate = self;
    }
    return _nameTextField;
}


-(UITextField *)addEmailTextField
{
    if(!_emailTextField)
    {
        _emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(16, 226, self.view.frame.size.width-32, 40)];
        _emailTextField.placeholder = @"Email address";
        _emailTextField.translatesAutoresizingMaskIntoConstraints = true;
        _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        _emailTextField.font = [UIFont systemFontOfSize:15];
        _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _emailTextField.keyboardType = UIKeyboardTypeDefault;
        _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailTextField.delegate = self;
    }
    return _emailTextField;
}


-(UITextField *)addPasswordTextField
{
    if(!_passwordTextField)
    {
        _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(16, 266, self.view.frame.size.width-32, 40)];
        _passwordTextField.placeholder = @"Password";
        _passwordTextField.translatesAutoresizingMaskIntoConstraints = true;
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _passwordTextField.secureTextEntry = true;
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}




//button
-(void)setupLoginRegisterButton
{
    // need to declare x,y,width,height
    [self.addLoginRegisterButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.addLoginRegisterButton.topAnchor constraintEqualToAnchor:self.passwordTextField.bottomAnchor constant:25].active = true;
    [self.addLoginRegisterButton.widthAnchor constraintEqualToAnchor:self.passwordTextField.widthAnchor].active = true;
    [self.addLoginRegisterButton.heightAnchor constraintEqualToConstant:40].active = true;
}

-(void)handleLoginRegister:(UIButton*)sender{
    if(_loginRegisterSegmentedControl.selectedSegmentIndex==0)
    {
        [self handleLogin:_addLoginRegisterButton];
    }
    else
    {
        [self handleRegister:_addLoginRegisterButton];
    }
}


-(void)handleLogin:(UIButton*)sender{
    [[FIRAuth auth]signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser* user, NSError* error)
     {
         if (error)
         {
             UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Username or Password is invalid."  message:nil  preferredStyle:UIAlertControllerStyleAlert];
             [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                 [self dismissViewControllerAnimated:YES completion:nil];
             }]];
             [self presentViewController:alertController animated:YES completion:nil];
             
             NSLog(@"login error!");
             return;
         }
         else //Successfully authenticated user
         {
             UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             UIViewController *homeView = [storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
             [self presentViewController:homeView animated:YES completion:NULL];
         }

     }
     ];
}

-(void)handleRegister:(UIButton*)sender
{
       [[FIRAuth auth]createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser* user, NSError* error)
        {
            if (error)
            {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"You missed typing somewhere."  message:nil  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                
                NSLog(@"error");
                return;
            }
            else
            {
                //Successfully authenticated user
                 NSLog(@"you clicked on button!");
                    self.loginId = self.nameTextField.text;
                    self.ref = [[FIRDatabase database]referenceFromURL:[NSString stringWithFormat:@"https://finalproject-2a4df.firebaseio.com/"]];
                    [self saveData:self.loginId email:self.emailTextField.text pass:self.passwordTextField.text];
                    {
                        if(error!=nil)
                        {
                            NSLog(@"something error");
                            return;
                        }
                        else
                        {
                            NSLog(@"Saved user Successfully into the firebase DB.");
                        }
                    }
            }
           
       }
       ];
}


- (void)saveData:(NSString *)userName email:(NSString *)email pass:(NSString *)pass
{
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSDictionary *post = @{@"uid": userID, @"author": userName, @"email": email, @"password": pass};
    NSDictionary *childUpdates = @{[NSString stringWithFormat:@"/users/%@", userID]: post};
    [_ref updateChildValues:childUpdates];
}


////Facebook////
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"Did log out of Facebook.");
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    
    loginButton.hidden = true;
    
    if(error!=nil)
    {
        //handle errors here
        loginButton.hidden = false;
        NSLog(@"Login Error");
    }
    else if(result.isCancelled)
    {
        //if User click the cancel button while they try to login
        loginButton.hidden = false;
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *retStr;
    retStr=self.nameTextField.text;
    NSLog(@"%@", retStr);
    return YES;
}
@end
