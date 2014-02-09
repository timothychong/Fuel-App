//
//  FLInsiprationViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/9/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLInsiprationViewController.h"
#import "FLMotivatorImage.h"
#import "FLMotivatorText.h"
#import "FLMotivatorVideo.h"

@interface FLInsiprationViewController ()

@property (nonatomic) NSFetchedResultsController * fetchedResultsController;

@end

@implementation FLInsiprationViewController

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
    NSError * error;
    
    //Setup fetch result controller
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    return numberOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cameraIdentifier = @"InspirationCameraCell";
    static NSString * textIdentifier = @"InspirationTextCell";
    
    FLMotivator * motivator = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell * cell;
    
    switch (motivator.type) {
        case FLMotivatorTypeImage:
        case FLMotivatorTypeVideo:
            cell = [tableView dequeueReusableCellWithIdentifier:cameraIdentifier];
            break;
        case FLMotivatorTypeText:
            cell = [tableView dequeueReusableCellWithIdentifier:textIdentifier];
            break;
        default:
            break;
    }
    

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#define PLAY_TAG 100
#define IMAGE_TAG 101
#define DATE_TAG 102
#define LABEL_TAG 100


-(void) configureCell:(UITableViewCell * ) cell atIndexPath:(NSIndexPath *) indexPath
{
    FLMotivator * motivator = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    switch (motivator.type) {
        case FLMotivatorTypeImage:
        {
            FLMotivatorImage * imageMotivator = (FLMotivatorImage *) motivator;
            
            UIImageView * imageView = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
            imageView.image = [FLGlobalHelper imageWithPath:imageMotivator.path];
        
        }
            break;
        case FLMotivatorTypeVideo:
            break;
        case FLMotivatorTypeText:
        {
            FLMotivatorText * textMotivator = (FLMotivatorText *) motivator;
            UILabel * textLabel = (UILabel *)[cell viewWithTag:LABEL_TAG];
            UILabel * dateLabel = (UILabel *)[cell viewWithTag:DATE_TAG];
            textLabel.text = textMotivator.text;
            
            
        }
            break;
            
        default:
            break;
    }
}





#pragma mark - Fetched results Controller

-(NSFetchedResultsController *) fetchedResultsController
{
    if (!_fetchedResultsController) {
        
        //Create fetch Request
        NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
        
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"FLMotivator" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"challenge = %@", self.myChallenge];
        
        //Set up initial sorting
        NSArray * descriptors = @[[[NSSortDescriptor alloc]initWithKey:@"dateAdded" ascending:YES]];
        
        fetchRequest.fetchBatchSize = 20;
        fetchRequest.sortDescriptors = descriptors;

        
        //Make the fetch result controller
        NSFetchedResultsController * newFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
        //Set delegate
        newFetchedResultsController.delegate = self;
        _fetchedResultsController= newFetchedResultsController;
    }
    return _fetchedResultsController;
}

#pragma mark - NSFetchedRequestDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
    
}



@end
