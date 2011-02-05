//
//  Globals.h
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import <Foundation/Foundation.h>


@interface Globals : NSObject {
	float animationDuration;
	int numberOfWaves;
	float spawnInterval;
	float spawnSize;
	float scaleFactor;
	float shadowRadius;
}
@property (assign) float animationDuration;
@property (assign) int numberOfWaves;
@property (assign) float spawnInterval;
@property (assign) float spawnSize;
@property (assign) float scaleFactor;
@property (assign) float shadowRadius;
+ (Globals*) sharedGlobals;
@end
