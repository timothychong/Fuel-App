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

+ (UIImage *) imageWithPath:(NSString *) str;
{
    NSURL *targetURL = [NSURL fileURLWithPath: str];
    NSData *returnData=[NSData dataWithContentsOfURL:targetURL];
    UIImage *imagemain=[UIImage imageWithData: returnData];
    return imagemain;
}

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
    return;
    [self deleteAllChallenges];
    
    FLChallenge * challenege = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    challenege.startDate = [NSDate new];
    challenege.endDate = [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:[NSDate new]];
    challenege.title = @"Finish Hackathon";
    
    FLChallenge * challenege1 = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    
    challenege1.endDate = [NSDate dateWithTimeInterval:60 * 60 * 24 * 3 sinceDate:[NSDate new]];
    challenege1.startDate = [NSDate new];
    challenege1.title = @"Mount Everest";
    
    FLChallenge * challenege2 = [NSEntityDescription insertNewObjectForEntityForName:@"FLChallenge" inManagedObjectContext:self.managedObjectContext];
    challenege2.startDate = [NSDate new];
    challenege2.endDate = [NSDate dateWithTimeInterval:60 * 60 * 24 * 4 sinceDate:[NSDate new]];
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
