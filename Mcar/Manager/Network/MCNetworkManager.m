//
//  MCNetworkManager.m
//  BaseProject
//
//  Created by Tinhvv on 8/12/16.
//  Copyright © 2016 Tinhvv. All rights reserved.
//

#import "MCNetworkManager.h"
#import "MCGlobal.h"

@implementation MCNetworkManager
+ (instancetype)sharedService {
    static MCNetworkManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MCNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:K_SERVER_URL]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        // Add missing accept content types
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"text/html"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"text/html"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
        // Add missing accept content types
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"application/xml"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"application/xml"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"text/plain"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"text/plain"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
        if (![self.responseSerializer.acceptableContentTypes containsObject:@"application/json"]) {
            NSMutableSet *acceptableTypes = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
            [acceptableTypes addObject:@"application/json"];
            [self.responseSerializer setAcceptableContentTypes:acceptableTypes];
        }
        
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
        [self.requestSerializer setTimeoutInterval:30];
        
    }
    
    
    return self;
}

#pragma mark - Base functions

- (NSURLSessionDataTask *)callWebserviceWithPath:(NSString *)path
                                          method:(NSString *)method
                                      parameters:(NSDictionary *)parameters
                                      completion:(void (^) (NSDictionary *responseObject))completion {

    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path];
    NSLog(@"path = %@ --- Params = %@",request.URL,parameters);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (request) {

        NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:completion];
        [task resume];
        return task;
    }
    return nil;

}

- (NSURLSessionDataTask *)callWebserviceRawWithPath:(NSString *)path
                                          method:(NSString *)method
                                      parameters:(NSDictionary *)parameters
                                      completion:(void (^) (NSDictionary *responseObject))completion {
    NSError *error;      // Initialize NSError
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];  // Convert your parameter to NSDATA
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];  // Convert data into string using NSUTF8StringEncoding
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];  // make NSMutableURL req
    NSLog(@"path = %@ --- Params = %@",request.URL,parameters);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue]; // add paramerets to NSMutableURLRequest
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];

    if (request) {
        NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:completion];
        [task resume];
        return task;
    }
    return nil;
    
}


- (NSURLSessionDataTask *)callWebserviceWithPath:(NSString *)path
                                          method:(NSString *)method
                                      parameters:(NSDictionary *)parameters
                                       filesData:(NSArray *)filesData
                                       fileNames:(NSArray *)fileNames
                            fileDescriptionNames:(NSArray *)descriptionNames
                                      completion:(void (^) (NSDictionary *responseDict))completion {
    
    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path filesData:filesData fileNames:fileNames fileDescriptionNames:descriptionNames];
    NSLog(@"path = %@ --- Params = %@",request.URL,parameters);
    if (request) {
        NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:^(NSDictionary *responseDict) {
            
        }];
        //NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:completion];
        [task resume];
        
        return task;
    }
    return nil;
}

- (NSURLSessionDataTask *)callWebserviceWithPath:(NSString *)path
                                          method:(NSString *)method
                                      parameters:(NSDictionary *)parameters
                                       filesData:(NSData *)filesData
                                        fileName:(NSString *)fileName
                             fileDescriptionName:(NSString *)descriptionName
                                      completion:(void (^) (NSDictionary *responseDict))completion {
    
    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path filesData:filesData fileName:fileName fileDescriptionName:descriptionName];
    NSLog(@"path = %@ --- Params = %@",request.URL,parameters);
    if (request) {
        NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:^(NSDictionary *responseDict) {
            if (completion) {
                completion(responseDict);
            }
        }];
        //NSURLSessionDataTask* task = [self dataTaskWithRequest:request completion:completion];
        [task resume];
        
        return task;
    }
    return nil;
}

