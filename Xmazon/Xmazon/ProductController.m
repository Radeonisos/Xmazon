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
@synthesize uid;

NSMutableArray* tableAray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Liste des categorie";
    [self.navigationItem setHidesBackButton:false];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.api.delegate = self;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    NSString* urlProduct=@"/product/list?category_uid=";
    NSString *authValue = [NSString stringWithFormat:@"%@%@",urlProduct,uid];
    NSLog(@"%@",authValue);

    [appDelegate.api getApi:authValue andSessionManager:appDelegate.api.sessionManagerUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReceive:(NSMutableArray *)responce{
    NSLog(@"%@",responce);
    tableAray = responce;
    [[self.view viewWithTag:12] stopAnimating];
    [self.storeList reloadData];
    
}

-(void)requestError:( NSError*)error{
    NSLog(@"%@",error);
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
    NSDictionary* value = [tableAray objectAtIndex:indexPath.row];
    NSLog(@" print de value %@", value);
    //cell.nameLabel.text = [tableAray objectAtIndex:indexPath.row];
    cell.nameLabel.text=[value objectForKey:@"name"];
    //cell.priceLabel.text = [NSString stringWithFormat:@"%f", [value objectForKey:@"price"]];
    if([value objectForKey:@"available"])
        cell.statueLabel.text = @"available";
    else
        cell.statueLabel.text = @"enavailable";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

