//
//  ApiRequest.m
//  Xmazon
//
//  Created by Mickael Bordage on 13/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "ApiRequest.h"



@implementation ApiRequest

@synthesize sessionManagerApp = sessionManagerApp_;
@synthesize sessionManagerUser = sessionManagerUser_;
@synthesize delegate;

-(instancetype)init{
    self = [super init];
    return self;
}

-(void) getToken{
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    sessionManagerApp_ = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    NSDictionary* d = @{
                        @"grant_type" : @"client_credentials",
                        };
    [sessionManagerApp_ authenticateUsingOAuthWithPath:@"/oauth/token" parameters:d success:^(AFOAuthCredential *credential) {
        [AFOAuthCredential storeCredential:credential withIdentifier:@"AccessToken"];
        NSLog(@"%@",credential.accessToken);
        NSLog(@"I have a token! %@ with refresh token %@ of type %@ ", credential.accessToken, credential.refreshToken, credential.tokenType);
        NSLog(@"on passe ici");
        [AFOAuthCredential storeCredential:credential withIdentifier:sessionManagerApp_.serviceProviderIdentifier];
        
    }
                                           failure:^(NSError *error) {
                                               NSLog(@"Error: %@", error);
                                           }];
    
}


-(BOOL) getTokenUser:(NSString*) email andPassword:(NSString*) password{
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    sessionManagerUser_ = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    NSLog(@"bonjour");
    __block BOOL result = true;
    [sessionManagerUser_ authenticateUsingOAuthWithPath:@"/oauth/token" username:email password:password scope:nil
      success:^(AFOAuthCredential *credential) {
        result = true;
         NSLog(@"sa marche token user %@ : ",credential.accessToken);
     } failure:^(NSError *error) {
         NSLog(@"sa marche pas token user");
         result = false;
     }];
    return result;
}

+(void)requestLocation:(NSString*)url and:(GROAuth2SessionManager*) sessionManagerApp_ completionBlock:(void (^)(NSArray * coordinates, NSError * error)) handler{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:@"AccessToken"];
    [sessionManagerApp_ setAuthorizationHeaderWithCredential:credential];
    __block NSMutableArray *myArray;
    [sessionManagerApp_ GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        myArray = [responseObject objectForKey:@"result"];
        //NSLog (@"uid store :%@", [[myArray objectAtIndex:0] objectForKey:@"uid"]);
        [self.delegate requestError];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
    }];
    
}



-(NSMutableArray*) getApi:(NSString*) url{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:@"AccessToken"];
    [sessionManagerApp_ setAuthorizationHeaderWithCredential:credential];
    __block NSMutableArray *myArray;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    sessionManagerApp_.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [sessionManagerApp_ GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        //NSDictionary *jsonDict = (NSDictionary *) responseObject;
        
        //NSArray *test = [NSArray arrayWithObject:[jsonDict objectForKey:@"result"]];
        //NSLog(@"test %@",test[0]);
        
        myArray = [responseObject objectForKey:@"result"];
        //NSLog (@"uid store :%@", [[myArray objectAtIndex:0] objectForKey:@"uid"]);
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return myArray;
}


-(NSMutableArray*) postApi{
    NSMutableArray * result;
    NSDictionary* d = @{
                        @"email" : @"test1",
                        @"password" : @"toor",
                        };
    
    [sessionManagerApp_ POST:@"/auth/subscribe" parameters:d success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        NSLog(@" Reponce du subscribe : %@", responseObject);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
    }];
    
    return result;
}




@end