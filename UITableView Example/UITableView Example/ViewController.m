//
//  ViewController.m
//  UITableView Example
//
//  Created by Timothy Chong on 2/8/14.
//  Copyright (c) 2014 GAI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray * names;

@end

@implementation ViewController
@synthesize recipes;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    recipes = [[NSMutableArray alloc]init];
    Recipe *recipe1 = [[Recipe alloc]init];
    recipe1.name = @"Recipe 1";
    recipe1.detail = @"Recipe 1 details.";
    recipe1.imageFile = @"i1.jpg";
    
    Recipe *recipe2 = [[Recipe alloc]init];
    recipe2.name = @"Recipe 2";
    recipe2.detail = @"Recipe 2 details.";
    recipe2.imageFile = @"i2.jpg";
    
    Recipe *recipe3 = [[Recipe alloc]init];
    recipe3.name = @"Recipe 3";
    recipe3.detail = @"Recipe 3 details.";
    recipe3.imageFile = @"i3.jpg";
    
    [recipes addObjectsFromArray:@[recipe1, recipe2, recipe3]];
    

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    self.names = [defaults objectForKey:@"Hello"];
    
    if (self.names == nil) {
        self.names = [NSMutableArray new];
        [self.names addObject:@"Name 1"];
        [self.names addObject:@"Name 2"];
        [self.names addObject:@"Name 3"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.names count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    Recipe *recipe = [recipes objectAtIndex:indexPath.row];
//    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
//    recipeImageView.image = [UIImage imageNamed:recipe.imageFile];
//    
//    UILabel *recipeNameLabel = (UILabel *)[cell viewWithTag:101];
//    recipeNameLabel.text = recipe.name;
//    
//    UILabel *recipeDetailLabel = (UILabel *)[cell viewWithTag:102];
//    recipeDetailLabel.text = recipe.detail;
    cell.textLabel.text = self.names[indexPath.row];
    return cell;
}

- (IBAction)addNewName:(id)sender {
    [self.names addObject:@"Random Name"];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.backgroundColor = [UIColor blueColor];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.names removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

- (IBAction)save:(id)sender {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.names forKey:@"Hello"];
    [defaults synchronize];
}
@end
