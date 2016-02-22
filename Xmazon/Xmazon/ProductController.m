//
//  ProductController.m
//  Xmazon
//
//  Created by Mickael Bordage on 22/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "ProductController.h"
#import "SimpleTableCellTableViewCell.h"

@interface ProductController ()

@end

@implementation ProductController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Liste des categorie";
    [self.navigationItem setHidesBackButton:false];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.api.delegate = self;
    tableAray = [NSMutableArray arrayWithObjects:@"Dentifrice", @"Papier Toilette", @"Stylos", @"test"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark UITableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableAray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTabcell";
    
    SimpleTableCellTableViewCell *cell = (SimpleTableCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SimpleTabCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    NSLog(@"%@",[tableAray objectAtIndex:indexPath.row]);
    //cell.nameLabel.text = [tableAray objectAtIndex:indexPath.row];
    cell.nameLabel.text=[tableAray objectAtIndex:indexPath.row];
    //cell.priceLabel.text = [timeArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

