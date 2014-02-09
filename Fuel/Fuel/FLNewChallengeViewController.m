//
//  FLNewChallengeViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLNewChallengeViewController.h"

@interface FLNewChallengeViewController ()

@end

@implementation FLNewChallengeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIView * view = [[NSBundle mainBundle] loadNibNamed:@"FLNewChallengeView" owner:self options:nil][0];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = view.frame.size;
    self.scrollView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancelAddingChallenge:(id)sender {
    [self.managedObjectContext deleteObject:self.myChallenge];
    NSError * error;
    [self.managedObjectContext save:&error];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
