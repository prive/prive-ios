//
//  CTAppDelegate.m
//  Prive
//
//  Created by Alexander Burkhai on 10/16/13.
//  Copyright (c) 2013 Caiguda. All rights reserved.
//

#import "CTAppDelegate.h"
#import "CTChatController.h"

@implementation CTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [CTChatController new];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
