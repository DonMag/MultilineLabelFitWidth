//
//  ManualTestViewController.m
//  MultilineLabelFitWidth
//
//  Created by Don Mag on 8/3/18.
//  Copyright © 2018 DonMag. All rights reserved.
//

#import "ManualTestViewController.h"

@interface ManualTestViewController ()

@property (strong, nonatomic) UIButton *myButton;

@property (strong, nonatomic) UILabel *myLabel;

@end

NSInteger iCounterM = 0;

@implementation ManualTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.backgroundColor = [UIColor colorWithRed:160.0 / 255.0 green:160.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
	
	// instatiate the button
	_myButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	// add it to the view
	[self.view addSubview:_myButton];

	_myButton.frame = CGRectMake(0, 0, 200.0, 30.0);
	_myButton.center = CGPointMake(self.view.center.x, 140.0);
	
	// instantiate a label
	_myLabel = [UILabel new];
	
	// add it to the view
	[self.view addSubview:_myLabel];
	
	_myLabel.frame = CGRectMake(0, 200, 200.0, 30.0);
	_myLabel.center = CGPointMake(self.view.center.x, _myLabel.center.y);
	
	// set the label's font, centered alignment, multi-line
	_myLabel.font = [UIFont systemFontOfSize:20.0];
	_myLabel.textAlignment = NSTextAlignmentCenter;
	_myLabel.numberOfLines = 0;
	
	// label colors
	_myLabel.textColor = [UIColor blackColor];
	_myLabel.backgroundColor = [UIColor yellowColor];
	
	// label's initial text
	_myLabel.text = @"Initial Text";
	
	// set the button's colors, title and target
	[_myButton setBackgroundColor:[UIColor whiteColor]];
	[_myButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[_myButton setTitle:@"Tap to Change Text" forState:UIControlStateNormal];
	[_myButton addTarget:self action:@selector(changeTextTapped:) forControlEvents:UIControlEventTouchUpInside];
	
}

- (void) viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
	// adjust the width of the label
	[self adjustFrameForLabel:_myLabel];
	
}

-(void) changeTextTapped:(UIButton*)sender {
	
	NSString *theString = @"";
	
	switch (iCounterM) {
		case 0:
			theString = @"A short string";
			break;
			
		case 1:
			theString = @"This is a long string that will cause word wrapping in the label (assuming the view is relatively narrow).";
			break;
			
		case 2:
			theString = @"This is a string with a VeryVeryLongWordInIt that will cause different wrapping in the label (assuming the view is relatively narrow).";
			break;
			
		case 3:
			theString = @"This string\nhas embedded line breaks\nto demonstrate\nproper sizing to longest \"line.\"";
			break;
			
		default:
			break;
	}
	
	// change the text of the label
	_myLabel.text = theString;
	
	// adjust the width of the label
	[self adjustFrameForLabel:_myLabel];
	
	// increment our "change text counter"
	if (++iCounterM > 3) {
		iCounterM = 0;
	}
	
}

-(void) adjustFrameForLabel:(UILabel *)theLabel {
	
	// get the label's container / superview
	UIView *theContainingView = [theLabel superview];
	
	// don't try this if the label is not a subview
	if (!theContainingView) {
		return;
	}
	
	// get the font of the label
	UIFont *theFont = theLabel.font;
	
	// get the text of the label
	NSString *theString = theLabel.text;
	
	// calculate the bounding rect, limiting the width to the width of the view
	CGRect r = [theString boundingRectWithSize:CGSizeMake(theContainingView.frame.size.width, CGFLOAT_MAX)
									   options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
									attributes:@{ NSFontAttributeName: theFont}
									   context:nil];
	
	// change the constant of the constraint to the calculated width
	CGRect newRect = theLabel.frame;
	newRect.size = r.size;
	theLabel.frame = newRect;
	theLabel.center = CGPointMake(self.view.center.x, theLabel.center.y);

}

@end
