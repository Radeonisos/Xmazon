//
//  ListXmazonController.h
//  Xmazon
//
//  Created by Mickael Bordage on 14/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiRequest.h"
#import "AppDelegate.h"

@interface ListXmazonController : UIViewController <ApiRestDelagate>
@property (weak, nonatomic) IBOutlet UITableView *storeList;

@end
