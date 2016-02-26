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
        [self.delegate requestConnexionApp:true];
        //[AFOAuthCredential storeCredential:credential withIdentifier:sessionManagerApp_.serviceProviderIdentifier];
        
    }
                                           failure:^(NSError *error) {
                                               [self.delegate requestConnexionApp:false];
                                           }];
    
}


-(void) getTokenUser:(NSString*) email andPassword:(NSString*) password{
    NSURL *url = [NSURL URLWithString:@"http://xmazon.appspaces.fr"];
    sessionManagerUser_ = [GROAuth2SessionManager managerWithBaseURL:url clientID:@"f5a2d392-e727-40ed-8db0-19b18f155c52" secret:@"7a2d39dbb5424e4c5c916d7eb71dcc40bcc07401"];
    [sessionManagerUser_ authenticateUsingOAuthWithPath:@"/oauth/token" username:email password:password scope:nil
      success:^(AFOAuthCredential *credential) {
         NSLog(@"sa marche token user %@ : ",credential.accessToken);
          //[AFOAuthCredential storeCredential:credential withIdentifier:sessionManagerUser_.serviceProviderIdentifier];
          [self.delegate requestConnexionUser:true];
     } failure:^(NSError *error) {
         [self.delegate requestConnexionUser:false];
        
     }];
}



-(NSMutableArray*) getApi:(NSString*) url andSessionManager:(GROAuth2SessionManager *)sessionManager{
    __block NSMutableArray *myArray;
    [sessionManager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        myArray = [responseObject objectForKey:@"result"];
        [self.delegate requestReceive:myArray];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
        [self.delegate requestError:error];
    }];
    return myArray;
}


-(NSMutableArray*) postApi:(NSDictionary*) param{
    NSMutableArray * result;
    [sessionManagerApp_ POST:@"/auth/subscribe" parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sa marche");
        NSLog(@" Reponce du subscribe : %@", responseObject);
        [self.delegate requestReceive:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"sa marche pas");
        [self.delegate requestError:error];
    }];
    
    return result;
}




@end