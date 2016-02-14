//
//  ApiRequest.m
//  Xmazon
//
//  Created by Mickael Bordage on 13/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "ApiRequest.h"



@implementation ApiRequest

@synthesize sessionManager = sessionManager_;

-(instancetype)init{
    self = [super init];
    return self;
}

-(void) getToken{
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    sessionManager_ = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    
    
    NSDictionary* d = @{
                        @"grant_type" : @"client_credentials",
                        };
    [sessionManager_ authenticateUsingOAuthWithPath:@"/oauth/token" parameters:d success:^(AFOAuthCredential *credential) {
        [AFOAuthCredential storeCredential:credential withIdentifier:@"AccessToken"];
        NSLog(@"%@",credential.accessToken);
        NSLog(@"I have a token! %@ with refresh token %@ of type %@ ", credential.accessToken, credential.refreshToken, credential.tokenType);
        [AFOAuthCredential storeCredential:credential withIdentifier:sessionManager_.serviceProviderIdentifier];
    }
                                           failure:^(NSError *error) {
                                               NSLog(@"Error: %@", error);
                                           }];
    
}

-(NSMutableArray*) getApi:(NSString*) url{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:@"AccessToken"];
    [sessionManager_ setAuthorizationHeaderWithCredential:credential];
    __block NSMutableArray *myArray;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    sessionManager_.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [sessionManager_ GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        NSDictionary *jsonDict = (NSDictionary *) responseObject;
        //!!! here is answer (parsed from mapped JSON: {"result":"STRING"}) -
        NSArray *test = [NSArray arrayWithObject:[jsonDict objectForKey:@"result"]];
        NSLog(@"test %@",test[0]);
        
        myArray = [responseObject objectForKey:@"result"];
        NSLog (@"uid store :%@", [[myArray objectAtIndex:0] objectForKey:@"uid"]);
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@" test de l'uid de merde :%@",[[myArray objectAtIndex:0] objectForKey:@"uid"]);
    /*[sessionManager_ GET:authValue parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    }];*/
  
    return myArray;
}




@end