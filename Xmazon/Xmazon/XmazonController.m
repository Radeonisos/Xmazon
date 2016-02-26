//
//  XmazonController.m
//  Xmazon
//
//  Created by Mickael Bordage on 11/02/2016.
//  Copyright © 2016 Mickael Bordage. All rights reserved.
//

#import "XmazonController.h"
#import "GROAuth2SessionManager/GROAuth2SessionManager.h"
#import "ApiRequest.h"
#import "AppDelegate.h"
#import "ListXmazonController.h"
#import "PopUpViewController.h"


@interface XmazonController ()

@end

@implementation XmazonController

AppDelegate* appDelegate;

- (void)viewDidLoad {
    [self.navigationItem setHidesBackButton:TRUE];
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.api.delegate = self;
    [appDelegate.api getToken];

    //S[api getToken];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestConnexionApp:(BOOL) connexionApp{
    if(!connexionApp){
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Problème" message:@"L'application est actuellement en maintenance" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* validateAction = [UIAlertAction actionWithTitle:@"Validate" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        }];
        [alertController addAction:validateAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void) requestConnexionUser:(BOOL) connexionUser{
    if(connexionUser){
        ListXmazonController* viewController = [[ListXmazonController alloc] initWithNibName: @"ListXmazonController"bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else{
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Authentification" message:@"Adresse Mail ou mot de passe incorrecte" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* validateAction = [UIAlertAction actionWithTitle:@"Validate" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        }];
        [alertController addAction:validateAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)btnLogin:(id)sender {
    NSString* email;
    NSString* password;
    email = [self.lableEmail text];
    password = [self.labelPassword text];
    [appDelegate.api getTokenUser:email andPassword:password];
    
}

- (IBAction)btnSubscribe:(id)sender {
    NSLog(@"bonjour");
    
    
    PopUpViewController* viewController = [[PopUpViewController alloc] initWithNibName: @"PopUpViewController"bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
        //self.navigationController.definesPresentationContent = YES;
    /*viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:viewController animated:YES completion:nil];*/
     

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
