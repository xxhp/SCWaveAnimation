//
//  SCWaveAnimationViewController.m
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import "SCWaveAnimationViewController.h"
#import "SCWaveAnimationView.h"
#import "Globals.h"

@implementation SCWaveAnimationViewController
@synthesize animationDurationSlider;
@synthesize numberOfWavesSlider;
@synthesize spawnIntervalSlider;
@synthesize spawnSizeSlider;
@synthesize scaleFactorSlider;
@synthesize shadowRadiusSlider;

- (void)dealloc {
	[coordinatesLabel release];
	[animationDurationLabel release];
	[numberOfWavesLabel release];
	[spawnIntervalLabel release];
	[spawnSizeLabel release];
	[scaleFactorLabel release];
	[shadowRadiusLabel release];
	[animationDurationSlider release];
	[numberOfWavesSlider release];
	[spawnIntervalSlider release];
	[spawnSizeSlider release];
	[scaleFactorSlider release];
	[shadowRadiusSlider release];
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated
{
	[animationDurationLabel setText:[NSString stringWithFormat:@"%.2f sec", animationDurationSlider.value]];
	[numberOfWavesLabel setText:[NSString stringWithFormat:@"%.0f", numberOfWavesSlider.value]];
	[spawnIntervalLabel setText:[NSString stringWithFormat:@"%.2f sec", spawnIntervalSlider.value]];
	[spawnSizeLabel setText:[NSString stringWithFormat:@"%.0f px", spawnSizeSlider.value]];
	[scaleFactorLabel setText:[NSString stringWithFormat:@"%.2f", scaleFactorSlider.value]];
	[shadowRadiusLabel setText:[NSString stringWithFormat:@"%.0f", shadowRadiusSlider.value]];
	
	[[Globals sharedGlobals] setAnimationDuration:animationDurationSlider.value];
	[[Globals sharedGlobals] setNumberOfWaves:ceil(numberOfWavesSlider.value)];
	[[Globals sharedGlobals] setSpawnInterval:spawnIntervalSlider.value];
	[[Globals sharedGlobals] setSpawnSize:spawnSizeSlider.value];
	[[Globals sharedGlobals] setScaleFactor:scaleFactorSlider.value];
	[[Globals sharedGlobals] setShadowRadius:shadowRadiusSlider.value];
	
	[super viewWillAppear:animated];
}

- (IBAction) reset
{
	[[Globals sharedGlobals] setAnimationDuration:kAnimationDuration];
	[[Globals sharedGlobals] setNumberOfWaves:kNumberOfWaves];
	[[Globals sharedGlobals] setSpawnInterval:kSpawnInterval];
	[[Globals sharedGlobals] setSpawnSize:kWaveSpawnSize];
	[[Globals sharedGlobals] setScaleFactor:kAnimationScaleFactor];
	[[Globals sharedGlobals] setShadowRadius:kShadowRadius];
	
	[animationDurationSlider setValue:kAnimationDuration];
	[numberOfWavesSlider setValue:kNumberOfWaves];
	[spawnIntervalSlider setValue:kSpawnInterval];
	[spawnSizeSlider setValue:kWaveSpawnSize];
	[scaleFactorSlider setValue:kAnimationScaleFactor];
	[shadowRadiusSlider setValue:kShadowRadius];
	
	[animationDurationLabel setText:[NSString stringWithFormat:@"%.2f sec", animationDurationSlider.value]];
	[numberOfWavesLabel setText:[NSString stringWithFormat:@"%.0f", numberOfWavesSlider.value]];
	[spawnIntervalLabel setText:[NSString stringWithFormat:@"%.2f sec", spawnIntervalSlider.value]];
	[spawnSizeLabel setText:[NSString stringWithFormat:@"%.0f px", spawnSizeSlider.value]];
	[scaleFactorLabel setText:[NSString stringWithFormat:@"%.2f", scaleFactorSlider.value]];
	[shadowRadiusLabel setText:[NSString stringWithFormat:@"%.0f", shadowRadiusSlider.value]];
	
}

#pragma mark -
#pragma mark Slider action
- (IBAction) sliderMoved:(UISlider*)sender
{
	switch (sender.tag) {
		case SliderTagAnimationDuration:
			[animationDurationLabel setText:[NSString stringWithFormat:@"%.2f sec", sender.value]];
			[[Globals sharedGlobals] setAnimationDuration:animationDurationSlider.value];
			break;
		case SliderTagNumberOfWaves:
			[numberOfWavesLabel setText:[NSString stringWithFormat:@"%.0f", sender.value]];
			[[Globals sharedGlobals] setNumberOfWaves:ceil(numberOfWavesSlider.value)];
			break;
		case SliderTagSpawnInterval:
			[spawnIntervalLabel setText:[NSString stringWithFormat:@"%.2f sec", sender.value]];
			[[Globals sharedGlobals] setSpawnInterval:spawnIntervalSlider.value];
			break;
		case SliderTagSpawnSize:
			[spawnSizeLabel setText:[NSString stringWithFormat:@"%.0f px", sender.value]];
			[[Globals sharedGlobals] setSpawnSize:spawnSizeSlider.value];
			break;
		case SliderTagScaleFactor:
			[scaleFactorLabel setText:[NSString stringWithFormat:@"%.2f", sender.value]];
			[[Globals sharedGlobals] setScaleFactor:scaleFactorSlider.value];
			break;
		case SliderTagShadowRadius:
			[shadowRadiusLabel setText:[NSString stringWithFormat:@"%.0f", sender.value]];
			[[Globals sharedGlobals] setShadowRadius:shadowRadiusSlider.value];
			break;
		default:
			break;
	}
}


#pragma mark -
#pragma mark touch detection

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [[touches anyObject] locationInView:[[UIApplication sharedApplication] keyWindow]];
	[coordinatesLabel setText:[NSString stringWithFormat:@"%.0fx%.0fpx", touchPoint.x, touchPoint.y]];
	[SCWaveAnimationView waveAnimationAtPosition:touchPoint];
}



@end
