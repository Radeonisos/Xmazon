#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ApiRequest.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString* urlList=@"store/list";
        NSString* urlCategory=@"/category/list?store_uid=";
        NSString* urlProduct=@"/product/list?category_uid=";
        
        /*ApiRequest* api = [ApiRequest alloc];
         [api getToken];
         NSMutableArray* resultArray = [api getApi:urlList];
         NSLog(@"Resultat du tableau des stores %@",resultArray);
         NSString *authValue = [NSString stringWithFormat:@"%@%@",urlCategory,([[resultArray objectAtIndex:0] objectForKey:@"uid"])];
         NSMutableArray* resultArray2 = [api getApi:authValue];
         NSLog(@"Resultat du tableau des categorie : %@",resultArray2);
         [api postApi];*/
        //[api getTokenUser];
        
        
        
        /*NSString *authValue2 = [NSString stringWithFormat:@"%@%@",urlProduct,([[resultArray2 objectAtIndex:1] objectForKey:@"uid"])];
         NSMutableArray* resultArray3 = [api getApi:authValue2];
         NSLog(@"Resultat du tableau des produit : %@",resultArray3);*/
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
