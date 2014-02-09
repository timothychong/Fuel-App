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
#import <UIImage-Categories/UIImage+Resize.h>

@interface FLRefuelViewController ()
@property (nonatomic) FLMotivator * myMotivator;

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
    self.myMotivator = array[r];
    
    self.progressView.progress = [self.myChallenge percentFinished];
    self.daysLeftLabel.text = [self.myChallenge dayLeftString];
    
    //Days ago
    NSDate * dateAdded = self.myMotivator.dateAdded;
    NSTimeInterval difference = [[NSDate new] timeIntervalSinceDate:dateAdded];
    int days = difference / 60 / 24 / 60;
    self.daysAgoLabel.text = [NSString stringWithFormat:@"%d", days];
    
    
    switch ([self.myMotivator type]) {
        case FLMotivatorTypeText:
            
            break;
        case FLMotivatorTypeImage:
            self.imageView.image = [[FLGlobalHelper imageWithPath:((FLMotivatorImage *)self.myMotivator).path] resizedImage:CGSizeMake(300, 300) interpolationQuality:0];
            self.playButton.alpha = 0;
            ((UIScrollView *)self.view).scrollEnabled = YES;
            break;
        case FLMotivatorTypeVideo:
            break;
        default:
            break;
    }

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
