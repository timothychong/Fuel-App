//
//  FLInsiprationViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/9/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import "FLGenericViewController.h"
#import "FLGenericViewController.h"
#import "FLChallenge.h"

@interface FLInsiprationViewController : FLGenericViewController <UITableViewDataSource, UITableViewDelegate , NSFetchedResultsControllerDelegate>

@property (nonatomic) FLChallenge * myChallenge;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
