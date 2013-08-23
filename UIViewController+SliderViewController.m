//
//  UIViewController+SliderViewController.m
//  SliderMenuL2R
//
//  Created by wukai on 13-8-23.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "UIViewController+SliderViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SliderBackgroundView.h"

#define SliderModealAnimationDuration 0.35
#define SourceViewTag 23941
#define SliderViewTag 23942
#define BackgroundViewTag 23943
#define OverlayViewTag 23945

@interface UIViewController (SliderViewControllerPrivate)
- (UIView *)topView;
- (void)presentPopupView :(UIView *)pupupView;

@end

@implementation UIViewController (SliderViewController)
//呈现视图

- (void)presentSliderViewController:(UIViewController *)sliderViewController animationType:(SliderViewAnimation)animationType
{
	[self presentSliderView:sliderViewController.view
			  animationType:SliderViewAnimationSliderL2R];
}
//视图滑出
- (void)dismissSliderViewControllerWithAnimationType:(SliderViewAnimation)animationType
{
	UIView *sourceView = [self topView];
	UIView *sliderView = [sourceView viewWithTag:SliderViewTag];
	UIView *overlayView = [sourceView viewWithTag:OverlayViewTag];
	
	[self sliderViewOut:sliderView
			 sourceView:sourceView
			overlayView:overlayView
	  withAnimationType:animationType];
}

- (UIView *)topView
{
	UIViewController *recentView = self;
	while (recentView.parentViewController != nil) {
		recentView = recentView.parentViewController;
	}
	return recentView.view;
}


- (void)presentSliderView:(UIView *)sliderView
			animationType:(SliderViewAnimation)animationType
{
	UIView *sourceView = [self topView];
	sourceView.tag = SourceViewTag;
	sliderView.tag = SliderViewTag;
	
	if ([sourceView.subviews containsObject:sliderView]) {
		return;
	}
	
	//自定义sliderView参数
	sliderView.layer.shadowPath = [UIBezierPath bezierPathWithRect:sliderView.bounds].CGPath;
	sliderView.layer.masksToBounds = NO;
	sliderView.layer.shadowOffset = CGSizeMake(5, 5);
	sliderView.layer.shadowRadius = 5;
	sliderView.layer.shadowOpacity = 0.5;
	
	//overLayView
	UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
	overlayView.tag = OverlayViewTag;
	overlayView.backgroundColor = [UIColor clearColor];
	
	//backgroundView
	SliderBackgroundView *backgroundView = [[SliderBackgroundView alloc]
											initWithFrame:sourceView.bounds];
	backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	backgroundView.tag = BackgroundViewTag;
	backgroundView.backgroundColor = [UIColor clearColor];
	backgroundView.alpha = 0.0f;
	[overlayView addSubview:backgroundView];
	
	//clear button
	UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
	dismissButton.backgroundColor = [UIColor clearColor];
	dismissButton.frame = sourceView.bounds;
	[overlayView addSubview:dismissButton];
	
	//popupView
	sliderView.alpha = 0.0f;
	
	[overlayView addSubview:sliderView];
	[sourceView addSubview:overlayView];
	
	if (animationType == SliderViewAnimationSliderL2R) {
		[dismissButton addTarget:self action:@selector(dismissSliderViewControllerWithAnimationSliderTypeL2R) forControlEvents:UIControlEventTouchUpInside];
		[self sliderViewIn:sliderView sourceView:sourceView
			   overlayView:overlayView
		 withAnimationType:SliderViewAnimationSliderL2R];
		
	}else if (animationType == SliderViewAnimationSliderR2L){
		[dismissButton addTarget:self action:@selector(dismissSliderViewControllerWithAnimationTypeSliderR2L)
				forControlEvents:UIControlEventTouchUpInside ];
		[self sliderViewIn:sliderView
				sourceView:sourceView
			   overlayView:overlayView
		 withAnimationType:SliderViewAnimationSliderR2L];
	}
}

- (void)dismissSliderViewControllerWithAnimationSliderTypeL2R
{
	[self dismissSliderViewControllerWithAnimationType:SliderViewAnimationSliderL2R];
}

- (void)dismissSliderViewControllerWithAnimationTypeSliderR2L
{
	[self dismissSliderViewControllerWithAnimationType:SliderViewAnimationSliderR2L];
}


// slider in
- (void)sliderViewIn:(UIView *)sliderView sourceView:(UIView *)sourceView
		 overlayView:(UIView *)overlayView
   withAnimationType:(SliderViewAnimation)animationType
{
	UIView *backgroundView = [overlayView viewWithTag:BackgroundViewTag];
	CGSize sourceSize = sourceView.bounds.size;
	CGSize sliderSize = sliderView.bounds.size;
	CGRect sliderStartRect;
	CGRect sliderEndRect;
	
	if (animationType == SliderViewAnimationSliderL2R) {
		sliderStartRect = CGRectMake(-sliderSize.width,
									 0,
									 sliderSize.width,
									 sliderSize.height);
		sliderEndRect = CGRectMake(0, 0, sliderSize.width, sliderSize.height);
		
	}else if (animationType == SliderViewAnimationSliderR2L){
		sliderStartRect = CGRectMake(sourceSize.width,
									0,
									 sliderSize.width,
									 sliderSize.height);
		sliderEndRect = CGRectMake(sourceSize.width-sliderSize.width,
								   0,
								   sliderSize.width,
								   sliderSize.height);
	}
	
	sliderView.frame = sliderStartRect;
	sliderView.alpha = 1.0f;
	[UIView animateWithDuration:SliderModealAnimationDuration delay:0.0f options:UIViewAnimationCurveEaseOut animations:^{
        backgroundView.alpha = 1.0f;
        sliderView.frame = sliderEndRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)sliderViewOut:(UIView *)sliderView sourceView:(UIView *)sourceView
		  overlayView:(UIView *)overlayView
	withAnimationType:(SliderViewAnimation)animationType
{
	UIView *backgroundView = [overlayView viewWithTag:BackgroundViewTag];
	CGSize sourceSize = sourceView.bounds.size;
	CGSize sliderSize = sliderView.bounds.size;
	CGRect sliderEndRect;
	
	if (animationType == SliderViewAnimationSliderL2R) {
		sliderEndRect = CGRectMake(-sliderSize.width,
								   0,
								   sliderSize.width,
								   sliderSize.height);
	}else if (animationType == SliderViewAnimationSliderR2L)
		{
		sliderEndRect = CGRectMake(sourceSize.width,
								   0,
								   sliderSize.width,
								   sliderSize.height);
		}
	
	[UIView animateWithDuration:SliderModealAnimationDuration
						  delay:0.0f
						options:UIViewAnimationCurveEaseIn
					 animations:^{
        sliderView.frame = sliderEndRect;
        backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [sliderView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];

}
// slider out
@end
