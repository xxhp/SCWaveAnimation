//
//  SCWaveAnimationViewController.h
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	SliderTagAnimationDuration = 0,
	SliderTagNumberOfWaves,
	SliderTagSpawnInterval,
	SliderTagSpawnSize,
	SliderTagScaleFactor,
	SliderTagShadowRadius
} SliderTag;

@interface SCWaveAnimationViewController : UIViewController {
	IBOutlet UILabel*	coordinatesLabel;
	IBOutlet UILabel*	animationDurationLabel;
	IBOutlet UILabel*	numberOfWavesLabel;
	IBOutlet UILabel*	spawnIntervalLabel;
	IBOutlet UILabel*	spawnSizeLabel;
	IBOutlet UILabel*	scaleFactorLabel;
	IBOutlet UILabel*	shadowRadiusLabel;
	IBOutlet UISlider*	animationDurationSlider;
	IBOutlet UISlider*	numberOfWavesSlider;
	IBOutlet UISlider*	spawnIntervalSlider;
	IBOutlet UISlider*	spawnSizeSlider;
	IBOutlet UISlider*	scaleFactorSlider;
	IBOutlet UISlider*	shadowRadiusSlider;
}
@property (retain, nonatomic) UISlider*	animationDurationSlider;
@property (retain, nonatomic) UISlider*	numberOfWavesSlider;
@property (retain, nonatomic) UISlider*	spawnIntervalSlider;
@property (retain, nonatomic) UISlider*	spawnSizeSlider;
@property (retain, nonatomic) UISlider*	scaleFactorSlider;
@property (retain, nonatomic) UISlider*	shadowRadiusSlider;

- (IBAction) sliderMoved:(UISlider*)sender;
- (IBAction) reset;
@end

