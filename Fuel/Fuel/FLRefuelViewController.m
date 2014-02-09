//
//  FLRefuelViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLRefuelViewController.h"
#import "FLMotivatorImage.h"
#import "FLMotivatorText.h"
#import "FLMotivatorVideo.h"

@interface FLRefuelViewController ()

@end

@implementation FLRefuelViewController

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
    
    [self.backButton setImage:[UIImage imageNamed:@"Back Button - Selected"] forState: UIControlStateHighlighted];
    
    NSArray * array = [self.myChallenge.motivators allObjects];
    int count = array.count;
    if (!count) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    int r = arc4random() % count;
    FLMotivator * motivator = array[r];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
