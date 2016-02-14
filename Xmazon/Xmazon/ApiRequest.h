//
//  ApiRequest.h
//  Xmazon
//
//  Created by Mickael Bordage on 13/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GROAuth2SessionManager/GROAuth2SessionManager.h"

@interface ApiRequest : NSObject

@property (nonatomic, assign) GROAuth2SessionManager* sessionManagerApp;
@property (nonatomic, assign) GROAuth2SessionManager* sessionManagerUser;

-(instancetype) init;
-(BOOL) getTokenUser:(NSString*) email andPassword:(NSString*) password;
-(void) getToken;
-(NSMutableArray*) getApi:(NSString*) url;
-(NSMutableArray*) postApi;

@end
