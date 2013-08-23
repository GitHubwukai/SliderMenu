//
//  UIViewController+SliderViewController.h
//  SliderMenuL2R
//
//  Created by wukai on 13-8-23.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
	SliderViewAnimationSliderL2R = 1,
	SliderViewAnimationSliderR2L
} SliderViewAnimation;

@interface UIViewController (SliderViewController)
- (void)presentSliderViewController:(UIViewController *)sliderViewController animationType:(SliderViewAnimation)animationType;

- (void)dismissSliderViewControllerWithAnimationType:(SliderViewAnimation)animationType;

@end
