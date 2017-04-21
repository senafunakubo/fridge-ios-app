//
//  AppDelegate.h
//  FinalProject
//
//  Created by AiYamamoto on 2017-03-23.
//  Copyright © 2017 CICCCa. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly, strong) FIRDatabaseReference * ref;


@end

