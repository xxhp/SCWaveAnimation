//
//  SCGradientButton.m
//  SCWaveAnimation
//
//  Created by rage on 2/6/11.
//  Copyright 2011 The Subjective-C. All rights reserved.
//

#import "SCGradientButton.h"

@interface SCGradientButton ()
@property (retain, nonatomic) CAGradientLayer* _gradientBackgroundLayer;
@property (retain, nonatomic) CAGradientLayer* _shineLayer;
- (void) setup;
- (void) redrawGradientInverted:(BOOL)inverted;
@end


@implementation SCGradientButton
@synthesize _gradientBackgroundLayer;
@synthesize _shineLayer;

#pragma mark Allocation and memory management
- (void) dealloc
{
	[_gradientBackgroundLayer release];
	[_shineLayer release];
	[super dealloc];
}

- (void)awakeFromNib
{
	[self setup];
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
	if (buttonType != UIButtonTypeRoundedRect) {
		NSLog(@"+[SCGradientButton buttonWithType:] does not accept buttonType other than UIButtonTypeRoundRect. UIButtonTypeRoundRect assumed.");
	}
	SCGradientButton* instance = [super buttonWithType:UIButtonTypeRoundedRect];
	return instance;
}

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setup];
	}
	return self;
}

#pragma mark -
#pragma mark Drawing

- (void) setup
{
	self._gradientBackgroundLayer = [CAGradientLayer layer];
	[_gradientBackgroundLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0].CGColor, nil]];
	[self.layer insertSublayer:_gradientBackgroundLayer atIndex:0];
	
	self._shineLayer = [CAGradientLayer layer];
	[_shineLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.05].CGColor, (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.20].CGColor, nil]];
	[self.layer insertSublayer:_shineLayer atIndex:1];
	
	[self.titleLabel setTextColor:[UIColor whiteColor]];
	
	[self.layer setCornerRadius:4.0];
	[self.layer setMasksToBounds:YES];
	[self.layer setBorderWidth:1.0];
}

- (void)layoutSubviews
{
	[_gradientBackgroundLayer setBounds:self.bounds];
	[_gradientBackgroundLayer setPosition:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
	[_shineLayer setFrame:CGRectMake(_gradientBackgroundLayer.frame.origin.x, _gradientBackgroundLayer.frame.origin.y, _gradientBackgroundLayer.frame.size.width, _gradientBackgroundLayer.frame.size.height/2)];
	
	[_gradientBackgroundLayer setNeedsLayout];
	[_shineLayer setNeedsLayout];
}

- (void) redrawGradientInverted:(BOOL)inverted
{
	CGColorRef lowColor;
	
	if (self.enabled) {
		lowColor = [UIColor colorWithRed:0.0 green:0.36 blue:0.0 alpha:1.0].CGColor;
	} else {
		lowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
	}

	const CGFloat* lowComponents = CGColorGetComponents(lowColor);
	CGColorRef highColor = [UIColor colorWithRed:MIN(1.0, lowComponents[0]+0.5) green:MIN(1.0, lowComponents[1]+0.5) blue:MIN(1.0, lowComponents[2]+0.5) alpha:1.0].CGColor;
	
	if (inverted) {
		[_gradientBackgroundLayer setColors:[NSArray arrayWithObjects:(id)lowColor, (id)highColor, nil]];
	} else {
		[_gradientBackgroundLayer setColors:[NSArray arrayWithObjects:(id)highColor, (id)lowColor, nil]];
	}

	[_gradientBackgroundLayer setNeedsLayout];
}

#pragma mark -
#pragma mark Actions

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	//Redraw gradient
	[self redrawGradientInverted:YES];
	[_shineLayer setHidden:YES];
	
	return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	//Redraw gradient
	[self redrawGradientInverted:NO];
	[_shineLayer setHidden:NO];
	
	[super endTrackingWithTouch:touch withEvent:event];
}

@end
