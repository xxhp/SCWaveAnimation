//
//  SCWaveAnimationView.h
//  iPrototype
//
//  Created by rage on 2/2/11.
//  Copyright 2011 The Subjective-C. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimationDuration 0.5
#define kNumberOfWaves 2
#define kSpawnInterval 0.3
#define kWaveSpawnSize 6
#define kAnimationScaleFactor 8

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
