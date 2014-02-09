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
#import "FLMotivatorVideo.h"
#import "FLMotivatorImage.h"
#import "FLMotivatorText.h"

@interface FLNewChallengeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *goalName;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation FLNewChallengeViewController

- (IBAction)saveChallenge
{
    if (![self.goalName.text isEqualToString: @""] && self.date.date)
    {
        self.myChallenge.title = self.goalName.text;
        self.myChallenge.endDate = self.date.date;
        self.myChallenge.startDate = [NSDate date];
        NSError * error;
        [self.managedObjectContext save: &error];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message: @"There is an incomplete field!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Your Message"
                                                      message: nil
                                                     delegate: self
                                            cancelButtonTitle: @"Cancel"
                                            otherButtonTitles: @"Refuel", nil];
    message.alertViewStyle = UIAlertViewStylePlainTextInput;
    [message show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!(buttonIndex == 0))
    {
        UITextField *textfield =  [alertView textFieldAtIndex: 0];
        NSString * text =  textfield.text;
        
        FLMotivatorText * newText = [NSEntityDescription insertNewObjectForEntityForName: @"FLMotivatorText" inManagedObjectContext:self.managedObjectContext];
        newText.text = text;
        [self.myChallenge addMotivatorsObject: newText];
    }
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
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSNumber* currentIndex = [defaults objectForKey: @"videoIndex"];
        
        if (currentIndex)
        {
            int currentIndexInt = currentIndex.intValue;
            currentIndexInt ++;
            currentIndex = [NSNumber numberWithInt: currentIndexInt];
        }
        else
        {
            currentIndex = [NSNumber numberWithInt: 0];
        }
        
        [defaults setObject: currentIndex forKey: @"videoIndex"];
        [defaults synchronize];
        
        NSString * nameWithoutFileType = [currentIndex stringValue];
        NSString * nameWithFileType = [nameWithoutFileType stringByAppendingPathComponent: @".mp4"];
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSString * path = [documentsDirectory stringByAppendingPathComponent:nameWithFileType];
        [movieData writeToFile: path atomically:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        // core data
        
        FLMotivatorVideo * newVideo = [NSEntityDescription insertNewObjectForEntityForName: @"FLMotivatorVideo" inManagedObjectContext:self.managedObjectContext];
        newVideo.path = path;
        [self.myChallenge addMotivatorsObject: newVideo];
        
        
    }
    else
    {
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *data = UIImagePNGRepresentation(pickedImage);
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSNumber* currentIndex = [defaults objectForKey: @"imageIndex"];
        
        if (currentIndex)
        {
            int currentIndexInt = currentIndex.intValue;
            currentIndexInt ++;
            currentIndex = [NSNumber numberWithInt: currentIndexInt];
        }
        else
        {
            currentIndex = [NSNumber numberWithInt: 0];
        }
        
        [defaults setObject: currentIndex forKey: @"imageIndex"];
        [defaults synchronize];
        
        NSString * nameWithoutFileType = [currentIndex stringValue];
        NSString * nameWithFileType = [nameWithoutFileType stringByAppendingPathComponent: @".png"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent: nameWithFileType];
        [data writeToFile: path atomically:YES];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        // core data
        
        FLMotivatorImage * newImage = [NSEntityDescription insertNewObjectForEntityForName: @"FLMotivatorImage" inManagedObjectContext:self.managedObjectContext];
        newImage.path = path;
        [self.myChallenge addMotivatorsObject: newImage];
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

- (IBAction)textfieldSelected:(id)sender {
    [self.goalNameTextField becomeFirstResponder];
}
@end
