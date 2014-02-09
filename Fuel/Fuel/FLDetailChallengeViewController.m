//
//  FLDetailChallengeViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLDetailChallengeViewController.h"
#import "FLRefuelViewController.h"


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
    self.scrollView.scrollEnabled = NO;

    self.titleLabel.text = self.myChallenge.title;
    self.timeLeftLabel.text = [self.myChallenge dayLeftString];
    [self.refuelButton setImage:[UIImage imageNamed:@"Refuel Me - Selected"] forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refuel:(id)sender {
    
    UIStoryboard * st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FLDetailChallengeViewController * dvc = [st instantiateViewControllerWithIdentifier:@"FLRefuelViewController"];
    dvc.myChallenge = self.myChallenge;
    [self presentViewController:dvc animated:YES completion:nil];
    
}

- (IBAction)removeFuel:(id)sender {
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"Are you sure want to remove Fuel?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            
            [self.managedObjectContext delete:self.myChallenge];
            NSError * error;
            [self.managedObjectContext save:&error];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        default:
            break;
    }
}

@end
