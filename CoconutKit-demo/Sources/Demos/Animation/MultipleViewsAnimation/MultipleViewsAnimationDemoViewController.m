//
//  MultipleViewsAnimationDemoViewController.m
//  CoconutKit-demo
//
//  Created by Samuel Défago on 2/13/11.
//  Copyright 2011 Hortis. All rights reserved.
//

#import "MultipleViewsAnimationDemoViewController.h"

@interface MultipleViewsAnimationDemoViewController ()

@property (nonatomic, retain) HLSAnimation *animation;
@property (nonatomic, retain) HLSAnimation *reverseAnimation;

@end

@implementation MultipleViewsAnimationDemoViewController

#pragma mark Object creation and destruction

- (id)init
{
    if ((self = [super initWithNibName:[self className] bundle:nil])) {
        
    }
    return self;
}

- (void)releaseViews
{
    [super releaseViews];
    
    [self.animation cancel];
    self.animation = nil;
    
    [self.reverseAnimation cancel];
    self.reverseAnimation = nil;
    
    self.rectangleView1 = nil;
    self.rectangleView2 = nil;
    self.rectangleView3 = nil;
    self.rectangleView4 = nil;
    self.playForwardButton = nil;
    self.playBackwardButton = nil;
    self.cancelButton = nil;
    self.animatedSwitch = nil;
    self.blockingSwitch = nil;
    self.resizingSwitch = nil;
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.playBackwardButton.hidden = YES;
    self.cancelButton.hidden = YES;
    
    self.animatedSwitch.on = YES;
    self.blockingSwitch.on = NO;
    self.resizingSwitch.on = NO;
}

#pragma mark Accessors and mutators

@synthesize rectangleView1 = m_rectangleView1;

@synthesize rectangleView2 = m_rectangleView2;

@synthesize rectangleView3 = m_rectangleView3;

@synthesize rectangleView4 = m_rectangleView4;

@synthesize playForwardButton = m_playForwardButton;

@synthesize playBackwardButton = m_playBackwardButton;

@synthesize cancelButton = m_cancelButton;

@synthesize animatedSwitch = m_animatedSwitch;

@synthesize blockingSwitch = m_blockingSwitch;

@synthesize resizingSwitch = m_resizingSwitch;

@synthesize animation = m_animation;

@synthesize reverseAnimation = m_reverseAnimation;

#pragma mark Orientation management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (! [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]) {
        return NO;
    }
    
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

#pragma mark Event callbacks

