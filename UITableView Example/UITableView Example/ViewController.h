//
//  ViewController.h
//  UITableView Example
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addNewName:(id)sender;
@property (nonatomic) NSMutableArray * recipes;
- (IBAction)save:(id)sender;
@end