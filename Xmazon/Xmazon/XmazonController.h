//
//  XmazonController.h
//  Xmazon
//
//  Created by Mickael Bordage on 11/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XmazonController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *lableEmail;
@property (weak, nonatomic) IBOutlet UITextField *labelPassword;
@property (nonatomic,retain) UIViewController* popoverController;

@end