- (NSURLSessionDataTask*)dataTaskWithRequest:(NSURLRequest *)request completion:(void (^) (NSDictionary *responseDict))completion {
    return [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //        NSLog(@"response: %@ responseObject: %@, error: %@", response, responseObject, error);
        //MCResponseObject* responseObj = [MCResponseObject responseObjectWithResponse:(NSHTTPURLResponse*)response responseObject:responseObject error:error];
        NSError *errorDict;
        if (responseObject) {
            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                         options:kNilOptions
                                                                           error:&errorDict];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            if (completion) {
                completion(responseDict);
            }
        }
    }];
}

/**
 Create request for special method, parameters and path
 @param method The HTTP method for the request
 @param parameters The parameters that will be include to the request
 @param path The url for the request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                      path:(NSString *)path {
    // 1
    NSError *error;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:parameters
                                                                       error:&error];
    return request;
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                      path:(NSString *)path
                                 filesData:(NSArray *)filesData
                                 fileNames:(NSArray *)fileNames
                      fileDescriptionNames:(NSArray *)descriptionNames {
    // 1
    NSError *error;
    NSMutableURLRequest *request = nil;
    
    if (filesData != nil) { // Request with data file
        if (filesData.count != fileNames.count || fileNames.count != descriptionNames.count || descriptionNames.count != filesData.count) {
            return nil;
        }
        request = [self.requestSerializer multipartFormRequestWithMethod:method
                                                               URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                              parameters:parameters
                                               constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
                                                   
                                                   for (int i = 0; i < filesData.count; i++) {
                                                       
                                                       [formData appendPartWithFileData:[filesData objectAtIndex:i]
                                                                                   name:[fileNames objectAtIndex:i]
                                                                               fileName:[descriptionNames objectAtIndex:i]
                                                                               mimeType:@"image/png"];
                                                   }
                                               }
                                                                   error:&error];
        
    }
    else { // Normal request
        [self.requestSerializer requestWithMethod:method
                                        URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                       parameters:parameters
                                            error:&error];
    }
    
    return request;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                      path:(NSString *)path
                                 filesData:(NSData *)filesData
                                  fileName:(NSString *)fileName
                       fileDescriptionName:(NSString *)descriptionName {
    // 1
    NSError *error;
    NSMutableURLRequest *request = nil;
    
    if (filesData != nil) { // Request with data file
        request = [self.requestSerializer multipartFormRequestWithMethod:method
                                                               URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                              parameters:parameters
                                               constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
                                                   
                                                   [formData appendPartWithFileData:filesData
                                                                               name:fileName
                                                                           fileName:descriptionName
                                                                           mimeType:@"image/png"];
                                                   
                                               }
                                                                   error:&error];
        
    }
    else { // Normal request
        [self.requestSerializer requestWithMethod:method
                                        URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                       parameters:parameters
                                            error:&error];
    }

    return request;
}

#pragma mark - Auth
- (void) resgisterWithEmail:(NSString *)loginId
                   password:(NSString *)password
                   nickname:(NSString *)nickName
                      email:(NSString *)email
                    comment:(NSString *)comment
                 completion:(void (^) (NSDictionary *responseDict))completion{
    NSDictionary *params = @{
                             kUserName:loginId,
                             kPassword: password,
                             kNickName:nickName,
                             kEmail: email,
                             kComment: comment,
                             };

    [self callWebserviceWithPath:kPathRegister method:kPOST parameters:params completion:completion];
}


- (void)loginWithEmail:(NSString *)userName
              password:(NSString *)password
            completion:(void (^)(NSDictionary *responseDict))completion{
    
    NSDictionary *params = @{kUserName:userName,
                             kPassword:password,
                             kSandboxMode:@SANDBOX_MODE
                             };
    [self callWebserviceWithPath:kPathLogin method:kPOST parameters:params completion:completion];
}

- (void)requestLoginAccountKit:(NSDictionary*)param
                    completion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceRawWithPath:KPathAccountKit method:kPOST parameters:param completion:completion];
}

- (void)requestLoginFacebook:(NSDictionary*)param
                  completion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceRawWithPath:KPathFBLogin method:kPOST parameters:param completion:completion];
}

- (void)requestLoginGoogle:(NSDictionary*)param
                  completion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceRawWithPath:KPathGoogleLogin method:kPOST parameters:param completion:completion];
}

- (void)requestSearchGarageList:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPatchSearchGara method:kGET parameters:param completion:completion];
}

- (void)requestGetDetailGarage:(int)idGarage
                         param:(NSDictionary*)param
                     comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *kpatchDetailGarage = [NSString stringWithFormat:@"%@/%d",kPatchGarageDetail,idGarage];
    [self callWebserviceWithPath:kpatchDetailGarage method:kGET parameters:param completion:completion];
}



- (void)requestGeParking:(NSDictionary*)param
               comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPatchParking method:kGET parameters:param completion:completion];
}

- (void)requestGetNewsNotify:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPatchNews method:kGET parameters:param completion:completion];
}

- (void)requestPostComment:(NSNumber*)idGara
                 parameter:(NSDictionary*)param
                    comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *postCommentPath = [NSString stringWithFormat:@"%@/%@/comment",kPatchGarageDetail,idGara];
    [self callWebserviceRawWithPath:postCommentPath method:kPOST parameters:param completion:completion];
}

- (void)requestPostRating:(NSNumber*)idGara
                 parameter:(NSDictionary*)param
                 comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *postRatingPath = [NSString stringWithFormat:@"%@/%@/rate",kPatchGarageDetail,idGara];
    [self callWebserviceRawWithPath:postRatingPath method:kPOST parameters:param completion:completion];
}

- (void)requestPostBookMark:(NSNumber*)idGara
                parameter:(NSDictionary*)param
                comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *postBookMarkPath = [NSString stringWithFormat:@"%@/%@/bookmark",kPatchGarageDetail,idGara];
    [self callWebserviceRawWithPath:postBookMarkPath method:kPOST parameters:param completion:completion];
}

- (void)requestGetHistory:(NSDictionary*)param
                       comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPathHistory method:kGET parameters:param completion:completion];
}

- (void)requestGetHistorySchedule:(NSDictionary*)param
                comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *kPathHistoryBooking = [NSString stringWithFormat:@"%@/remain",kPathBooking];
    [self callWebserviceWithPath:kPathHistoryBooking method:kGET parameters:param completion:completion];
}

- (void)requestRemoveSchedule:(NSNumber*)idGara
                  parameter:(NSDictionary*)param
                  comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *removeSchedulePath = [NSString stringWithFormat:@"%@/%@/cancel",kPathBooking,idGara];
    [self callWebserviceRawWithPath:removeSchedulePath method:kPOST parameters:param completion:completion];
}

- (void)requestPutUpdateUserInfo:(NSDictionary*)param
                       comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceRawWithPath:kPathUser method:kPUT parameters:param completion:completion];
}

- (void)requestAddCarForUser:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceRawWithPath:kPathUserCar method:kPOST parameters:param completion:completion];
}

- (void)requestGetCarBrand:(NSDictionary*)param
                 comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPathCarBrand method:kGET parameters:param completion:completion];
}

- (void)requestGetCarsOfUSer:(NSDictionary*)param
                   comletion:(void(^)(NSDictionary *responseDict))completion{
    [self callWebserviceWithPath:kPathUserCar method:kGET parameters:param completion:completion];
}

- (void)PostBookingGarage:(NSDictionary*)param
                andIdGara:(NSNumber*)idGara
                comletion:(void(^)(NSDictionary *responseDict))completion{
    NSString *bookingGaraPath = [NSString stringWithFormat:@"%@/%d/booking",kPatchGarageDetail,[idGara intValue]];
    [self callWebserviceRawWithPath:bookingGaraPath method:kPOST parameters:param completion:completion];
    
}

@end
