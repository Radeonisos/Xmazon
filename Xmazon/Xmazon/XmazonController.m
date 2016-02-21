//
//  XmazonController.m
//  Xmazon
//
//  Created by Mickael Bordage on 11/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "XmazonController.h"
#import "GROAuth2SessionManager/GROAuth2SessionManager.h"
#import "ApiRequest.h"
#import "AppDelegate.h"
#import "ListXmazonController.h"


@interface XmazonController ()

@end

@implementation XmazonController

ApiRequest* api;

- (void)viewDidLoad {
    [super viewDidLoad];
    api = [ApiRequest alloc];
    [api getToken];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogin:(id)sender {
    NSString* email;
    NSString* password;
    email = [self.lableEmail text];
    password = [self.labelPassword text];
    
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    api.sessionManagerUser = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    NSLog(@"bonjour");
    __block BOOL result = true;
    [api.sessionManagerUser authenticateUsingOAuthWithPath:@"/oauth/token" username:email password:password scope:nil
                                                success:^(AFOAuthCredential *credential) {
                                                    result = true;
                                                    NSLog(@"sa marche token user %@ : ",credential.accessToken);
                                                    ListXmazonController* viewController = [[ListXmazonController alloc] init];
                                                    [self.navigationController pushViewController:viewController animated:YES];
                                                    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                                                    appDelegate.api = api;
                                                    
                                                
                                                } failure:^(NSError *error) {
                                                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Authentification" message:@"Adresse Mail ou mot de passe incorrecte" preferredStyle:UIAlertControllerStyleAlert];
                                                    UIAlertAction* validateAction = [UIAlertAction actionWithTitle:@"Validate" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
                                                    }];
                                                    [alertController addAction:validateAction];
                                                    [self presentViewController:alertController animated:YES completion:nil];
                                                }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
