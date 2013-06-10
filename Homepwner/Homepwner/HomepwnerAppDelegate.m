//
//  HomepwnerAppDelegate.m
//  Homepwner
//
//  Created by Vladimir Efros on 6/10/13.
//  Copyright (c) 2013 Vladimir Efros. All rights reserved.
//

#import "HomepwnerAppDelegate.h"
#import "ItemsViewController.h"

@implementation HomepwnerAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create an instance of ItemsViewController.
    ItemsViewController *itemsViewController = [[ItemsViewController alloc] init];
    
    // Set itemsViewController as the rootViewController of the window.
    [[self window] setRootViewController:itemsViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
