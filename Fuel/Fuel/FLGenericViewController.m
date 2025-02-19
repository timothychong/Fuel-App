//
//  FLGenericViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLGenericViewController.h"
#import "FLAppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface FLGenericViewController ()

@end


@implementation FLGenericViewController

-(void) presentVideoWithPath:(NSString *) str
{
    
    NSURL *url = [NSURL fileURLWithPath:str];
    
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL: url];
    moviePlayer.moviePlayer.controlStyle = MPMovieControlStyleNone;
    moviePlayer.moviePlayer.scalingMode = MPMovieScalingModeFill;
    [self presentViewController:moviePlayer animated:NO completion:^{
    }];
    
}
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
    
    //Set up managed object context
    FLAppDelegate * mainAppDelegate = (FLAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = mainAppDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
