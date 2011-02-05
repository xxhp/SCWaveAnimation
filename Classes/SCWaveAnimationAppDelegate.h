//
//  SCWaveAnimationAppDelegate.h
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import <UIKit/UIKit.h>

@class SCWaveAnimationViewController;

@interface SCWaveAnimationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SCWaveAnimationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SCWaveAnimationViewController *viewController;

@end

