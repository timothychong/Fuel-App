//
//  FLRefuelViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLChallenge.h"

@interface FLRefuelViewController : UIViewController
- (IBAction)goBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) FLChallenge * myChallenge;
@end
