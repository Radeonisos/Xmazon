//
//  PopUpViewController.m
//  Xmazon
//
//  Created by Mickael Bordage on 26/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "PopUpViewController.h"
#import "XmazonController.h"
#import "AppDelegate.h"


@interface PopUpViewController ()

@end

@implementation PopUpViewController

AppDelegate* appDelegateSubscribe;

- (void)viewDidLoad {
    self.title = @"Subscribe";
    [self.navigationItem setHidesBackButton:TRUE];
    appDelegateSubscribe= (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegateSubscribe.api.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCancel:(id)sender {
    XmazonController* viewController = [[XmazonController alloc] initWithNibName: @"XmazonController"bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)btnValidate:(id)sender {
    NSString* firstname = [self.firstnameLabel text];
    NSString* lastname = [self.lastnameLabel text];
    NSString* email = [self.emailLabel text];
    NSString* password = [self.passwordLabel text];
    NSString* day = [self.dayLabel text];
    NSString* month = [self.monthLabel text];
    NSString* year = [self.yearLabel text];
    NSLog(@"%@ %@ %@ %@ %@ %@ %@", firstname,lastname,email,password,day,month,year);

    
    if((email.length>0 && password.length>0) && (email.length>0 || password.length>0)){
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 240);
        spinner.tag = 12;
        [self.view addSubview:spinner];
        [spinner startAnimating];
        NSString* date = [NSString stringWithFormat:@"%@/%@/%@", day, month, year];
        NSDictionary* param = @{
                                @"email" : email,
                                @"password" : password,
                                @"firstname": firstname,
                                @"lastname": lastname,
                                @"birthdate" : date
                                };
        [appDelegateSubscribe.api postApi:param];
        
    }
    else{
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"The field required are empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* validateAction = [UIAlertAction actionWithTitle:@"Validate" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        }];
        [alertController addAction:validateAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


- (void)requestReceive:(NSMutableArray *)responce{
    NSLog(@"Resultat du tableau des inscription%@",responce);
    [[self.view viewWithTag:12] stopAnimating];
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"OK" message:@"Le compte a bien été créer" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* validateAction = [UIAlertAction actionWithTitle:@"Validate" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
    }];
    [alertController addAction:validateAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
