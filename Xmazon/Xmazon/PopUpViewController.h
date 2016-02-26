//
//  PopUpViewController.h
//  Xmazon
//
//  Created by Mickael Bordage on 26/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstnameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastnameLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *dayLabel;
@property (weak, nonatomic) IBOutlet UITextField *monthLabel;
@property (weak, nonatomic) IBOutlet UITextField *yearLabel;

@end
