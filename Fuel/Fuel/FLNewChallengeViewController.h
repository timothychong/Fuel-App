//
//  FLNewChallengeViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLChallenge.h"
#import "FLGenericViewController.h"

@interface FLNewChallengeViewController : FLGenericViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *goalNameTextField;
@property (nonatomic) FLChallenge * myChallenge;
- (IBAction)cancelAddingChallenge:(id)sender;
- (IBAction)textfieldSelected:(id)sender;

@end
