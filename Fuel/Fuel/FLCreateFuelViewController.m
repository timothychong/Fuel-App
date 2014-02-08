//
//  FLCreateFuelViewController.m
//
//
//  Created by Akshar Bonu on 2/8/14.
//
//

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FLCreateFuelViewController.h"

@interface FLCreateFuelViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation FLCreateFuelViewController

- (IBAction)recordVideo:(UIButton *)sender
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)playVideo:(UIButton *)sender
{
    
}

- (IBAction)takeImage:(UIButton *)sender
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

- (IBAction)displayImage:(UIButton *)sender
{
    NSString *strPath= [NSString stringWithFormat:@"image1.png"];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:strPath];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSData *returnData=[NSData dataWithContentsOfURL:targetURL];
    UIImage *imagemain=[UIImage imageWithData: returnData];
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


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated: YES completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSURL *moviePath = [info objectForKey: UIImagePickerControllerMediaURL];
        NSData * movieData = [NSData dataWithContentsOfURL:moviePath];
        NSString *FileName=[NSString stringWithFormat:@"movie1.png"];
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

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
