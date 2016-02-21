//
//  ListXmazonController.m
//  Xmazon
//
//  Created by Mickael Bordage on 14/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "ListXmazonController.h"
#import "ApiRequest.h"

@interface ListXmazonController ()

@end

@implementation ListXmazonController

NSMutableArray* resultArray ;

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.title = @"Liste des magasins";
    [self.navigationItem setHidesBackButton:TRUE];
    ApiRequest* api = [ApiRequest alloc];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    NSString* urlList=@"store/list";
    [api getToken];
    resultArray = [api getApi:urlList];
    NSLog(@"Resultat du tableau des stores %@",resultArray);
    [[self.view viewWithTag:12] stopAnimating];
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    //[[self.view viewWithTag:12] stopAnimating];
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
    return [resultArray count];
}

static NSString* const kCellReuseIdentifier = @"CoolId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellReuseIdentifier];
    }
    NSDictionary* value = [resultArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [value objectForKey:@"name"];
    //cell.detailTextLabel.text = @"super trop bien";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ONCLICK");
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [resultArray removeObjectAtIndex:indexPath.row];
        //[tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString* value = [resultArray objectAtIndex:sourceIndexPath.row];
    [resultArray removeObjectAtIndex:sourceIndexPath.row];
    [resultArray insertObject:value atIndex:destinationIndexPath.row];
}


@end
