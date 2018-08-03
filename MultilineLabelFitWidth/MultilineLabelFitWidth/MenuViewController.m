//
//  MenuViewController.m
//  MultilineLabelFitWidth
//
//  Created by Don Mag on 8/3/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

#import "MenuViewController.h"

#import "TestViewController.h"
#import "ManualTestViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *b1 = [UIButton buttonWithType:UIButtonTypeSystem];
	b1.translatesAutoresizingMaskIntoConstraints = NO;
	
	[b1 setTitle:@"With Autolayout" forState:UIControlStateNormal];
	[b1 addTarget:self action:@selector(autolayoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
	b2.translatesAutoresizingMaskIntoConstraints = NO;

	[b2 setTitle:@"Without Autolayout" forState:UIControlStateNormal];
	[b2 addTarget:self action:@selector(manuallayoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:b1];
	[self.view addSubview:b2];

	[b1.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:160.0].active = YES;
	[b1.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0.0].active = YES;

	[b2.topAnchor constraintEqualToAnchor:b1.bottomAnchor constant:80.0].active = YES;
	[b2.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:0.0].active = YES;

}

- (void) autolayoutButtonTapped:(UIButton *)sender {

	TestViewController *vc = [TestViewController new];
	[self.navigationController pushViewController:vc animated:YES];
	
}

- (void) manuallayoutButtonTapped:(UIButton *)sender {
	
	ManualTestViewController *vc = [ManualTestViewController new];
	[self.navigationController pushViewController:vc animated:YES];
	
}

@end
