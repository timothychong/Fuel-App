//
//  FLDetailChallengeViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLDetailChallengeViewController.h"

@interface FLDetailChallengeViewController ()

@end

@implementation FLDetailChallengeViewController

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
    
    UIView * view = [[NSBundle mainBundle] loadNibNamed:@"ChallengeDetailView" owner:self options:nil][0];
    [self.scrollView addSubview:view];
    self.scrollView.contentSize = view.frame.size;
    self.scrollView.scrollEnabled = YES;

    self.titleLabel.text = self.myChallenge.title;
    self.timeLeftLabel.text = [self.myChallenge dayLeftString];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refuel:(id)sender {
}
@end
