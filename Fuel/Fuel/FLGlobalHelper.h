//
//  FLGlobalHelper.h
//  Fuel
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FLGlobalHelper : NSObject


@property (nonatomic, weak) NSManagedObjectContext * managedObjectContext;

+ (FLGlobalHelper *)defaultHelper;
- (void) defaultSetup;
- (void) deleteAllChallenges;
+ (UIImage *) imageWithPath:(NSString *) str;


@end
