//
//  AppDelegate.h
//  Xmazon
//
//  Created by Mickael Bordage on 11/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiRequest.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) ApiRequest* api;


@end

