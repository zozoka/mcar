//
//  MCNetworkManager.h
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "MCResponseObject.h"

@interface MCNetworkManager : AFHTTPSessionManager
+ (instancetype)sharedService;

#pragma mark - Auth
- (void) resgisterWithEmail:(NSString *)loginId
                   password:(NSString *)password
                   nickname:(NSString *)nickName
                      email:(NSString *)email
                    comment:(NSString *)comment
                 completion:(void (^) (NSDictionary *responseDict))completion;

- (void) loginWithEmail:(NSString *)userName
               password:(NSString *)password
             completion:(void (^) (NSDictionary *responseDict))completion;


- (NSURLSessionDataTask *)callWebserviceWithPath:(NSString *)path
                                          method:(NSString *)method
                                      parameters:(NSDictionary *)parameters
                                       filesData:(NSData *)filesData
                                        fileName:(NSString *)fileName
                             fileDescriptionName:(NSString *)descriptionName
                                      completion:(void (^) (NSDictionary *responseDict))completion;

// login with accountkit
- (void)requestLoginAccountKit:(NSDictionary*)param
                    completion:(void(^)(NSDictionary *responseDict))completion;
// login with facebook
- (void)requestLoginFacebook:(NSDictionary*)param
                  completion:(void(^)(NSDictionary *responseDict))completion;
// login with google
- (void)requestLoginGoogle:(NSDictionary*)param
                completion:(void(^)(NSDictionary *responseDict))completion;
// get list garage
- (void)requestSearchGarageList:(NSDictionary*)param
                      comletion:(void(^)(NSDictionary *responseDict))completion;
//get detail garage
- (void)requestGetDetailGarage:(int)idGarage
                         param:(NSDictionary*)param
                     comletion:(void(^)(NSDictionary *responseDict))completion;
//get history booking
- (void)requestGetHistory:(NSDictionary*)param
                       comletion:(void(^)(NSDictionary *responseDict))completion;
//get parking place
- (void)requestGeParking:(NSDictionary*)param
               comletion:(void(^)(NSDictionary *responseDict))completion;
//get news
- (void)requestGetNewsNotify:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion;
//add comment
- (void)requestPostComment:(NSNumber*)idGara
                 parameter:(NSDictionary*)param
                 comletion:(void(^)(NSDictionary *responseDict))completion;
// rating api
- (void)requestPostRating:(NSNumber*)idGara
                parameter:(NSDictionary*)param
                comletion:(void(^)(NSDictionary *responseDict))completion;
// bookmark api
- (void)requestPostBookMark:(NSNumber*)idGara
                  parameter:(NSDictionary*)param
                  comletion:(void(^)(NSDictionary *responseDict))completion;
//schedule api
- (void)requestGetHistorySchedule:(NSDictionary*)param
                        comletion:(void(^)(NSDictionary *responseDict))completion;
//cancel schedule
- (void)requestRemoveSchedule:(NSNumber*)idGara
                    parameter:(NSDictionary*)param
                    comletion:(void(^)(NSDictionary *responseDict))completion;
// user
- (void)requestPutUpdateUserInfo:(NSDictionary*)param
                       comletion:(void(^)(NSDictionary *responseDict))completion;
// add new car for user
- (void)requestAddCarForUser:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion;
// get all card brand
- (void)requestGetCarBrand:(NSDictionary*)param
                 comletion:(void(^)(NSDictionary *responseDict))completion;
// get all car of user
- (void)requestGetCarsOfUSer:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion;
- (void)PostBookingGarage:(NSDictionary*)param
                andIdGara:(NSNumber*)idGara
                comletion:(void(^)(NSDictionary *responseDict))completion;
@end
