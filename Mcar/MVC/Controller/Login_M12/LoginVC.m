//
//  LoginVC.m
//  Mcar
//
//  Created by thanh tung on 9/27/17.
//  Copyright © 2017 thanh tung. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
AKFAccountKit *_accountKit;
UIViewController<AKFViewController> *_pendingLoginViewController;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark configUI
-(void)configUI{
    self.phoneView.layer.cornerRadius = 5;
    self.facebookView.layer.cornerRadius = 5;
    self.googleView.layer.cornerRadius = 5;
    
    // config accountkit facebook
    if (_accountKit == nil) {
        // may also specify AKFResponseTypeAccessToken
        _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAccessToken];
        
    }
    
    // view controller for resuming login
    _pendingLoginViewController = [_accountKit viewControllerForLoginResume];
    // google login config
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;

}

#pragma mark accountkit facebook
- (void)prepareLoginViewController:(UIViewController<AKFViewController> *)loginViewController
{
    loginViewController.delegate = self;
    // Optionally, you may use the Advanced UI Manager or set a theme to customize the UI.
    loginViewController.advancedUIManager = nil;
    loginViewController.theme = [self customTheme];
}

- (AKFTheme *)customTheme
{
    AKFTheme *theme = [AKFTheme outlineThemeWithPrimaryColor:[[MCGlobal shareGlobal] colorFromHexString:@"0xffff5a5f"]
                                            primaryTextColor:[UIColor blackColor]
                                          secondaryTextColor:[UIColor blackColor]
                                              statusBarStyle:UIStatusBarStyleLightContent];
    //theme.backgroundImage = [UIImage imageNamed:@"bicycle"];
    theme.headerBackgroundColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed2f41"];
    theme.headerTextColor = [UIColor whiteColor];
    theme.headerButtonTextColor = [UIColor whiteColor];
    theme.backgroundColor = [UIColor whiteColor];//[[MCGlobal shareGlobal] colorWithHex:0x66000000];
    theme.inputBackgroundColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ffffff"];
    theme.inputBorderColor = [UIColor blackColor];
    theme.buttonBackgroundColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed2f41"];
    theme.buttonTextColor = [UIColor whiteColor];
    theme.buttonBorderColor = [[MCGlobal shareGlobal] colorFromHexString:@"#ed2f41"];
    return theme;
}

#pragma mark - AccountKitDelegate
// handle callbacks on successful login to show account
- (void) viewController:(UIViewController<AKFViewController> *)viewController
  didCompleteLoginWithAccessToken:(id<AKFAccessToken>)accessToken
                            state:(NSString *)state
{
    NSLog(@"access token: %@",accessToken.tokenString);
    [self sendAuthorizationCodeToServer:accessToken.tokenString andType:ACCOUNTKITLOGIN];
}


- (void)viewControllerDidCancel:(UIViewController<AKFViewController> *)viewController{
    NSLog(@"cancel login phone");
}

#pragma mark Network
- (void)sendAuthorizationCodeToServer:(NSString *)code andType:(loginType)typeLogin{
    
    if (typeLogin == ACCOUNTKITLOGIN) {
        NSDictionary *param = @{@"accountkit_access_token":code};
        [self.networkManager requestLoginAccountKit:param completion:^(NSDictionary *responseDict) {
            [self partDataFromJsonLogin:responseDict];
        }];
    }else if (typeLogin == FACEBOOKLOGIN){
        NSDictionary *param = @{@"facebook_access_token":code};
        [self.networkManager requestLoginFacebook:param completion:^(NSDictionary *responseDict) {
            [self partDataFromJsonLogin:responseDict];
        }];
    }else if (typeLogin == GOOGLELOGIN){
        NSDictionary *param = @{@"google_access_token":code};
        [self.networkManager requestLoginGoogle:param completion:^(NSDictionary *responseDict) {
            [self partDataFromJsonLogin:responseDict];
        }];
    }
    
    
}

