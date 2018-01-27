//
//  StringDefine.h
//  BaseProject
//
//  Created by Tinhvv on 4/20/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#ifndef StringDefine_h
#define StringDefine_h
//MARK: - APPID
#define YOUR_APP_STORE_ID 1323395641 //Change this one to your ID

//MARK: - API
static NSString * const kPOST                           = @"POST";
static NSString * const kGET                            = @"GET";
static NSString * const KDELETE                         = @"DELETE";
static NSString * const kPUT                            = @"PUT";

//MARK: - API Path
static NSString * const kPathRegister                   = @"api/register";
static NSString * const kPathLogin                      = @"api/auth";
// API MCAR
static NSString * const KPathAccountKit                 = @"login/accountkit";
static NSString * const KPathFBLogin                    = @"login/facebook";
static NSString * const KPathGoogleLogin                = @"login/google";

// search garage
static NSString * const kPatchSearchGara                = @"garage/search";
//detail garage
static NSString * const kPatchGarageDetail              = @"garage";
// booking
static NSString * const kPathBooking                    = @"booking";

// parking
static NSString * const kPatchParking                   = @"parking/around";
// news notify
static NSString * const kPatchNews                      = @"notification";
//history user
static NSString * const kPathHistory                    = @"history";
//user info
static NSString * const kPathUser                       = @"user";
//user car
static NSString * const kPathUserCar                    = @"user/car";
// car brand
static NSString * const kPathCarBrand                    = @"car/brand";


// Register
static NSString * const kUserName                       = @"username";
static NSString * const kPassword                       = @"password";
static NSString * const kNickName                       = @"nickname";
static NSString * const kEmail                          = @"email";
static NSString * const kComment                        = @"comment";


static NSString *const kDeviceID                        = @"device_code";
static NSString *const kDeviceVersion                   = @"device_version";
static NSString *const kDevicePlatform                  = @"device_platform";
static NSString *const kDeviceName                      = @"device_name";
static NSString *const kAppType                         = @"app_type";

static NSString * const kSandboxMode                     = @"sandbox_mode";

#endif /* StringDefine_h */
