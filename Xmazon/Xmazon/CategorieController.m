//
//  CategorieController.m
//  Xmazon
//
//  Created by Mickael Bordage on 21/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "CategorieController.h"
#import "ProductController.h"

@interface CategorieController ()

@end

@implementation CategorieController

@synthesize uid;

NSMutableArray* resultArray2;

- (void)viewDidLoad {
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
    NSString* urlCategory=@"/category/list?store_uid=";
    NSString *authValue = [NSString stringWithFormat:@"%@%@",urlCategory,uid];
    NSLog(@"%@",authValue);
    [appDelegate.api getApi:authValue andSessionManager:appDelegate.api.sessionManagerApp];
    
}

- (void)requestReceive:(NSMutableArray *)responce{
    resultArray2 = responce;
    NSLog(@"Resultat du tableau des stores %@",resultArray2);
    [[self.view viewWithTag:12] stopAnimating];
    [self.storeList reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultArray2 count];
}

static NSString* const kCellReuseIdentifier = @"CoolId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellReuseIdentifier];
    }
    NSDictionary* value = [resultArray2 objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [value objectForKey:@"name"];
    //cell.detailTextLabel.text = @"super trop bien";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ONCLICK %@",[resultArray2 objectAtIndex:indexPath.row]);
    ProductController* viewController = [[ProductController alloc] initWithNibName: @"ListXmazonController"bundle:nil];
    viewController.uid =[[resultArray2 objectAtIndex:indexPath.row] objectForKey:@"uid"];
    
    //viewController.uid =[[resultArray objectAtIndex:indexPath.row] objectForKey:@"uid"];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [resultArray2 removeObjectAtIndex:indexPath.row];
        //[tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString* value = [resultArray2 objectAtIndex:sourceIndexPath.row];
    [resultArray2 removeObjectAtIndex:sourceIndexPath.row];
    [resultArray2 insertObject:value atIndex:destinationIndexPath.row];
}

@end
