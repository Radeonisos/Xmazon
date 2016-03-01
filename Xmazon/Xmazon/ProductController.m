//
//  ProductController.m
//  Xmazon
//
//  Created by Mickael Bordage on 22/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "ProductController.h"
#import "SimpleTableCellTableViewCell.h"
#import "XmazonController.h"

@interface ProductController ()

@end

@implementation ProductController
@synthesize uid;

NSMutableArray* tableAray;
AppDelegate* appDelegateProduct;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Product";
    [self.navigationItem setHidesBackButton:false];
    UIBarButtonItem* decoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onTouchDecoButton)];
    self.navigationItem.rightBarButtonItems = @[decoButton];
    appDelegateProduct = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegateProduct.api.delegate = self;
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    NSString* urlProduct=@"/product/list?category_uid=";
    NSString *authValue = [NSString stringWithFormat:@"%@%@",urlProduct,uid];
    NSLog(@"%@",authValue);

    [appDelegateProduct.api getApi:authValue andSessionManager:appDelegateProduct.api.sessionManagerUser];
}

- (void) onTouchDecoButton {
    appDelegateProduct.api = [ApiRequest alloc];
    XmazonController* viewController = [[XmazonController alloc] initWithNibName: @"XmazonController"bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
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
    cell.priceLabel.text = [NSString stringWithFormat:@"%1.2f", [[value objectForKey:@"price"]floatValue]];
    if([value objectForKey:@"available"])
        cell.statueLabel.text = @"available";
    else
        cell.statueLabel.text = @"unavailable";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end

