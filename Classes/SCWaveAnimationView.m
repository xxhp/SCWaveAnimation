//
//  SCWaveAnimationView.m
//  SCWaveAnimation
//
//  Created by Marton Fodor on 2/2/11.
//  Copyright 2011 The Subjective-C. No rights reserved.
//

#import "SCWaveAnimationView.h"
#import <QuartzCore/QuartzCore.h>
#import "Globals.h"

@interface SCWaveLayer : CALayer
{
	id<SCWaveLayerDelegate> parentView;
}
@property (assign) id<SCWaveLayerDelegate> parentView;
- (void) startAnimation;
@end

@implementation SCWaveLayer
@synthesize parentView;

- (void)dealloc
{
    [self removeAllAnimations];
    [super dealloc];
}

- (void)drawInContext:(CGContextRef)theContext
{
    CGContextSetRGBStrokeColor(theContext, 255, 0, 0, 1.0);
    CGContextSetLineWidth(theContext, 1.5f);
    CGContextStrokeEllipseInRect(theContext, CGRectMake(self.bounds.size.width/2-([[Globals sharedGlobals] spawnSize]/2), self.bounds.size.height/2-([[Globals sharedGlobals] spawnSize]/2), [[Globals sharedGlobals] spawnSize], [[Globals sharedGlobals] spawnSize]));
}

- (void) startAnimation
{
	CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	scaleAnimation.duration = [[Globals sharedGlobals] animationDuration];
	scaleAnimation.delegate = self;
	scaleAnimation.repeatCount = 0;
	scaleAnimation.removedOnCompletion = FALSE;
	scaleAnimation.fillMode = kCAFillModeForwards;
	scaleAnimation.toValue = [NSNumber numberWithFloat:[[Globals sharedGlobals] scaleFactor]];
	[self addAnimation:scaleAnimation forKey:@"scale"];
	
	CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	opacityAnimation.duration = [[Globals sharedGlobals] animationDuration];
	opacityAnimation.repeatCount = 0;
	opacityAnimation.removedOnCompletion = FALSE;
	opacityAnimation.fillMode = kCAFillModeForwards;
	opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
	[self addAnimation:opacityAnimation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	if ([parentView respondsToSelector:@selector(layerDidFinishAnimation)]) {
		[parentView layerDidFinishAnimation];
	}
}

@end


@interface SCWaveAnimationView ()
- (void) spawnWave;
@end


@implementation SCWaveAnimationView

- (void)dealloc {
    [timer invalidate];
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(setParentView:) withObject:nil];
    [super dealloc];
}

+ (void) waveAnimationAtPosition:(CGPoint)position
{
	[self waveAnimationAtPosition:position forView:[[UIApplication sharedApplication] keyWindow]];
}

+ (void) waveAnimationAtPosition:(CGPoint)position forView:(UIView*)view
{
	SCWaveAnimationView* waveAnimationView = [[[self alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] autorelease];
	[waveAnimationView setCenter:position];
	if (nil != view) {
		[view addSubview:waveAnimationView];
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		wavesSpawned = 0;
		wavesDone = 0;

#if kDebugCoordinates==1
		UIView* xView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
		[xView setBackgroundColor:[UIColor blueColor]];
		[xView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
		[self addSubview:xView];
		
		UIView* yView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.bounds.size.height)];
		[yView setBackgroundColor:[UIColor blueColor]];
		[yView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
		[self addSubview:yView];
#endif
		[self spawnWave];
		if (1<[[Globals sharedGlobals] numberOfWaves]) {
            double spawnInterval = [[Globals sharedGlobals] spawnInterval];
            if (!spawnInterval > kAnimationDuration*1.25) {
                spawnInterval = kAnimationDuration*1.25;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:spawnInterval target:self selector:@selector(spawnWave) userInfo:nil repeats:YES];
		}
    }
    return self;
}

- (void) spawnWave
{
	SCWaveLayer* wave = [SCWaveLayer layer];
	[wave setBounds:CGRectMake(0, 0, [[Globals sharedGlobals] spawnSize]+[[Globals sharedGlobals] shadowRadius]+2, [[Globals sharedGlobals] spawnSize]+[[Globals sharedGlobals] shadowRadius]+2)];
	wave.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	
	wave.shadowColor = [UIColor redColor].CGColor;
	wave.shadowOffset = CGSizeMake(0, 0);
	wave.shadowOpacity = 1.0;
	wave.shadowRadius = [[Globals sharedGlobals] shadowRadius];
	
	[wave setParentView:self];
	[self.layer addSublayer:wave];
	[wave setNeedsDisplay];
	[wave startAnimation];
	
	wavesSpawned++;
	if (wavesSpawned == [[Globals sharedGlobals] numberOfWaves]) {
		[timer invalidate];
		/*
		 * - (void)invalidate
		 *
		 * "The NSRunLoop object removes and releases the timer,
		 * either just before the invalidate method returns or at some later point."
		 *
		 */
		timer = nil;
	}
}

- (void) layerDidFinishAnimation
{
	wavesDone++;
	if (wavesDone==wavesSpawned) {
		[self removeFromSuperview];
	}
}

@end
