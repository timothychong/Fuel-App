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
    
    FLChallenge * challenge = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.titleLabel.text = challenge.title;
    cell.dayLeftLabel.text = challenge.dayLeftString;
    
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

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewChallenge"]) {
        FLNewChallengeViewController * vc = segue.destinationViewController;
        
        vc.myChallenge = [NSEntityDescription insertNewObjectForEntityForName:@"DTChallenge" inManagedObjectContext:self.managedObjectContext];
        NSError * error;
        [self.managedObjectContext save:&error];
    }
}

@end