- (IBAction)playForwardButtonClicked:(id)sender
{
    self.playForwardButton.hidden = YES;
    self.cancelButton.hidden = NO;
    
    HLSAnimationStep *animationStep1 = [HLSAnimationStep animationStep];
    animationStep1.duration = 2.;
    HLSViewAnimationStep *viewAnimationStep11 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep11.transform = CGAffineTransformMakeTranslation(50.f, 60.f);    
    [animationStep1 addViewAnimationStep:viewAnimationStep11 forView:self.rectangleView1];
    HLSViewAnimationStep *viewAnimationStep12 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep12.transform = CGAffineTransformMakeTranslation(40.f, -10.f);
    viewAnimationStep12.alphaVariation = -0.4f;
    [animationStep1 addViewAnimationStep:viewAnimationStep12 forView:self.rectangleView2];
    HLSViewAnimationStep *viewAnimationStep13 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep13.transform = CGAffineTransformMakeTranslation(0.f, -100.f);
    [animationStep1 addViewAnimationStep:viewAnimationStep13 forView:self.rectangleView3];
    HLSViewAnimationStep *viewAnimationStep14 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep14.alphaVariation = -0.8f;
    [animationStep1 addViewAnimationStep:viewAnimationStep14 forView:self.rectangleView4];
    
    // Can also apply the same view animation step to all views
    HLSAnimationStep *animationStep2 = [HLSAnimationStep animationStep];
    animationStep2.duration = 1.;
    HLSViewAnimationStep *viewAnimationStep2 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep2.transform = CGAffineTransformMakeTranslation(80.f, 0.f);
    [animationStep2 addViewAnimationStep:viewAnimationStep2 forView:self.rectangleView1];
    [animationStep2 addViewAnimationStep:viewAnimationStep2 forView:self.rectangleView2];
    [animationStep2 addViewAnimationStep:viewAnimationStep2 forView:self.rectangleView3];
    [animationStep2 addViewAnimationStep:viewAnimationStep2 forView:self.rectangleView4];
    
    HLSAnimationStep *animationStep3 = [HLSAnimationStep animationStep];
    animationStep3.duration = 0.5;
    HLSViewAnimationStep *viewAnimationStep31 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep31.transform = CGAffineTransformMakeScale(1.5f, 2.f);
    [animationStep3 addViewAnimationStep:viewAnimationStep31 forView:self.rectangleView1];
    HLSViewAnimationStep *viewAnimationStep32 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep32.transform = CGAffineTransformMakeScale(2.f, 1.5f);
    viewAnimationStep32.alphaVariation = -0.3f;
    [animationStep3 addViewAnimationStep:viewAnimationStep32 forView:self.rectangleView2];
    HLSViewAnimationStep *viewAnimationStep33 = [HLSViewAnimationStep viewAnimationStep];
    viewAnimationStep33.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    [animationStep3 addViewAnimationStep:viewAnimationStep33 forView:self.rectangleView3];
            
    // Create the animation and play it
    self.animation = [HLSAnimation animationWithAnimationSteps:[NSArray arrayWithObjects:animationStep1,
                                                                animationStep2,
                                                                animationStep3,
                                                                nil]];
    self.animation.tag = @"multipleViewsAnimation";
    self.animation.resizeViews = self.resizingSwitch.on;
    self.animation.lockingUI = self.blockingSwitch.on;
    self.animation.delegate = self;
    [self.animation playAnimated:self.animatedSwitch.on];
}

- (IBAction)playBackwardButtonClicked:(id)sender
{
    self.playBackwardButton.hidden = YES;
    self.cancelButton.hidden = NO;
    
    // Create the reverse animation
    self.reverseAnimation = [self.animation reverseAnimation];
    self.reverseAnimation.lockingUI = self.blockingSwitch.on;
    [self.reverseAnimation playAnimated:self.animatedSwitch.on];
}

- (IBAction)cancelButtonClicked:(id)sender
{
    if (self.animation.running) {
        self.playBackwardButton.hidden = NO;
        [self.animation cancel];        
    }
    if (self.reverseAnimation.running) {
        self.playForwardButton.hidden = NO;
        [self.reverseAnimation cancel];
    }
    
    self.cancelButton.hidden = YES;
}

#pragma mark HLSAnimationDelegate protocol implementation

- (void)animationWillStart:(HLSAnimation *)animation animated:(BOOL)animated
{
    HLSLoggerInfo(@"Animation %@, animated = %@", animation.tag, HLSStringFromBool(animated));
}

- (void)animationStepFinished:(HLSAnimationStep *)animationStep animated:(BOOL)animated
{
    HLSLoggerInfo(@"Animated = %@", HLSStringFromBool(animated));
}

- (void)animationDidStop:(HLSAnimation *)animation animated:(BOOL)animated
{
    HLSLoggerInfo(@"Animation %@, animated = %@", animation.tag, HLSStringFromBool(animated));
    
    // Can find which animation ended using its tag
    if ([animation.tag isEqual:@"multipleViewsAnimation"]) {
        self.playBackwardButton.hidden = NO;
    }
    else if ([animation.tag isEqual:@"reverse_multipleViewsAnimation"]) {
        self.playForwardButton.hidden = NO;
    }
    
    self.cancelButton.hidden = YES;
}

#pragma mark Localization

- (void)localize
{
    [super localize];
    
    self.title = NSLocalizedString(@"Multiple view animation", @"Multiple view animation");
}

@end
