//
//  FLGlobalHelper.m
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLGlobalHelper.h"
#import "FLAppDelegate.h"
#import "FLChallenge.h"

static FLGlobalHelper * defaultGlobalHelper = nil;

@implementation FLGlobalHelper


+ (FLGlobalHelper *) defaultHelper
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        defaultGlobalHelper = [[self alloc]init];
        
        FLAppDelegate * mainAppDelegate = (FLAppDelegate *) [[UIApplication sharedApplication] delegate];
        defaultGlobalHelper.managedObjectContext = mainAppDelegate.managedObjectContext;
    });
    
    return defaultGlobalHelper;
}

-(void)defaultSetup
{
    [self deleteAllChallenges];
    
    FLChallenge * challenege = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    challenege.startDate = [NSDate new];
    challenege.duration = @(60 * 60 * 24 * 15);
    challenege.title = @"Finish Hackathon";
    
    FLChallenge * challenege1 = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    
    challenege1.duration = @(60 * 60 * 24 * 20);
    challenege1.startDate = [NSDate new];
    challenege1.title = @"Mount Everest";
    
    FLChallenge * challenege2 = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    challenege2.startDate = [NSDate new];
    challenege2.duration = @(60 * 60 * 24 * 30);
    challenege2.title = @"Finish Degree";
    
    
    NSError * error;
    [self.managedObjectContext save:&error];
    
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
//    
//    NSEntityDescription * entity = [NSEntityDescription entityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSArray * r  = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];

}

-(void)deleteAllChallenges
{
    NSFetchRequest * fetchRequest = [NSFetchRequest new];
    fetchRequest.entity = [NSEntityDescription entityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];

    [fetchRequest setIncludesPropertyValues:NO];
    NSError * error = nil;
    NSArray * savedChallenges = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (savedChallenges.count == 0) {
        return;
    }
    for (NSManagedObject * challenge in savedChallenges) {
        [self.managedObjectContext deleteObject:challenge];
    }
    [self.managedObjectContext save: &error];
}

@end
