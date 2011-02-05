//
//  SCWaveAnimationView.h
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimationDuration 0.4f
#define kNumberOfWaves 2
#define kSpawnInterval 0.15f
#define kWaveSpawnSize 6.0f
#define kAnimationScaleFactor 8.0f
#define kShadowRadius 2.0f

#define kDebugCoordinates 0

@protocol SCWaveLayerDelegate <NSObject>
- (void) layerDidFinishAnimation;
@end

@interface SCWaveAnimationView : UIView <SCWaveLayerDelegate> {
	int wavesSpawned;
	int wavesDone;
	NSTimer* timer;
}
+ (void) waveAnimationAtPosition:(CGPoint)position;
+ (void) waveAnimationAtPosition:(CGPoint)position forView:(UIView*)view;
@end
