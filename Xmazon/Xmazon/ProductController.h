//
//  ProductController.h
//  Xmazon
//
//  Created by Mickael Bordage on 22/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiRequest.h"
#import "AppDelegate.h"

@interface ProductController : UIViewController <ApiRestDelagate>
{
    NSMutableArray *tableAray,*foodImageArray,*timeArray;
}
@property (weak, nonatomic) IBOutlet UITableView *storeList;
@property (nonatomic, assign) NSString* uid;

@end