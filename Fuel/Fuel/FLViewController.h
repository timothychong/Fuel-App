//
//  FLViewController.h
//  Fuel
//
//  Created by Timothy Chong on 2/7/14.
//  Copyright (c) 2014 Fuel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
