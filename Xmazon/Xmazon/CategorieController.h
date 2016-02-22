//
//  CategorieController.h
//  Xmazon
//
//  Created by Mickael Bordage on 21/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiRequest.h"
#import "AppDelegate.h"

@interface CategorieController : UIViewController <ApiRestDelagate>
@property (weak, nonatomic) IBOutlet UITableView *storeList;
@property (nonatomic, assign) NSString* uid;

@end