#pragma mark google delegate
-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    NSLog(@"authorcode: %@",user.authentication.idToken);
    
    [self sendAuthorizationCodeToServer:user.authentication.idToken andType:GOOGLELOGIN];
}


- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}

// Present a view that prompts the user to sign in with Google
//- (void)signIn:(GIDSignIn *)signIn
//presentViewController:(UIViewController *)viewController {
//    [self presentViewController:viewController animated:YES completion:nil];
//}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark moreFunction
-(void)partDataFromJsonLogin:(NSDictionary*)responseDict{
    NSError *error;
    LoginApiJsonModel *loginApiJson = [[LoginApiJsonModel alloc]initWithDictionary:responseDict error:&error];
    if ([loginApiJson.status intValue] == 1) {
        DataLoginJsonModel *dataJson = loginApiJson.data;
        UserJsonModel *userJson = dataJson.user;
        self.session.uniqueToken = dataJson.api_token;
        self.session.userId = userJson.user_id;
        self.session.userEmail = userJson.email;
        self.session.userPhone = userJson.phone;
        self.session.userFullName = userJson.name;
        self.session.userImageAvataUrl = userJson.avatar;
        self.session.isAuthenticated = YES;
        if ([[MCGlobal shareGlobal] stringIsNilOrEmpty:self.session.userImageAvataUrl]){
            self.session.imageFromUrl = NO;
        }else{
            self.session.imageFromUrl = YES;
        }
        self.session.dateOfBirth = userJson.birthday;
        [self.session save];
        UIViewController *selfPresentView = self.presentingViewController;
        if ([userJson.is_updated_info intValue] == 0) {
            [self dismissViewControllerAnimated:NO completion:^{
                dispatch_async(dispatch_get_main_queue(), ^(){
                    //UserVC *userVC = [[UserVC alloc]init];
                    UpdateInfoUserVC *updateInfoVC = [[UpdateInfoUserVC alloc] init];
                    updateInfoVC.userJsonModel = userJson;
                    [selfPresentView presentViewController:updateInfoVC animated:YES completion:nil];
                });
            }];
        }else{
            [self dismissViewControllerAnimated:NO completion:^{
                dispatch_async(dispatch_get_main_queue(), ^(){
                    UserVC *userVC = [[UserVC alloc]init];
                    [selfPresentView presentViewController:userVC animated:YES completion:nil];
                });
            }];
        }
        
    }else{
        [[MCGlobal shareGlobal] showMessage:@"Có lỗi xảy ra trong quá trình đăng nhập. Mời bạn hãy thử lại sau." inView:self];
    }
}

#pragma mark IBAction

- (IBAction)dismissView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginPhoneButTap:(UIButton *)sender {
    NSString *preFillPhoneNumber = nil;
    AKFPhoneNumber *phoneNumber  = [[AKFPhoneNumber alloc]initWithCountryCode:@"+84" phoneNumber:preFillPhoneNumber];
    NSString *inputState = [[NSUUID UUID] UUIDString];
    UIViewController<AKFViewController> *viewController = [_accountKit viewControllerForPhoneLoginWithPhoneNumber:phoneNumber
                                                                                                            state:inputState];
    viewController.delegate = self;
    // Optionally, you may use the Advanced UI Manager or set a theme to customize the UI.
    
    viewController.enableSendToFacebook = NO; // defaults to NO
    [self prepareLoginViewController:viewController];
    [self presentViewController:viewController animated:YES completion:NULL];
}

- (IBAction)facebookLoginButtonTap:(UIButton *)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSString *fbToken = [FBSDKAccessToken currentAccessToken].tokenString;
             NSLog(@"fb token: %@",fbToken);
             [self sendAuthorizationCodeToServer:fbToken andType:FACEBOOKLOGIN];
         }
     }];
}

- (IBAction)googleLoginButtonTap:(UIButton *)sender {
    [[GIDSignIn sharedInstance]signIn];
}

@end
