//
//  FLViewController.m
//  Fuel
//
//  Created by Timothy Chong on 2/7/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLCurrentChallengeViewController.h"
#import "FLAppDelegate.h"
#import "FLChallengeCell.h"
#import "FLNewChallengeViewController.h"
#import "FLDetailChallengeViewController.h"

#define CELL_HEIGHT 110

@interface FLCurrentChallengeViewController ()
@property (nonatomic) NSFetchedResultsController * fetchedResultsController;
@end

@implementation FLCurrentChallengeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:96 alpha:1];
    
    
    NSError *error = nil;
    
    //Setup fetch result controller
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasource

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
    static NSString * identifier = @"ChallengeCell";
    
   FLChallengeCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


#pragma mark - Fetched results Controller

-(NSFetchedResultsController *) fetchedResultsController
{
    if (!_fetchedResultsController) {
        
        //Create fetch Request
        NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
        
        NSEntityDescription * entity = [NSEntityDescription entityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        //Set up initial sorting
        NSArray * descriptors = @[]; //@[[[NSSortDescriptor alloc]initWithKey:@"groupName" ascending:YES]];
        
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
            [self configureCell:(FLChallengeCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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

-(void) configureCell:(FLChallengeCell * ) cell atIndexPath:(NSIndexPath *) indexPath
{
    FLChallenge * challenge = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = challenge.title;
    cell.dayLeftLabel.text = challenge.dayLeftString;
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
        [self.tableView endUpdates];
    
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    FLDetailChallengeViewController * dvc = [st instantiateViewControllerWithIdentifier:@"ChallengeDetailView"];
    dvc.myChallenge = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:dvc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FLChallenge * challenge = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.managedObjectContext deleteObject:challenge];
        NSError * error;
        [self.managedObjectContext save:&error];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewChallenge"]) {
        
        UINavigationController* vc = segue.destinationViewController;
        NSArray *viewControllers = vc.viewControllers;
        FLNewChallengeViewController * newvc = viewControllers[0];
        newvc.myChallenge = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
        NSError * error;
        [self.managedObjectContext save: &error];
    }
}

@end
