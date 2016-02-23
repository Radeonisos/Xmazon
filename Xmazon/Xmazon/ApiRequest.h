//
//  ApiRequest.h
//  Xmazon
//
//  Created by Mickael Bordage on 13/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GROAuth2SessionManager/GROAuth2SessionManager.h"

@protocol ApiRestDelagate
@optional
-(void) requestReceive:(NSMutableArray*)responce;
-(void) requestError:(NSError*) error;
@end

@interface ApiRequest : NSObject

@property (nonatomic, assign) GROAuth2SessionManager* sessionManagerApp;
@property (nonatomic, assign) GROAuth2SessionManager* sessionManagerUser;
@property (strong, nonatomic) id delegate;

-(instancetype) init;
-(BOOL) getTokenUser:(NSString*) email andPassword:(NSString*) password;
-(void) getToken;
-(NSMutableArray*) getApi:(NSString*) url andSessionManager:(GROAuth2SessionManager*) sessionManager;
-(NSMutableArray*) postApi;
+(void)requestLocation:(NSString*)url and:(GROAuth2SessionManager*) sessionManagerApp_ completionBlock:(void (^)(NSArray * coordinates, NSError * error)) handler;



@end
