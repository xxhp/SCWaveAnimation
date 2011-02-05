//
//  Globals.m
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import "Globals.h"
#import "SynthesizeSingleton.h"

@implementation Globals
@synthesize animationDuration;
@synthesize numberOfWaves;
@synthesize spawnInterval;
@synthesize spawnSize;
@synthesize scaleFactor;
@synthesize shadowRadius;

SYNTHESIZE_SINGLETON_FOR_CLASS(Globals)
@end
