//
//  FLNewChallengeViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FLNewChallengeViewController.h"

@interface FLNewChallengeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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

- (IBAction) addPhoto
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message: @"Camera is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)addText
{
    
}

- (IBAction)addVideo
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate {
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated: YES completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSURL *moviePath = [info objectForKey: UIImagePickerControllerMediaURL];
        NSData * movieData = [NSData dataWithContentsOfURL:moviePath];
        NSString *FileName=[NSString stringWithFormat:@"movie1.mp4"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:FileName];
        [movieData writeToFile: tempPath atomically:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    else
    {
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data = UIImagePNGRepresentation(pickedImage);
        NSString *FileName=[NSString stringWithFormat:@"image1.png"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:FileName];
        [data writeToFile:tempPath atomically:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
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
