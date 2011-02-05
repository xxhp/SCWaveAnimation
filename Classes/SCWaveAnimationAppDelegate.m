//
//  SCWaveAnimationAppDelegate.m
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import "SCWaveAnimationAppDelegate.h"
#import "SCWaveAnimationViewController.h"

@implementation SCWaveAnimationAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -
#pragma mark Memory management


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
