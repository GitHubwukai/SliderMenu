//
//  ViewController.m
//  SliderMenuL2R
//
//  Created by wukai on 13-8-23.
//  Copyright (c) 2013年 wukai. All rights reserved.
//

#import "ViewController.h"
#import "SliderMenuController.h"
#import "UIViewController+SliderViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tap:(id)sender {
	SliderMenuController *detailViewController = [[SliderMenuController alloc]initWithNibName:@"SliderMenuController" bundle:nil];
	[self presentSliderViewController:detailViewController animationType:SliderViewAnimationSliderL2R];
}

@end
