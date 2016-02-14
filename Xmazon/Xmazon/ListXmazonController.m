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
NSMutableArray* words_;

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
     words_ = [NSMutableArray new];
    [words_ addObject:@"Bonjour"];
    [words_ addObject:@"Je suis"];
    [words_ addObject:@"la"];
    [words_ addObject:@"il"];
    [words_ addObject:@"fait"];
    [words_ addObject:@"FROID"];
    self.title = @"Super liste !";
    [self.navigationItem setHidesBackButton:TRUE];
    ApiRequest* api = [ApiRequest alloc];
    NSString* urlList=@"store/list";
    [api getToken];
    resultArray = [api getApi:urlList];
    NSLog(@"Resultat du tableau des stores %@",resultArray);
    // Do any additional setup after loading the view from its nib.
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
