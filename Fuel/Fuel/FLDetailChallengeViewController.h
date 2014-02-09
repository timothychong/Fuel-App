//
//  FLDetailChallengeViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLChallenge.h"

@interface FLDetailChallengeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) FLChallenge * myChallenge;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
- (IBAction)refuel:(id)sender;

@end
