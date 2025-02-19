//
//  FLDetailChallengeViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLChallenge.h"
#import "FLGenericViewController.h"
#import "FLProgressView.h"

@interface FLDetailChallengeViewController : FLGenericViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) FLChallenge * myChallenge;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *refuelButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet FLProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
- (IBAction)refuel:(id)sender;
- (IBAction)removeFuel:(id)sender;
- (IBAction)showInspiration:(id)sender;

@end
