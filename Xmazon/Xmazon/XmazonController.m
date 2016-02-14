//
//  XmazonController.m
//  Xmazon
//
//  Created by Mickael Bordage on 11/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "XmazonController.h"
#import "GROAuth2SessionManager/GROAuth2SessionManager.h"

@interface XmazonController ()

@end

@implementation XmazonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTest:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    GROAuth2SessionManager *sessionManager = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    
    
    NSDictionary* d = @{
                        @"grant_type" : @"client_credentials",
                        };
    NSString* token;
    [sessionManager authenticateUsingOAuthWithPath:@"/oauth/token" parameters:d success:^(AFOAuthCredential *credential) {
        [AFOAuthCredential storeCredential:credential withIdentifier:@"AccessToken"];
        NSLog(@"%@",credential.accessToken);
        NSLog(@"I have a token! %@ with refresh token %@ of type %@ ", credential.accessToken, credential.refreshToken, credential.tokenType);
        [AFOAuthCredential storeCredential:credential withIdentifier:sessionManager.serviceProviderIdentifier];
        }
        failure:^(NSError *error) {
                NSLog(@"Error: %@", error);
        }];
    
    
    
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:@"AccessToken"];
    /*NSString *authValue = [NSString stringWithFormat:@"Bearer %@", credential.accessToken];
    NSDictionary* header = @{
     @"Authorisation" : authValue,
     };*/
    
    [sessionManager setAuthorizationHeaderWithCredential:credential];
    __block NSMutableArray *myArray;
    [sessionManager GET:@"store/list" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        NSDictionary *jsonDict = (NSDictionary *) responseObject;
        //!!! here is answer (parsed from mapped JSON: {"result":"STRING"}) -
        NSArray *test = [NSArray arrayWithObject:[jsonDict objectForKey:@"result"]];
        NSLog(@"test %@",test[0]);
        
        myArray = [responseObject objectForKey:@"result"];
        
        NSLog (@"uid store :%@", [[myArray objectAtIndex:0] objectForKey:@"uid"]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
    }];
    
    NSLog(@" test de l'uid de merde :%@",[[myArray objectAtIndex:0] objectForKey:@"uid"]);
    NSString *authValue = [NSString stringWithFormat:@"%@%@",@"/category/list?store_uid=",([[myArray objectAtIndex:0] objectForKey:@"uid"])];
    
    [sessionManager GET:authValue parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche categorie");
       // NSDictionary *jsonDict = (NSDictionary *) responseObject;
////!!! here is answer (parsed from mapped JSON: {"result":"STRING"}) ->
        //NSArray *test = [NSArray arrayWithObject:[jsonDict objectForKey:@"result"]];
        NSLog(@"categorie : %@",responseObject);
        
        NSArray *myArray2 = [responseObject objectForKey:@"result"];
        NSLog(@"%@",myArray2);
        //NSLog (@"%@", [[myArray2 objectAtIndex:2] objectForKey:@"name"]);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
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
